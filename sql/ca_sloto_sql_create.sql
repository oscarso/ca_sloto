DELIMITER $$



# dresult


# order4 or orderN

# order4_upsert or orderN_upsert


# get_rows_4 or get_rows_N
CREATE PROCEDURE get_rows_4(IN start_dnum VARCHAR(32))
BEGIN
    SELECT d1,d2,d3,d4,d5
    FROM dresult
    WHERE dnum >= start_dnum
    ORDER BY dnum
    LIMIT 4;
END$$


# order4_upsert or orderN_upsert


# get_rows_4 or get_rows_N


# get_row_1
CREATE PROCEDURE get_row_1(IN dnum VARCHAR(32))
BEGIN
    SELECT d1,d2,d3,d4,d5
    FROM dresult
    WHERE dnum = dnum;
END$$



DELIMITER ;

