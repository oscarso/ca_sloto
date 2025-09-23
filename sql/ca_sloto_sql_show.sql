USE test1;

# SHOW ALL procedures & tables
SHOW TABLES;
SHOW PROCEDURE STATUS WHERE db='test1';

SELECT CONCAT('DESCRIBE ', table_name, ';')
FROM information_schema.tables
WHERE table_schema = 'test1';

