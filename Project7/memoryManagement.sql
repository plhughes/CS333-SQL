/*
 * File: memoryManagement.sql
 * Shows allocation and de-allocation of memory
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 11/16/2015
 */

 /*Deallocating Memory*/
 DROP DATABASE IF EXISTS project_seven;
 DROP TABLE IF EXISTS animals;
 DROP FUNCTION IF EXISTS num_animals;

/*Allocating Memory*/
/* Creating database */
CREATE DATABASE project_seven;
USE project_six;

/*Creating base table*/
CREATE TABLE animals(
    id INT NOT NULL AUTO_INCREMENT,
    animal VARCHAR(20),
    PRIMARY KEY ( id )
);

DELIMITER $$

/* Returns the number of animals*/
CREATE FUNCTION num_animals()
    RETURNS INT
    BEGIN
        DECLARE size INT;
        SELECT COUNT(*) FROM animals INTO size;
    RETURN size;
END $$

DELIMITER ;

INSERT INTO animals (animal) VALUES ("Cow");
INSERT INTO animals (animal) VALUES ("Dog");

SET @a = "allocating memory";

/*Printing databases, tables, and rows created*/
SHOW DATABASES;
SHOW TABLES;
SELECT * FROM animals;

/*Deallocating memory*/
DELETE FROM animals;
SELECT * FROM animals;

/*Allocating so that we can deallocate again*/
INSERT INTO animals (animal) VALUES ("Pig");
INSERT INTO animals (animal) VALUES ("Cat");
SELECT * FROM animals;

/*Deallocating memory*/
TRUNCATE TABLE animals;
SELECT * FROM animals; 

DROP TABLE IF EXISTS animals;
DROP FUNCTION IF EXISTS num_animals;
SHOW TABLES;

DROP DATABASE IF EXISTS project_seven;
SHOW DATABASES;
