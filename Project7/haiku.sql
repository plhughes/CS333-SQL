/*
 * File: haiku.sql
 * Shows allocation of memory
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 11/16/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_seven;
CREATE DATABASE project_seven;
USE project_seven;

/*haiku*/
/*Shows allocation of memory by creating table*/
CREATE TABLE mem(
    PRIMARY KEY ( al_lo_cate ),
	al_lo_cate DOUBLE
);


/*Testing to show it is a valid query*/
INSERT INTO mem (al_lo_cate) VALUES (1.0);
SELECT * FROM mem;



