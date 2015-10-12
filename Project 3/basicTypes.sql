/**
 * File: basicTypes.sql
 * Demonstrates basic built in stypes in SQL and what happens when
 * a standard suite of operations is applied to them.
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/05/2015
 */
 
/* Creating database */
DROP DATABASE IF EXISTS project_three;
CREATE DATABASE project_three;
USE project_three;

/* Creating table */
DROP TABLE IF EXISTS type_tbl;
CREATE TABLE type_tbl(
    id INT NOT NULL AUTO_INCREMENT,
    n_tinyint TINYINT,
    n_bool BOOL,
    n_int INT,
    n_bigint BIGINT,
    n_decimal DECIMAL(3,2),
    n_float FLOAT,
    n_double DOUBLE,
    d_date DATE,
    d_datetime DATETIME,
    d_timestamp TIMESTAMP,
    d_time TIME,
    d_year YEAR,
    t_char CHAR(5),
    t_varchar VARCHAR(5),
    t_binary BINARY(5),
    t_blob BLOB,
    PRIMARY KEY ( id )
);

/* Adding a row into the table */
INSERT INTO type_tbl VALUES( 1, 1, 1, 1, 1, 1, 1, 1,
    '2015-10-04', '2015-10-04 01:16:00', '2015-10-04 01:16:00', '01:16:00', 2015,
    'A', 'A', 'A', 'A');
/* Prints out our current table */
SELECT * FROM type_tbl;


/* Adds one to all values in table */
UPDATE type_tbl SET 
    n_tinyint = n_tinyint + 1, n_bool = n_bool + 1, n_int = n_int + 1,
    n_bigint = n_bigint + 1, n_decimal = n_decimal + 1, n_float = n_float + 1,
    n_double = n_double + 1, d_date = d_date + 1, d_datetime = d_datetime + 1,
    d_timestamp = d_timestamp + 1, d_time = d_time + 1, d_year = d_year + 1,
    t_char = t_char + 1, t_varchar = t_varchar + 1, t_binary = t_binary + 1, 
    t_blob = t_blob + 1;

/* Prints out our current table after adding 1 to all entries */
SELECT * FROM type_tbl;

/* Minus one to all values in table */
UPDATE type_tbl SET 
    n_tinyint = n_tinyint - 1, n_bool = n_bool - 1, n_int = n_int - 1,
    n_bigint = n_bigint - 1, n_decimal = n_decimal - 1, n_float = n_float - 1,
    n_double = n_double - 1, d_date = d_date - 1, d_datetime = d_datetime - 1,
    d_timestamp = d_timestamp - 1, d_time = d_time - 1, d_year = d_year - 1,
    t_char = 'A' - 1, t_varchar = 'A' - 1, t_binary = 'A' - 1,
    t_blob = 'A' - 1;
/* Prints out our current table after subtracting 1 from all entries */
SELECT * FROM type_tbl;

/* Dividing all values in table by 2 */
UPDATE type_tbl SET 
    n_tinyint = n_tinyint / 2, n_bool = n_bool / 2, n_int = n_int / 2,
    n_bigint = n_bigint / 2, n_decimal = n_decimal / 2, n_float = n_float / 2,
    n_double = n_double / 2, d_date = d_date / 2, d_datetime = d_datetime / 2,
    d_timestamp = d_timestamp / 2, d_time = d_time / 2, d_year = d_year / 2,
    t_char = 'A' / 2, t_varchar = 'A' / 2, t_binary = 'A' / 2,
    t_blob = 'A' / 2;
/* Prints out our current table after dividing all entries by 2 */
SELECT * FROM type_tbl;

/* Multiplying all values in table by 2 */
UPDATE type_tbl SET 
    n_tinyint = n_tinyint * 3, n_bool = n_bool * 3, n_int = n_int * 3,
    n_bigint = n_bigint * 3, n_decimal = n_decimal * 3, n_float = n_float * 3,
    n_double = n_double * 3, 
    d_date = '2015-10-04' * 3, d_datetime = '2015-10-04 01:16:00' * 3,
    d_timestamp = '2015-10-04 01:16:00' * 3, 
    d_time = d_time * 3, d_year = 2015 * 3,
    t_char = 'A' * 3, t_varchar = 'A' * 3, t_binary = 'A' * 3,
    t_blob = 'A' * 3;
/* Prints out our current table after dividing all entries by 3 */
SELECT * FROM type_tbl;

/* Taking the modulo 2 of all values in table*/
UPDATE type_tbl SET 
    n_tinyint = n_tinyint % 2, n_bool = n_bool % 2, n_int = n_int % 2,
    n_bigint = n_bigint % 2, n_decimal = n_decimal % 2, n_float = n_float % 2,
    n_double = n_double % 2, d_date = '2015-10-04' % 2, 
    d_datetime = '2015-10-04 01:16:00' % 2,
    d_timestamp = '2015-10-04 01:16:00' % 2, 
    d_time = d_time % 2, d_year = 2015 % 2,
    t_char = 'A' % 2, t_varchar = 'A' % 2, t_binary = 'A' % 2,
    t_blob = 'A' % 2;
/* Prints out our current table after taking the modulo 2 of all values */
SELECT * FROM type_tbl;