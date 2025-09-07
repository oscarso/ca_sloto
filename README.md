How to install and configure MySQL on MacOS 15 ?
01) https://www.mysql.com/
02) Download MySQL 8.4.6 for MacOS 15 (Arm64)
03) Set MySQL root password: Ts1x6!
04) Configure path:
bash-3.2$ echo 'export PATH=/usr/local/mysql/bin:$PATH' >> ~/.zshrc
bash-3.2$ source ~/.zshrc
05) bash-3.2$ mysql -u root -p
06) mysql> CREATE DATABASE ca_sloto;
      Query OK, 1 row affected (0.01 sec)
07) mysql> USE ca_sloto;
      Database changed
08) 
CREATE TABLE dresult (
    dnum VARCHAR(32) PRIMARY KEY,
    d1   TINYINT UNSIGNED,
    d2   TINYINT UNSIGNED,
    d3   TINYINT UNSIGNED,
    d4   TINYINT UNSIGNED,
    d5   TINYINT UNSIGNED,
    mn  TINYINT UNSIGNED,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

How to insert sloto data into MySQL ?

MySQL settings ?
Open System Settings > MySQL > “Start MySQL”

How to export sloto data into text file for edit ?
python3 ./ca_sloto_export.py 2025-0901_dresult2.csv

How to import sloto into MySQL ?
python3 ./ca_sloto_import.py 2025-0901_dresult1.csv

How to ensure import and export data integrity ?
# Import original data file into db, and export file into #1
python3 ./ca_sloto_table_drop.py dresult
python3 ./ca_sloto_table_create.py
python3 ./ca_sloto_import.py ca_sloto.csv.2025-0726b
python3 ./ca_sloto_export.py 2025-0901_dresult1.csv

# Import data file #1, and export file into #2
python3 ./ca_sloto_table_drop.py dresult
python3 ./ca_sloto_table_create.py 
python3 ./ca_sloto_import.py 2025-0901_dresult1.csv
python3 ./ca_sloto_export.py 2025-0901_dresult2.csv

# Compare
diff 2025-0901_dresult1.csv 2025-0901_dresult2.csv
md5sum 2025-0901_dresult1.csv
md5sum 2025-0901_dresult2.csv




Reference:

-- Create the table
CREATE TABLE order4 (
    p4 VARCHAR(16) PRIMARY KEY,
    counter BIGINT DEFAULT 0
);

-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE upsert_order4(
    IN in_p4 VARCHAR(16)
)
BEGIN
    INSERT INTO order4 (p4)
    VALUES (in_p4)
    ON DUPLICATE KEY UPDATE
        counter = counter + 1;
END;
//

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE get_rows_4(IN start_dnum VARCHAR(32))
BEGIN
    SELECT d1,d2,d3,d4,d5
    FROM dresult
    WHERE dnum >= start_dnum
    ORDER BY dnum
    LIMIT 4;
END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE get_row_1(IN dnum VARCHAR(32))
BEGIN
    SELECT d1,d2,d3,d4,d5
    FROM dresult
    WHERE dnum = dnum;
END$$

DELIMITER ;


SELECT * FROM order4 WHERE p4 LIKE '5-9-15%' ORDER BY counter DESC;
SELECT * FROM order4 where p4 LIKE "14-12-3-%";



