/*
 * File: variables.sql
 * Creates databases, tables, and variables to demonstrate the scope and naming
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/05/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_three;
CREATE DATABASE project_three;
USE project_three;


DROP DATABASE IF EXISTS project_three2;
CREATE DATABASE project_three2;


/* Creating table within project_three database */
DROP TABLE IF EXISTS project_three.test_table;
CREATE TABLE project_three.test_table(
    id INT NOT NULL AUTO_INCREMENT,
    val INT,
    PRIMARY KEY ( id )
);


/* Creating table to test valid characters */
DROP TABLE IF EXISTS 23$testing_valid_characters;
CREATE TABLE 23$testing_valid_characters(
    id INT NOT NULL AUTO_INCREMENT,
    val INT,
    PRIMARY KEY ( id )
);


/* Creates a procedure test local variables*/
DELIMITER $$
CREATE PROCEDURE local_variable()
BEGIN

DECLARE testing INT;
SET testing = 10;
SELECT testing;

END $$
DELIMITER ;

/* Creates a procedure to show the scope of a user variable*/
DELIMITER $$
CREATE PROCEDURE testing_scope()
BEGIN

SELECT @variable_name;
/*This user variable is not defined here but it can be returned*/ 

END $$
DELIMITER ;


/*Showing scope of table*/
/* Adding a row into the table */
INSERT INTO test_table VALUES(0, 8);

/* Prints out table */
SELECT * FROM test_table;

/*Creating user defined variables*/
SET @variable_name = 5;
SELECT @variable_name;

SET @another.var = "Test";
SELECT @another.var;


/*Testing functions*/
CALL local_variable();
CALL testing_scope();

SELECT testing; /*Produces error because testing is not in this scope*/



/*Switching Databases!*/

USE project_three2;

SELECT @variable_name;
CALL local_variable();

/* Prints out table */
SELECT * FROM test_table; /*Error because table is in a different database*/
