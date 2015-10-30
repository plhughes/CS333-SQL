/**
 * File: haiku.sql
 * Demonstrates internal representation and limitations of ints and floats
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 11/3/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS table_with_blobs;
CREATE DATABASE table_with_blobs;
USE table_with_blobs;

/* Deleting Old Table */
DROP TABLE IF EXISTS pol;
DROP TABLE IF EXISTS blobs;

/*----Haiku starts here-----*/
CREATE TABLE pol(
    use_polymorphic_type BLOB,
	is_generic BLOB
);

INSERT INTO pol
VALUES ("can be any type", 4);
USE table_with_blobs;


/*
Haiku:

create table pol
use polymorphic type blob
is generic blob

insert into pol
values can be any type for
use table with blobs
*/
 
 
SELECT * from pol;