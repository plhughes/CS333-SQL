/* Authors: Jenny Lin & Phoebe Hughes
 * CS333 Project 7
 * Extension: Imitating memory management in SQL
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sql.h"

/* function to be used later */
void num_animals(){
  printf("Random function\n");
}

int main(int argc, char *argv[]) {

  Database *db; 
  LinkedList *ll;

  db = db_create("project_seven");              //CREATE DATABASE project_seven;
  tbl_delete(db, "animals");                    //DROP TABLE IF EXISTS animals;
  func_delete(db, "num_animals");               //DROP FUNCTION IF EXISTS num_animals;
  
  tbl_create(db, "animals");                    //CREATE TABLE animals

  /* Capabilities of this function changed to
     make implementation easier. The purpose of this function is to 
     demonstrate memory management */
  func_create(db, "num_animals", num_animals);  //CREATE FUNCTION num_animals()


  /*Creates rows in table*/
  ll = ll_create();
  ll_append(ll, "Cow");
  tbl_insert(db, "animals", ll);                //INSERT INTO animals (animal) VALUES ("Cow");
  
  ll = ll_create();
  ll_append(ll, "Dog");
  tbl_insert(db, "animals", ll);                //INSERT INTO animals (animal) VALUES ("Dog");


  /*Printing tables, and rows created*/
  db_print(db);                                 //SHOW TABLES;
  tbl_print(db, "animals");                     //SELECT * FROM animals;


  /*Deallocating memory*/
  tbl_clear(db, "animals");                     //DELETE FROM animals;
  tbl_print(db, "animals");                     //SELECT * FROM animals;


  /*Allocating so that we can deallocate again*/
  ll = ll_create();
  ll_append(ll, "Pig");
  tbl_insert(db, "animals", ll);                //INSERT INTO animals (animal) VALUES ("Pig");
  
  ll = ll_create();
  ll_append(ll, "Cat");
  tbl_insert(db, "animals", ll);                //INSERT INTO animals (animal) VALUES ("Cat");
  
  tbl_print(db, "animals");                     //SELECT * FROM animals;

  /*Deallocating memory*/
  tbl_clear(db, "animals");                     //TRUNCATE TABLE animals;
  tbl_print(db, "animals");                     //SELECT * FROM animals;

  tbl_delete(db, "animals");                    //DROP TABLE IF EXISTS animals;
  func_delete(db, "num_animals");               //DROP FUNCTION IF EXISTS num_animals;
  db_print(db);                                 //SHOW TABLES;

  db_delete(db);                                //DROP DATABASE IF EXISTS project_seven;
 
  return 0;
}
