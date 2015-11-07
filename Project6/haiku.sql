/*
 * File: functions.sql
 * Displays how to write to and get data from a file
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 11/09/2015
 */

/* Creating database */
DROP DATABASE IF EXISTS project_six;
CREATE DATABASE project_six;
USE project_six;


/*Dynamically creating functions*/
PREPARE func_tion FROM
"SELECT 'Create dynamic'";
EXECUTE func_tion;
