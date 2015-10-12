/**
 * File: aggregateTypes.sql
 * Demonstrates databases and tables in SQL
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/19/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_four;
CREATE DATABASE project_four;
USE project_four;

/* Creating table in project_four database*/
DROP TABLE IF EXISTS field_tbl;
CREATE TABLE field_tbl(
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT,
    PRIMARY KEY ( id )
);

/* Add an entry into the table and print it out */
INSERT INTO field_tbl (first_name, last_name, age)
    VALUES ("Jenny", "Lin", 20);
SELECT * FROM field_tbl;



/* Creating another database */
DROP DATABASE IF EXISTS project_four_temp;
CREATE DATABASE project_four_temp;
USE project_four_temp;

/* Creating table in the other database with identical format*/
DROP TABLE IF EXISTS field_tbl;
CREATE TABLE field_tbl(
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT,
    PRIMARY KEY ( id )
);

/* Add entries into the table and print it out to demonstrate differences*/
INSERT INTO field_tbl (first_name, last_name, age)
    VALUES ("Phoebe", "Hughes", 20);
INSERT INTO field_tbl (first_name, last_name, age)
    VALUES ("Jenny", "Lin", 20);
INSERT INTO field_tbl (first_name, last_name, age)
    VALUES ("Tiffany", "Lam", 20);
INSERT INTO field_tbl (first_name, last_name, age)
    VALUES ("Itrat", "Akter", 22);
SELECT * FROM field_tbl;

/* Shows how to select certain parts of the table using WHERE */
SELECT first_name FROM field_tbl WHERE age < 21;



/* Goes back to the first database and print out the table*/
USE project_four;
SELECT * FROM field_tbl;

/* Changing an entry in the table and print out table*/
UPDATE field_tbl SET
    first_name = "Phoebe", last_name = "Hughes"
    WHERE id = 1;
SELECT * FROM field_tbl;
