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



create function createjwt(_session_token uuid, _user_id integer, _role text, out _jwt text) as $$
declare
_tokenheader json;
	begin
	select concat('{"session_token":"',_session_token,'","user_id":',_user_id,',"role":"', _role, '"}') into _tokenheader;
	select sign(_tokenheader, 'secretkey') into jwt;
	end;
	$$ language plpgsql stable;


create function hashpass(password text, salt text default gen_salt('bf', 8))
returns text as 'select crypt(password, salt)' language sql;

create function verifyjwt(jwt text, out isTokenValid boolean) as $$
	begin
	select valid from verify(jwt, 'secretkey') into isTokenValid;
	end;
	$$ language plpgsql stable;

create function getRoleFromjwt(jwt text, out role text) as $$
	begin
	select valid from verify(jwt, 'secretkey') into role;
	end;
	$$ language plpgsql stable;


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








create function login(inout _token uuid) as $$
begin
perform setauth(NULL);
perform token2user(_token);
perform setauth(_token::text);
end;
$$ language plpgsql security definer;






create function logout(_token text default getauth()) returns void as $$
begin
begin
delete from session where token = _token::uuid;
exception when others then end;
perform setauth(NULL);
end;
$$ language plpgsql security definer;

CREATE POLICY guest_rls_policy
    ON department1.employee
    AS PERMISSIVE
    FOR SELECT
    TO guest
    USING (true);