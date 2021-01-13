CREATE DATABASE company1;

GRANT CONNECT ON DATABASE company1 TO owner;

GRANT ALL ON DATABASE company1 TO director1;

GRANT ALL ON DATABASE company1 TO postgres;

GRANT CONNECT ON DATABASE company1 TO manager2;

GRANT CONNECT ON DATABASE company1 TO emp1;

GRANT CONNECT ON DATABASE company1 TO guest;

GRANT CONNECT ON DATABASE company1 TO manager1;

CREATE SCHEMA department1

GRANT USAGE ON SCHEMA department1 TO director1;

GRANT USAGE ON SCHEMA department1 TO emp1;

GRANT USAGE ON SCHEMA department1 TO guest;

GRANT USAGE ON SCHEMA department1 TO manager1;

GRANT ALL ON SCHEMA department1 TO postgres;

CREATE SEQUENCE department1.employee_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

ALTER SEQUENCE department1.employee_id_seq
    OWNER TO postgres;

CREATE TABLE department1.employee
(
    id integer NOT NULL DEFAULT nextval('department1.employee_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    salary real,
    CONSTRAINT employee_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE department1.employee
    ENABLE ROW LEVEL SECURITY;

GRANT ALL ON TABLE department1.employee TO director1;

GRANT SELECT ON TABLE department1.employee TO emp1;

GRANT ALL ON TABLE department1.employee TO manager1;

GRANT ALL ON TABLE department1.employee TO postgres;

GRANT SELECT(name) ON department1.employee TO guest;
-- POLICY: emp_rls_policy

-- DROP POLICY emp_rls_policy ON department1.employee;

CREATE POLICY emp_rls_policy
    ON department1.employee
    AS PERMISSIVE
    FOR ALL
    TO emp1
    USING ((id = (current_setting('my.userid'::text))::integer));


CREATE POLICY guest_rls_policy
    ON department1.employee
    AS PERMISSIVE
    FOR SELECT
    TO guest
    USING (true);

CREATE POLICY manager_rls_policy
    ON department1.employee
    AS PERMISSIVE
    FOR ALL
    TO manager1
    USING (true);

CREATE SCHEMA department2
    AUTHORIZATION postgres;

GRANT USAGE ON SCHEMA department2 TO director1;

GRANT USAGE ON SCHEMA department2 TO manager2;

GRANT ALL ON SCHEMA department2 TO postgres;
                                  
CREATE SEQUENCE department2.employee_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE department2.employee
(
    id integer NOT NULL DEFAULT nextval('department2.employee_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    salary real NOT NULL,
    CONSTRAINT employee_pkey PRIMARY KEY (id)
);

ALTER TABLE department2.employee
    OWNER to postgres;

GRANT ALL ON TABLE department2.employee TO director1;

GRANT SELECT ON TABLE department2.employee TO emp2;

GRANT ALL ON TABLE department2.employee TO manager2;

GRANT ALL ON TABLE department2.employee TO postgres;

insert into department1.employee (id, name, salary) values (7, 'jimmy', 123);

insert into department1.employee (id, name, salary) values (8, 'kimmy', 234);

insert into department1.employee (id, name, salary) values (9, 'limmy', 345);
