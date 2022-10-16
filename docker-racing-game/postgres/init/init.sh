#!/bin/bash
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL

  CREATE ROLE core WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  PASSWORD '1xbn1URIwB';

  CREATE DATABASE coredb
    WITH OWNER = core
         ENCODING = 'UTF8'
         TABLESPACE = pg_default
         LC_COLLATE = 'en_US.utf8'
         LC_CTYPE = 'en_US.utf8'
         CONNECTION LIMIT = -1;
  GRANT CONNECT, TEMPORARY ON DATABASE coredb TO public;

  GRANT ALL ON DATABASE coredb TO core;

  create role core_r with
    nologin
    nosuperuser
    inherit
    nocreatedb
    nocreaterole
    noreplication;

  create role core_rw with
    nologin
    nosuperuser
    inherit
    nocreatedb
    nocreaterole
    noreplication;

EOSQL

psql -v ON_ERROR_STOP=1 --username core coredb <<-EOSQL

  CREATE SCHEMA sp
      AUTHORIZATION core;

  GRANT ALL ON SCHEMA sp TO core;

  GRANT USAGE ON SCHEMA sp TO core_r;

  GRANT USAGE ON SCHEMA sp TO core_rw;

  alter default privileges in schema sp
      grant select, insert, update, delete on tables to core_rw;

  alter default privileges in schema sp
      grant select on tables to core_r;
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres coredb <<-EOSQL
  CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
EOSQL