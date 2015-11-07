/*
 * File: fileIO.sql
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

/* Returns the number of the animals */
DROP FUNCTION IF EXISTS num_animals$$
CREATE FUNCTION num_animals()
    RETURNS INT
    BEGIN
        DECLARE size INT;
        SELECT COUNT(*) FROM animals INTO size;
    RETURN size;
END $$

DELIMITER ;

/*Loads in file*/
LOAD DATA LOCAL INFILE 'C:/Users/Phoebe/Desktop/animals.txt' 
INTO TABLE project_six.animals
LINES TERMINATED BY '\r\n';
/*End line character means new row
windows uses \r\n as end of line but mac uses \r
Columns are separated by tabs 
https://dev.mysql.com/doc/refman/5.7/en/loading-tables.html  */

SELECT * FROM animals;

/*adding new value*/
INSERT INTO animals (animal, color, age) VALUES ("Cat", "Orange", 6);

/*Creating new output file*/
SELECT * INTO OUTFILE 'newAnimals.txt' /*Cannot be already existing file!*/
FIELDS TERMINATED BY ' '         /*columns will have a space between them*/
LINES TERMINATED BY '\r\n'       /*rows will have new line between them*/
FROM animals;
/*Goes to the path C:\ProgramData\MySQL\MySQL Server 5.6\data\project_six\newAnimals.txt */


