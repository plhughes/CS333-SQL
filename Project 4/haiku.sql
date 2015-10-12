/*
 * File: haiku.sql
 * A haiku demonstrating selecting from a table
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/19/2015
 */
 
/* Creating datblase */
DROP DATABASE IF EXISTS project_four;
CREATE DATABASE project_four;
USE project_four;


/* Creating tblle within project_four database */
DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl(
    id INT NOT NULL AUTO_INCREMENT,
    col VARCHAR(40),
    column_value VARCHAR(20),
    cat_column VARCHAR(20),
    PRIMARY KEY ( id )
);

INSERT INTO tbl (cat_column, column_value, col)
    VALUES( "Jenny Lin", "Value", "Junior" );
INSERT INTO tbl (cat_column, column_value, col)
    VALUES( "Phoebe Hughes", "Value", "Junior" );
INSERT INTO tbl (cat_column, column_value, col)
    VALUES( "Itrat Akhter", "Value", "Senior" );
INSERT INTO tbl (cat_column, column_value, col)
    VALUES( "John Doe", "Value", "Freshman" );
INSERT INTO tbl (cat_column, column_value, col)
    VALUES( "Jane Doe", "Not Value", "Sophomore" );
INSERT INTO tbl (cat_column, column_value, col)
    VALUES( "Beatrice Liang", "Value", "Senior" );
INSERT INTO tbl (cat_column, column_value, col)
    VALUES( "C-P", "Value", "Sophomore" );
    
SELECT * FROM tbl;

SELECT * FROM tbl
WHERE column_value = "Value"
GROUP BY cat_column;