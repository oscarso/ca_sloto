-- Purpose:
--   Recreate the MySQL database used by this repo.
--
-- Usage:
--   mysql -u root -p < sql/ca_sloto_sql_create.sql
--
-- WARNING:
--   This script DROPS the database `test1`.
--   Change the database name here (and in the other SQL/Python files) if needed.

DROP DATABASE   test1;
CREATE DATABASE test1;
