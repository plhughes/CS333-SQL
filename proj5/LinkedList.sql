/**
 * File: LinkedList.sql
 * Implements a linked list in SQL using tables and subtables, linked by foreign key
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
    names VARCHAR(40) NOT NULL,
    nextId INT NOT NULL,
    PRIMARY KEY ( id )
);

/*Creating subtype tables*/
DROP TABLE IF EXISTS student;
CREATE TABLE student(
    my_id INT NOT NULL AUTO_INCREMENT,
    major VARCHAR(20),
    id INT REFERENCES person(my_id), /* Foreign key:
                                        same person id is used across subtables */
    PRIMARY KEY (my_id)
);

DROP TABLE IF EXISTS professor;
CREATE TABLE professor(
    my_id INT NOT NULL AUTO_INCREMENT,
    course VARCHAR(20),
    id INT REFERENCES person(my_id), /* Foreign key:
                                        same person id is used across subtables */
    PRIMARY KEY (my_id)
);

DELIMITER $$

/* Add to the front of the list */
DROP FUNCTION IF EXISTS ll_push$$
CREATE FUNCTION ll_push(tbl_num INT, name VARCHAR(40), info VARCHAR(20))
    RETURNS TEXT
    BEGIN
        /* Size of our person "Linked List" */
        DECLARE size INT;
        SELECT COUNT(*) FROM person INTO size;
        
        /* Make insert at base table*/
        IF size = 0 THEN
            INSERT INTO person (names, nextId) VALUES (name, -1);
        ELSE
            UPDATE person SET nextId = nextId + 1 WHERE nextId != -1;
            INSERT INTO person (names, nextId) VALUES (name, 1);
        END IF;

        /* Make insert at subtable*/
        IF tbl_num = 0 THEN
            /* Student table */
            INSERT INTO student (major, id) VALUES (info, LAST_INSERT_ID());
            RETURN "Added to student table";
        ELSE 
            /* Professor table*/
            INSERT INTO professor (course, id) VALUES(info, LAST_INSERT_ID());
            RETURN "Added to professor table";
        END IF;
    RETURN "ll_push FAILED";
END$$

/* Remove from the head of the list */
DROP FUNCTION IF EXISTS ll_pop$$
CREATE FUNCTION ll_pop()
    RETURNS VARCHAR(60)
    BEGIN

        DECLARE size INT;   /* Size of person table */
        DECLARE idx INT;    /* id of the head */
        
        /* Holds information of the person popped */
        DECLARE name VARCHAR(40);
        DECLARE val VARCHAR(20);
        DECLARE result VARCHAR(60);

        SELECT COUNT(*) FROM person INTO size;
        IF size = 0 THEN
            RETURN "EMPTY";
        END IF;
        
        /* Store the id of of the head into our idx variable */
        SELECT id FROM person WHERE nextId = 1 INTO idx;

        /*Remove the row of the head*/
        SELECT names INTO name FROM person WHERE id = idx;
        DELETE FROM person WHERE id = idx;
        UPDATE person SET nextId = nextId - 1 WHERE nextId != -1;

            
        /*Check if the person is in the student table*/
        IF(SELECT EXISTS( SELECT 1 FROM student WHERE id = idx )) THEN
            SELECT major INTO val FROM student WHERE id = idx;
            DELETE FROM student WHERE id = idx;
        ELSE
            SELECT course INTO val FROM professor WHERE id = idx;
            DELETE FROM professor WHERE id = idx;
        END IF;
    RETURN CONCAT("Popped: ", name, " ", val);
END$$

/* Add to end of the list */
DROP FUNCTION IF EXISTS ll_append$$
CREATE FUNCTION ll_append(tbl_num INT, name VARCHAR(40), info VARCHAR(20))
    RETURNS TEXT
    BEGIN
        /* Size of our person "Linked List" */
        DECLARE size INT;
        SELECT COUNT(*) FROM person INTO size;

        /* Make insert at base table*/
        IF size = 0 THEN
            INSERT INTO person (names, nextId) VALUES (name, -1);
        ELSE
            UPDATE person SET nextId = size WHERE nextId = -1;
            INSERT INTO person (names, nextId) VALUES (name, -1);
        END IF;

        /* Make insert at subtable*/
        IF tbl_num = 0 THEN
            /* Student table */
            INSERT INTO student (major, id) VALUES (info, LAST_INSERT_ID());
            RETURN "Added to student table";
        ELSE 
            /* Professor table*/
            INSERT INTO professor (course, id) VALUES(info, LAST_INSERT_ID());
            RETURN "Added to professor table";
        END IF;
    RETURN "ll_append FAILED";
END$$

/* Remove from the list if target is found*/
DROP FUNCTION IF EXISTS ll_remove$$
CREATE FUNCTION ll_remove(target VARCHAR(40))
    RETURNS VARCHAR(60)
    BEGIN

        DECLARE size INT;           /* Size of person table */
        DECLARE idx INT;            /* id of the target (if found) */
        DECLARE nextIdTarget INT;   /* nextId of the target (if found) */
        
        /* Holds information of the person popped */
        DECLARE name VARCHAR(40);
        DECLARE val VARCHAR(20);
        DECLARE result VARCHAR(60);

        SELECT COUNT(*) FROM person INTO size;
        IF size = 0 THEN
            RETURN "EMPTY";
        END IF;
        
        /* Check to see if target is in our list */
        IF(SELECT EXISTS( SELECT 1 FROM person WHERE names = target ) - 1) THEN
            RETURN "NOT FOUND";
        END IF;

        /* Store the indices of target into our variable */
        SELECT id FROM person WHERE names = target INTO idx;
        SELECT nextId FROM person WHERE names = target INTO nextIdTarget;

        /* Remove the target row */
        SELECT names INTO name FROM person WHERE id = idx;
        DELETE FROM person WHERE id = idx;
        UPDATE person SET nextId = nextId - 1 WHERE nextId > nextIdTarget;
            
        /*Check if the person is in the student table*/
        IF(SELECT EXISTS( SELECT 1 FROM student WHERE id = idx )) THEN
            SELECT major INTO val FROM student WHERE id = idx;
            DELETE FROM student WHERE id = idx;
        ELSE
            SELECT course INTO val FROM professor WHERE id = idx;
            DELETE FROM professor WHERE id = idx;
        END IF;
    RETURN CONCAT("Removed: ", name, " ", val);
END$$

/* Returns the size of the list */
DROP FUNCTION IF EXISTS ll_size$$
CREATE FUNCTION ll_size()
    RETURNS INT
    BEGIN
        DECLARE size INT;           /* Size of person table */
        SELECT COUNT(*) FROM person INTO size;
    RETURN size;
END $$

/* Clears the tables */
DROP FUNCTION IF EXISTS ll_clear$$
CREATE FUNCTION ll_clear()
    RETURNS TEXT
    BEGIN
        DELETE FROM person;
        DELETE FROM student;
        DELETE FROM professor;
    RETURN "CLEARED!";
END $$

DELIMITER ;



/* Adding to the list */
SELECT ll_push(0, "Jenny", "CS & Stats");
SELECT ll_push(0, "Phoebe", "CS");
SELECT ll_push(1, "Ying", "CS333");
SELECT ll_push(0, "Tiffany", "CS & Econ");
SELECT ll_append(1, "Stephanie", "CS341");
SELECT ll_append(1, "Bruce", "CS151");
SELECT ll_push(1, "Dale", "CS231");
SELECT * FROM person;
SELECT ll_size() AS "Size";

/* Testing pop and remove */
SELECT ll_pop();
SELECT ll_remove("Jenny");
SELECT ll_remove("Bob");
SELECT * FROM person;
SELECT ll_size() AS "Size";

/* Adding more */
SELECT ll_append(0, "Itrat", "CS & MathSci");
SELECT ll_append(0, "Beatrice", "CS & Stats");
SELECT ll_push(0, "Jenny", "CS & Stats");
SELECT * FROM person;
SELECT ll_size() AS "Size";
SELECT * FROM student;
SELECT * FROM professor;
SELECT * FROM person;

/* Clearing List/Tables */
SELECT ll_clear();
SELECT ll_size() AS "Size";
SELECT * FROM student;
SELECT * FROM professor;
SELECT * FROM person;

