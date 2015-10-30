/**
 * File: LinkedList.sql
 * Implements a linked list in SQL using tables and subtables
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 11/02/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_five;
CREATE DATABASE project_five;
USE project_five;

/*Creating base table*/
DROP TABLE IF EXISTS person;
CREATE TABLE person(
    id INT NOT NULL AUTO_INCREMENT,
    age TEXT NOT NULL,
    PRIMARY KEY ( id )
);

/*Creating subtype tables*/
DROP TABLE IF EXISTS student;
CREATE TABLE student(
    my_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(40),
    major VARCHAR(20),
    nextId INT,
    id INT REFERENCES person(my_id), /* same id is used across subtables */
    PRIMARY KEY (my_id)
);

DELIMITER $$
DROP FUNCTION IF EXISTS ll_push $$
CREATE FUNCTION ll_push(ages INT, n VARCHAR(40), m VARCHAR(20))
    RETURNS INT
    BEGIN
        DECLARE size INT;
        SELECT COUNT(*) FROM student INTO size;
        
        /* Make insert at base table*/
        INSERT INTO person (age) VALUES (ages);

        /* Empty list*/
        IF size = 0 THEN
            INSERT INTO student VALUES (0, n, m, -1, LAST_INSERT_ID());
        ELSE 
            /*Shift all entries' id by one and add row at id 0*/
            UPDATE student SET nextId = nextId + 1 WHERE nextId != -1;
            INSERT INTO student VALUES(0, n, m, 1, LAST_INSERT_ID());
        END IF;
        RETURN size;
    END $$
    

DROP FUNCTION IF EXISTS ll_pop $$
CREATE FUNCTION ll_pop()
    RETURNS VARCHAR(40)
    BEGIN
        DECLARE size INT;
        DECLARE result VARCHAR(40);
        SELECT COUNT(*) FROM student INTO size;
        IF size = 0 THEN
            RETURN "EMPTY";
        ELSE 
            /*Remove the row with my_id = size*/
            UPDATE student SET nextId = nextId - 1 WHERE nextId != -1;
            SELECT name INTO result FROM student WHERE my_id = size;
            DELETE FROM student WHERE my_id = size;
            DELETE FROM person WHERE id = size;
            RETURN result;
        END IF;
    END $$
DELIMITER ;

SELECT ll_push(20, "Jenny", "CS");
SELECT ll_push(21, "Phoebe", "CS");
SELECT ll_push(20, "Tiffany", "CS");
SELECT * FROM student;
SELECT * FROM person;
SELECT ll_pop();
SELECT * FROM student;
SELECT * FROM person;