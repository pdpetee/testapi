CREATE DATABASE login
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Malaysia.1252'
    LC_CTYPE = 'English_Malaysia.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

CREATE SCHEMA information_schema
    AUTHORIZATION postgres;

GRANT CREATE ON SCHEMA information_schema TO postgres;

CREATE SCHEMA pg_catalog
    AUTHORIZATION postgres;

COMMENT ON SCHEMA pg_catalog
    IS 'system catalog schema';

GRANT CREATE ON SCHEMA pg_catalog TO postgres;

CREATE EXTENSION pgcrypto
    SCHEMA public
    VERSION "1.3";

CREATE EXTENSION pgjwt
    SCHEMA public
    VERSION "0.1.0";

CREATE EXTENSION plpgsql
    SCHEMA pg_catalog
    VERSION "1.0";

    CREATE TRUSTED PROCEDURAL LANGUAGE plpgsql
    HANDLER plpgsql_call_handler
    INLINE plpgsql_inline_handler
    VALIDATOR plpgsql_validator;

ALTER LANGUAGE plpgsql
    OWNER TO postgres;

COMMENT ON LANGUAGE plpgsql
    IS 'PL/pgSQL procedural language';

    CREATE SCHEMA public
    AUTHORIZATION postgres;

COMMENT ON SCHEMA public
    IS 'standard public schema';

GRANT ALL ON SCHEMA public TO PUBLIC;

GRANT ALL ON SCHEMA public TO postgres;

CREATE SEQUENCE public.session_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

ALTER SEQUENCE public.session_id_seq
    OWNER TO postgres;

CREATE SEQUENCE public.users_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

ALTER SEQUENCE public.users_id_seq
    OWNER TO postgres;

CREATE TABLE public.session
(
    id integer NOT NULL DEFAULT nextval('session_id_seq'::regclass),
    user_id integer NOT NULL,
    token uuid NOT NULL DEFAULT gen_random_uuid(),
    CONSTRAINT session_pkey PRIMARY KEY (id),
    CONSTRAINT session_token_key UNIQUE (token),
    CONSTRAINT session_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.session
    OWNER to postgres;

CREATE TABLE public.users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    role text COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.users
    OWNER to postgres;

insert into users (name, password, role) values ('owner1', 'pwd', 'owner')

insert into users (name, password, role) values ('director1', 'pwd', 'director1')

insert into users (name, password, role) values ('director2', 'pwd', 'director2')

insert into users (name, password, role) values ('manager1', 'pwd', 'manager1')

insert into users (name, password, role) values ('manager2', 'pwd', 'manager2')

insert into users (name, password, role) values ('manager3', 'pwd', 'manager3')

insert into users (name, password, role) values ('jimmy', 'pwd', 'emp1')

insert into users (name, password, role) values ('kimmy', 'pwd', 'emp1')

insert into users (name, password, role) values ('limmy', 'pwd', 'emp1')

insert into users (name, password, role) values ('mimmy', 'pwd', 'guest')