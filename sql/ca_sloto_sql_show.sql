-- Purpose:
--   Verify database objects (tables + stored procedures) created by the init script.
--
-- Usage:
--   mysql -u root -p < sql/ca_sloto_sql_show.sql
--
-- Notes:
--   This script assumes the database name is `test1`.

USE test1;

# SHOW ALL procedures & tables
SHOW TABLES;
SHOW PROCEDURE STATUS WHERE db='test1';

SELECT CONCAT('DESCRIBE ', table_name, ';')
FROM information_schema.tables
WHERE table_schema = 'test1';
