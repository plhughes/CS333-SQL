/**
 * File: badbinary.sql
 * Demonstrates a bad binary search
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/05/2015
 */


DROP DATABASE IF EXISTS blah;CREATE DATABASE blah;USE blah;
DROP TABLE IF EXISTS double_tbl;
CREATE TABLE double_tbl(
    table_value INT NOT NULL AUTO_INCREMENT,
    table_idx INT NOT NULL,
    PRIMARY KEY ( table_value )
);
DELIMITER $$
CREATE PROCEDURE populate_list(rows INT)
BEGIN
SET @i = 0;
WHILE (@i < rows) DO
    INSERT INTO double_tbl (table_idx)
	VALUES (@i*2);
	SET @i = @i + 1;
END WHILE;
END $$
DELIMITER ;
CALL populate_list(20);
DELIMITER $$
DROP FUNCTION IF EXISTS binary_search$$
CREATE FUNCTION binary_search (target INT, miss INT)
RETURNS VARCHAR(3)
BEGIN
    DECLARE somewhere INT DEFAULT 0; DECLARE anywhere INT DEFAULT 0;
    DECLARE nowhere INT DEFAULT 1; DECLARE everywhere INT DEFAULT target;
    WHILE (everywhere >= nowhere) DO
        SET somewhere = (everywhere - nowhere)/2;
        SELECT table_idx FROM double_tbl WHERE table_value = nowhere+somewhere INTO anywhere;
        IF (nowhere = everywhere) and (anywhere != miss) THEN RETURN "NO!"; END IF;
        IF anywhere = miss THEN RETURN "YES"; END IF;
        IF anywhere >= miss THEN SET everywhere = nowhere+somewhere-1;
        ELSE SET nowhere = nowhere+somewhere;END IF;
    END WHILE;
END $$
DELIMITER ;

SELECT binary_search(20, 8) AS "Is 8 in the table?";
SELECT binary_search(20, 17) AS "Is 17 in the table?";
SELECT binary_search(20, 0) AS "Is 0 in the table?";
SELECT binary_search(20, 38) AS "Is 38 in the table?";
SELECT binary_search(20, 50) AS "Is 50 in the table?";