DROP DATABASE    test1;
CREATE DATABASE  test1;
USE test1;


# SHOW ALL procedures & tables
SHOW TABLES;
SHOW PROCEDURE STATUS WHERE db='test1';


# dresult
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dresult` (
  `dnum` varchar(32) NOT NULL,
  `d1` tinyint unsigned DEFAULT NULL,
  `d2` tinyint unsigned DEFAULT NULL,
  `d3` tinyint unsigned DEFAULT NULL,
  `d4` tinyint unsigned DEFAULT NULL,
  `d5` tinyint unsigned DEFAULT NULL,
  `mn` tinyint unsigned DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

# order4 or orderN
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order4` (
  `p4` varchar(16) NOT NULL,
  `counter` bigint DEFAULT '0',
  PRIMARY KEY (`p4`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;




DELIMITER $$

# order4_upsert or orderN_upsert
CREATE PROCEDURE `order4_upsert`(
    IN in_p4 VARCHAR(16)
)
BEGIN
    INSERT INTO order4 (p4)
    VALUES (in_p4)
    ON DUPLICATE KEY UPDATE
        counter = counter + 1;
END$$

# get_rows_4 or get_rows_N
CREATE PROCEDURE get_rows_4(IN start_dnum VARCHAR(32))
BEGIN
    SELECT d1,d2,d3,d4,d5
    FROM dresult
    WHERE dnum >= start_dnum
    ORDER BY dnum
    LIMIT 4;
END$$

# get_row_1
CREATE PROCEDURE get_row_1(IN dnum VARCHAR(32))
BEGIN
    SELECT d1,d2,d3,d4,d5
    FROM dresult
    WHERE dnum = dnum;
END$$


# SHOW ALL procedures & tables
SHOW TABLES;
SHOW PROCEDURE STATUS WHERE db='test1';

SELECT CONCAT('DESCRIBE ', table_name, ';')
FROM information_schema.tables
WHERE table_schema = 'test1';

