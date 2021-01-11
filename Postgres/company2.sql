CREATE DATABASE company2
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Malaysia.1252'
    LC_CTYPE = 'English_Malaysia.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

GRANT CONNECT ON DATABASE company2 TO manager3;

GRANT ALL ON DATABASE company2 TO postgres;

GRANT CONNECT, TEMPORARY ON DATABASE company2 TO PUBLIC;

CREATE SCHEMA information_schema
    AUTHORIZATION postgres;

GRANT CREATE ON SCHEMA information_schema TO postgres;

CREATE SCHEMA pg_catalog
    AUTHORIZATION postgres;

COMMENT ON SCHEMA pg_catalog
    IS 'system catalog schema';

GRANT CREATE ON SCHEMA pg_catalog TO postgres;

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

    CREATE SCHEMA department3
    AUTHORIZATION postgres;

GRANT USAGE ON SCHEMA department3 TO director2;

GRANT ALL ON SCHEMA department3 TO postgres;



