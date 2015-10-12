/*
 * File: implicitConveraion.sql
 * Examples of implicit conversion in SQL
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/19/2015
 */
 
 
 /* Creating database */
DROP DATABASE IF EXISTS project_four;
CREATE DATABASE project_four;
USE project_four;

/*-----------------------------------------------------------------------*/
/* Creating table within project_four database */
DROP TABLE IF EXISTS string_conversion;
CREATE TABLE string_conversion(
    id INT NOT NULL AUTO_INCREMENT,
    val INT,
    PRIMARY KEY ( id )
);

/* Populates Table*/
DELIMITER $$
CREATE PROCEDURE populate_list(rows INT)
BEGIN

SET @i = 0;

WHILE (@i < rows) DO
    INSERT INTO string_conversion (val)
	VALUES (RAND()*5); /*Inserts random numbers between 0 and 5*/
	SET @i = @i + 1;
END WHILE;
END $$
DELIMITER ;

/*Populates table and prints out*/
CALL populate_list(20);
SELECT * FROM string_conversion;
SELECT id FROM string_conversion WHERE val > '2';
/*The string 2 is implicitly converted to an integer when retrieving from a table.*/ 

/*-----------------------------------------------------------------------*/
/*Unexpected outcome of adding a string to a number.*/
SET @x = "The year is";
SET @y = 2015;
SET @z = @x + @y;

SELECT @z;

/*-----------------------------------------------------------------------*/
/*Shows float conversion*/
SET @a = 6; /*Int*/
SELECT @a;
 
SET @b = 7.0; /*Float*/
SELECT @b; 
 
SELECT @a/@b; /* @a is implicitly converted to a float*/
  
  
/*-----------------------------------------------------------------------*/

/*Shows how reassigning variables can cause a loss of data*/
DELIMITER $$
CREATE PROCEDURE lose_data()
BEGIN

DECLARE a INT DEFAULT 7;
DECLARE b DECIMAL(2,1) DEFAULT 2.1;
SET a = b;
SELECT a;


END $$
DELIMITER ;

CALL lose_data()
