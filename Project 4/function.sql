/**
 * File: function.sql
 * Shows capabilities of functions
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/19/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_four;
CREATE DATABASE project_four;
USE project_four;

/* Write a function that multiplies the two inputs and returns the result */
DELIMITER $$
DROP FUNCTION IF EXISTS mult$$
CREATE FUNCTION mult (num_a FLOAT, num_b FLOAT)
RETURNS FLOAT
BEGIN
    RETURN num_a*num_b;
END $$
DELIMITER ;

/* ERROR 1054 (42S22): Unknown column 'mult' in 'field list' */
/* SET @func_par = mult; */

/* Write a function that raises the base to the exponent's power */
DELIMITER $$
DROP FUNCTION IF EXISTS pow$$
CREATE FUNCTION pow (base FLOAT, exp INT)
RETURNS FLOAT
BEGIN
    
    DECLARE count INT DEFAULT exp; /* number of times to multiply base by itself */
    DECLARE result FLOAT DEFAULT 1;
    
    /* Call the multiply function inside pow instead of multiplying directly */
    WHILE( count > 0 ) DO
        SET result = mult(result, base);
        SET count = count - 1;
    END WHILE;

    RETURN result;
END $$
DELIMITER ;

SELECT pow(13,1) AS "13^1";
SELECT pow(3,2) AS "3^2";
SELECT pow(2,8) AS "2^8";