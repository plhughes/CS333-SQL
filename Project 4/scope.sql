/*
 * File: scope.sql
 * Shows scope of variables, user defined variables, databases, and tables
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/19/2015
 */
 
/* Creating database */
DROP DATABASE IF EXISTS project_four;
CREATE DATABASE project_four;
USE project_four;


/* Creating table within project_four database */
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table(
    id INT NOT NULL AUTO_INCREMENT,
    val INT,
    PRIMARY KEY ( id )
);

/* Adding to Table*/
INSERT INTO test_table (val) VALUES (5);

/*User Variable*/
SET @a = 10;

/*Function*/
DELIMITER $$
DROP FUNCTION IF EXISTS test_function$$
CREATE FUNCTION test_function()
RETURNS INT
BEGIN
	DECLARE b INT DEFAULT 5; /*local variable*/
	SET @c = @a + 15; /* Creating user variable*/
	RETURN @c;
	
END $$
DELIMITER ;

SELECT test_function();
SELECT @a;
SELECT b; /*Error because b's scope is within the function*/
SELECT @c;


/*Within different database can use tables but not variables or functions*/
USE project_three; /*Switching database*/
SELECT * FROM project_four.test_table; /*Can access tables of different databases*/

/*Functions and user variables have scope of database*/
CALL test_function();
/*These were declared in the project_four database. Therefore, this produces an error*/