/**
 * File: types.sql
 * Demonstrates internal representation and limitations of ints and floats
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/19/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_four;
CREATE DATABASE project_four;
USE project_four;

/* Creating table */
DROP TABLE IF EXISTS type_tbl;
CREATE TABLE type_tbl(
    id INT NOT NULL AUTO_INCREMENT,
    neg_int INT,
    pos_int INT,
    neg_float FLOAT,
    pos_float FLOAT,
    PRIMARY KEY ( id )
);

/* Adding a row with large values of each type into the table */
INSERT INTO type_tbl VALUES( 1, -999999999999, 999999999999, -999999999999999999999999999999999999999999,
    999999999999999999999999999999999999999999 );
/* Prints out our current table */
SELECT * FROM type_tbl;


/* Prints out our current table after trying to increase/decrease all values by 1*/
UPDATE type_tbl SET 
    pos_int = pos_int + 1, neg_int = neg_int - 1,
    pos_float = pos_float + 1, neg_float = neg_float - 1;
SELECT * FROM type_tbl;

