/*
 * File: functions.sql
 * Displays how to write to and get data from a file
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 11/09/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_six;
CREATE DATABASE project_six;
USE project_six;

/*Creating base table*/
DROP TABLE IF EXISTS animals;
CREATE TABLE animals(
    id INT NOT NULL AUTO_INCREMENT,
    animal VARCHAR(20),
	color VARCHAR(10),
	age INT NOT NULL,
    PRIMARY KEY ( id )
);

DELIMITER $$

/* Functions must have return value with specified type
Returns the number of the animals */
DROP FUNCTION IF EXISTS num_animals$$
CREATE FUNCTION num_animals()
    RETURNS INT
    BEGIN
        DECLARE size INT;
        SELECT COUNT(*) FROM animals INTO size;
    RETURN size;
END $$


/*This would be an example of overloading. However, overloading is not supported by mySQL*/
/*
CREATE FUNCTION num_animals(x INT)
	RETURNS INT
	BEGIN
        DECLARE size INT;
        SELECT COUNT(*) FROM animals INTO size;
		SET size = size * x;
    RETURN size;
END $$
*/

/*This would be an example of overriding. However, overriding is not supported by mySQL*/
/*
CREATE FUNCTION num_animals()
	RETURNS INT
	BEGIN
        DECLARE size INT;
        SELECT COUNT(*) FROM animals INTO size;
		SET size = size * 10;
    RETURN size;
END $$
*/

/* Procedure do not need or return anything */
DROP PROCEDURE IF EXISTS colors$$
CREATE PROCEDURE colors(animal_name VARCHAR(20))
BEGIN
	SELECT color FROM animals WHERE animal = animal_name;
END $$


/* Procedure can have out parameter */
DROP PROCEDURE IF EXISTS add_ages$$
CREATE PROCEDURE add_ages(OUT age_total INT)
BEGIN
	SET age_total = (SELECT SUM(age) FROM animals);
END $$

DELIMITER ;

/*Adding to table*/
INSERT INTO animals (animal, color, age) VALUES ("Cat", "Orange", 6);
INSERT INTO animals (animal, color, age) VALUES ("Donkey", "Yellow", 800);

/*Testing functions and procedures*/
SELECT num_animals();
CALL colors("Donkey");

/*Procedure with OUT parameter*/
CALL add_ages(@age);
SELECT @age;

/*SELECT num_animals(5);*/

/*Dynamically creating functions*/
SET @tbl = 'animals';
SET @col = 'animal';
SET @query = CONCAT('SELECT * FROM ', @tbl, ' WHERE ', @col, ' = ?' ); /* ?s are the parameters*/
PREPARE func_name FROM @query;
SET @a = "Cat";
SET @b = "Donkey";
EXECUTE func_name USING @a;

/*Deleting dynamic function. This will be done for you if not explicitly*/
DEALLOCATE PREPARE func_name;
