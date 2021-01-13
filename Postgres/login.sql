CREATE DATABASE login

CREATE EXTENSION pgcrypto;

CREATE EXTENSION pgjwt;

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
);

ALTER TABLE public.session
    OWNER to postgres;

CREATE TABLE public.users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    role text COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id)
);

ALTER TABLE public.users
    OWNER to postgres;

insert into users (name, password, role) values ('owner1', 'pwd', 'owner');

insert into users (name, password, role) values ('director1', 'pwd', 'director1');

insert into users (name, password, role) values ('manager1', 'pwd', 'manager1');

insert into users (name, password, role) values ('manager2', 'pwd', 'manager2');

insert into users (name, password, role) values ('manager3', 'pwd', 'manager3');

insert into users (name, password, role) values ('jimmy', 'pwd', 'emp1');

insert into users (name, password, role) values ('kimmy', 'pwd', 'emp1');

insert into users (name, password, role) values ('limmy', 'pwd', 'emp1');

insert into users (name, password, role) values ('mimmy', 'pwd', 'guest');
