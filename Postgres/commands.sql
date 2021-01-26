create function getauth(out token uuid) as $$
begin
select nullif(current_setting('public.auth_token'), '') into token;
exception when undefined_object then
end;
$$ language plpgsql stable;




create function setauth(token text) returns uuid as $$
begin
perform set_config('public.auth_token', token, false);
return getauth();
end;
$$ language plpgsql;




create function token2user(_token text, out _user_id int) as $$
begin
select user_id from session where token = _token::uuid into _user_id;
if _user_id is null then
raise 'AUTH_TOKEN_INVALID:NOEXIST';
END IF;
END;
$$ LANGUAGE plpgsql security definer;





create function curuser() returns int as $$
declare
token uuid;
begin
select getauth() into token;
return case when token is null then null else token2user(token::text) end;
end;
$$ language plpgsql stable;



create or replace function createjwt(_is_refresh_token boolean, _session_token uuid, _user_id integer, _role text, out _jwt text) as $$
declare
_tokenheader json;
_expire text;
	begin
	if not _is_refresh_token then
	select (now()::timestamp + interval '1 minutes')::text into _expire;
	end if;
	if _is_refresh_token then
	select (now()::timestamp + interval '1 day')::text into _expire;
	end if;
	select concat('{"session_token":"',_session_token,'","user_id":',_user_id,',"role":"', _role, '","expire":"', _expire,'"}') into _tokenheader;
	select sign(_tokenheader, 'secretkey') into _jwt;
	end;
	$$ language plpgsql stable;

create or replace function verifyjwt(jwt text, out is_token_valid boolean) as $$
declare
	is_secret_valid boolean;
	json_body text;
	_expiry_date text;
	_current_date text;
	_token text;
	
	begin
	select valid from verify(jwt, 'secretkey') into is_secret_valid;
	if is_secret_valid then
	select payload from verify(jwt, 'secretkey') into json_body;
	select * from json_extract_path(json_body::json, 'expire') into _expiry_date;
	select now()::timestamp into _current_date;
	if _current_date::timestamp < _expiry_date::timestamp then
	is_token_valid := true;
	else
	select json_body::json ->> 'session_token' into _token;
	delete from session where token = _token::uuid;
	is_token_valid := false;
	end if;
	end if;
	end;
	$$ language plpgsql volatile;


create function login(_name text, _password text, out _jwt text) as $$
declare 
_user users;
_token uuid;
	begin
	select * from users where name = _name into _user;
	if _user is null or
	_password != _user.password
	then
		raise 'INVALID_LOGIN';
	else
		insert into session (user_id) values (_user.id)
		returning token into _token;
	perform setauth(_token::text);
	select createjwt(_token, _user.id, _user.role) into _jwt;
	end if;
	end;
$$ language plpgsql security definer;

create function login(_is_refresh boolean, _name text, _password text, out _jwt text) as $$
declare 
_user users;
_token uuid;
	begin
	select * from users where name = _name into _user;
	if _user is null or
	_password != _user.password
	then
		raise 'INVALID_LOGIN';
	else
		insert into session (user_id) values (_user.id)
		returning token into _token;
	perform setauth(_token::text);
	select createjwt(_is_refresh, _token, _user.id, _user.role) into _jwt;
	end if;
	end;
$$ language plpgsql security definer;

create function login(inout _token uuid) as $$
begin
perform setauth(NULL);
perform token2user(_token);
perform setauth(_token::text);
end;
$$ language plpgsql security definer;a



create function logout(_token text default getauth()) returns void as $$
begin
begin
delete from session where token = _token::uuid;
exception when others then end;
perform setauth(NULL);
end;
$$ language plpgsql security definer;


eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uX3Rva2VuIjoiMmM0OGIzN2ItYTc5Ny00ZDBjLWExZmUtZjlhMWI1YTIyMzkxIiwidXNlcl9pZCI6MSwicm9sZSI6Im93bmVyIiwiZXhwaXJlIjoiMjAyMS0wMS0yNSAxNzo0OTowOC4wNzA1NDkifQ.VgdedseiFsxGRIwYt82_-pyAFI4_uYSsoU2_RqeQyRo