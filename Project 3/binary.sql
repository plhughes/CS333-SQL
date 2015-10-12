/**
 * File: binary.sql
 * Creates a database and table to  demonstrate our implementation of binary search
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/05/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_three;
CREATE DATABASE project_three;
USE project_three;

/* Creating table */
DROP TABLE IF EXISTS double_tbl;
CREATE TABLE double_tbl(
   table_idx INT NOT NULL AUTO_INCREMENT,
   table_value INT NOT NULL,
   PRIMARY KEY ( table_idx )
);


/* Create a procedure that adds the input number over rows to the table */
/* The values are all evens */
DELIMITER $$
CREATE PROCEDURE populate_list(rows INT)
BEGIN

SET @i = 0;

WHILE (@i < rows) DO
    INSERT INTO double_tbl (table_value)
	VALUES (@i*2);
	SET @i = @i + 1;
END WHILE;
END $$
DELIMITER ;

/* Calls the populate_list procedure */
CALL populate_list(20);


/* Creates a binary search function that takes in the number */
/* of rows in the table and the target value to search for */
/* It will first check the value in the middle and narrow its range */
/* for searches by half every time. */
DELIMITER $$
DROP FUNCTION IF EXISTS binary_search$$
CREATE FUNCTION binary_search (row_count INT, target INT)
RETURNS VARCHAR(3)
BEGIN

    DECLARE half_dist INT DEFAULT 0;
    DECLARE mid_value INT DEFAULT 0;
    DECLARE start_i INT DEFAULT 1;
    DECLARE end_i INT DEFAULT row_count;

    WHILE (end_i >= start_i) DO
        SET half_dist = (end_i - start_i)/2;
        SELECT table_value FROM double_tbl WHERE table_idx = start_i+half_dist INTO mid_value;
        
        IF (start_i = end_i) and (mid_value != target) THEN
            RETURN "NO!";
        END IF;

        IF mid_value = target THEN
            RETURN "YES";
        END IF;

        IF mid_value >= target THEN
            SET end_i = start_i+half_dist-1;
        ELSE
            SET start_i = start_i+half_dist;
        END IF;

    END WHILE;

END $$
DELIMITER ;

SELECT binary_search(20, 8) AS "Is 8 in the table?";
SELECT binary_search(20, 17) AS "Is 17 in the table?";
SELECT binary_search(20, 0) AS "Is 0 in the table?";
SELECT binary_search(20, 38) AS "Is 38 in the table?";
SELECT binary_search(20, 50) AS "Is 50 in the table?";