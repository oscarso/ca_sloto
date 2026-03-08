-- Purpose:
--   Initialize schema objects for the database used by this repo.
--   Creates tables and stored procedures.
--
-- Usage:
--   mysql -u root -p < sql/ca_sloto_sql_init.sql
--
-- Notes:
--   This script assumes the database name is `test1`.
--   Run sql/ca_sloto_sql_create.sql first.

USE test1;




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
    DECLARE start_dnum_padded VARCHAR(32);
    SET start_dnum_padded = LPAD(start_dnum, 4, '0');

    SELECT d1,d2,d3,d4,d5
    FROM dresult
    WHERE dnum >= start_dnum_padded
    ORDER BY dnum
    LIMIT 4;
END$$

# get_row_1
CREATE PROCEDURE get_row_1(IN in_dnum VARCHAR(32))
BEGIN
    SELECT d1,d2,d3,d4,d5
    FROM dresult
    WHERE dnum = LPAD(in_dnum, 4, '0');
END$$

DELIMITER ;

