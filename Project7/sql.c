/* Authors: Jenny Lin & Phoebe Hughes
 * CS333 Project 7
 * Basic SQL setup
 * See memoryInC.c for Task 2 imitation in C
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sql.h"

/* Print input string, separated by tab */
void printTab(void *s){
  char *c = (char *)s;
  printf("%s\t", c);
}

/* Print input string, separated by line */
void printLine(void *s){
  char *c = (char *)s;
  printf("%s\n", c);
}

/* Compares two functions and see if they are the same */
int compFunc(void *i, void*j){
  Function *a = (Function *)i;
  Function *b = (Function *)j;

  return strcmp(a->functionName, b->functionName);
}

/* Compares two Tables and see if they are the same */
int compTbl(void *i, void*j){
  Table *a = (Table *)i;
  Table *b = (Table *)j;

  return strcmp(a->tableName, b->tableName);
}

/* Given a primary ID and contents of row, create one and return it */
Row *row_create(int PID, LinkedList *data){
  Row *r = malloc(sizeof(Row));
  r->primaryID = PID;
  r->data = data;
  return r;
}

/* Clears and frees the linked list of data */
void row_clear(Row *r){
  Node *temp = r->data->head;
  while(temp != NULL){
    r->data->head = r->data->head->next;
    free(temp);
    temp = r->data->head;
  }
  free(r->data);
}

/* Print the data in the rows, separated by tabs */
void row_print(Row *r){
  if( r != NULL ){
    printf("%d \t", r->primaryID);
    ll_map( r->data, printTab );
    printf("\n");
  }
}
  
/* Check to see if a table under the same name exists in the database 
   Return the table if it exists, else null */
Table *tbl_exists(Database *db, char *name){
  Node *n;
  Table *temp;

  //Loop through linked list of tables to check of matching names 
  n = db->tables->head;
  while( n != NULL ){
    temp = (Table*)n->data;
    if(strcmp(temp->tableName, name) == 0)
      return temp;
    n = n->next;
  }
  return NULL;
}
  

/* Given a table name and database, 
   create an empty table and add it to the database */
void tbl_create(Database *db, char *name){
  
  Node *n = db->tables->head;
  Table *tbl;

  //Check to see if table already exists
  tbl = tbl_exists(db, name);

  if(tbl == NULL){
    //Create the table
    tbl = malloc(sizeof(Table));
    tbl->tableName = name;
    tbl->rows = ll_create();
    
    //Add to database
    db_addTable(db, tbl);
    printf("Table %s added to Database\n", name);
  }
  else
    printf("Table %s exists. Table Creation Failure.\n", name);
}

/* Clears the table, freeing its rows */
void tbl_clear(Database *db , char *name){
  Node *n = db->tables->head;
  Table *tbl;

  //Check to see if table already exists
  tbl = tbl_exists(db, name);

  //if the table exists, free its rows
  if(tbl != NULL){
    n = tbl->rows->head;
    while( n != NULL ){
      tbl->rows->head = tbl->rows->head->next;
      row_clear(n->data);
      free(n->data);
      free(n);
      n = tbl->rows->head;
    }
    printf("Table %s cleared.\n", name);
  }
  else
    printf("Table %s does not exist. Clearing failed.\n", name);
}

/* Deletes the table from database
   Imitates SQL's DROP IF EXISTS */
void tbl_delete(Database *db, char *name){
  Node *n = db->tables->head;
  Table *tbl;

  //Check to see if table already exists
  tbl = tbl_exists(db, name);

  //if the table exists
  if(tbl != NULL){
    ll_remove(db->tables, tbl, compTbl );
    //Clearing contents
    n = tbl->rows->head;
    while( n != NULL ){
      tbl->rows->head = tbl->rows->head->next;
      row_clear(n->data);
      free(n->data);
      free(n);
      n = tbl->rows->head;
    }
    //frees the table
    free(tbl->rows);
    free(tbl);
    printf("Table %s deleted. \n", name);
  }
  else
    printf("Table %s does not exist.\n", name);
}

/* Adds a row to the table. Equivalent to SQL's insert */
void tbl_insert(Database *db, char *tblName, LinkedList *data){
  
  Row *newRow;
  Table *tbl;
  
  //Checks and see if table exists in the database
  tbl = tbl_exists(db, tblName);
  
  //Make insertion if table exists
  if(tbl != NULL){
    //create a new row with an auto incremented PID
    newRow = row_create(ll_size(tbl->rows) + 1, data);
    ll_append(tbl->rows, newRow);
    printf("Row inserted into table %s.\n", tblName);
  }
  else
    printf("Table %s does not exist. Insertion failed\n", tblName);
}

/* Print out contents of table */
void tbl_print(Database *db, char *tblName){
  Node *temp;
  Table *tbl;

  //Checks and see if table exists in the database
  tbl = tbl_exists(db, tblName);
  
  //Print if table exists
  if(tbl != NULL){  
    temp = tbl->rows->head;
    printf("\nTable: %s\n", tbl->tableName);
    //Loop through linked list of rows and print them out
    while( temp != NULL ){
      row_print(temp->data);
      temp = temp->next;
    }
  }
  else
    printf("Table %s does not exist. Printing failed.\n", tblName);
}

/* Check to see if a function under the same name exists in the database 
   Return the function if it exists, else null */
Function *func_exists(Database *db, char *name){
  Node *n;
  Function *func;

  //Check to see if function already exists
  n = db->functions->head;
  while( n != NULL ){
    func = (Function *)n->data;
    if(strcmp(func->functionName, name) == 0){
      return func;
    }
    n = n->next;
  }
  return NULL;
}

/* Given a function name, a database and the function itself, 
   create a Function and add to database*/
void func_create(Database *db, char *name, void (*function)(void *)){
  
  //Check to see if the function already exists
  Function *func = func_exists(db, name);

  if(func == NULL){
    //creating function
    func = malloc(sizeof(Function));
    func->functionName = name;
    func->func = function;
    
    //Add to database
    db_addFunction(db, func);
    printf("Function %s added to database.\n", name);
  }
  else
    printf("Function %s exists. Function creation failed.\n", name);
}

/* Frees a Function 
   Imitates SQL's DROP IF EXISTS */
void func_delete(Database *db, char *name){
  
  Node *n = db->tables->head;
  Function *func;
  
  //get the function from the database
  func = func_exists(db, name);

  //frees the function if it exists
  if(func != NULL){
    ll_remove(db->functions, func, compFunc );
    free(func);
    printf("Function %s deleted.\n", name);
  }
  else
    printf("Function %s does not exist.\n", name);
}

/* Given a database name, create a database */
Database *db_create(char *name){
  Database *db = malloc(sizeof(Database));
  db->tables = ll_create();
  db->functions = ll_create();
  printLine("Database Created");
  return db;
}

/* Deletes the database, freeing its tables and functions*/
void db_delete(Database *db){
  Node *temp; 
  Table *tbl;
  Function *func;

  //Loop through linked list of tables and delete them
  temp = db->tables->head;
  while( temp != NULL ){
    tbl = (Table *)temp->data;
    tbl_delete(db, tbl->tableName);
    db->tables->head = db->tables->head->next;
    free(temp);
    temp = db->tables->head;
  }
  free(db->tables);

  //Loop through linked list of functions and delete them
  temp = db->functions->head;
  while( temp != NULL ){
    func = (Function *)temp->data;
    func_delete(db, func->functionName);
    db->functions->head = db->functions->head->next;
    free(temp);
    temp = db->functions->head;
  }
  free(db->functions);
  free(db);
  printLine("Database deleted");
}

/* Prints out tables and functions under the database */
void db_print(Database *db){
  Node *temp;
  Table *tbl;
  Function *func;

  //Loop through linked list of tables and print them out
  printLine("Tables:");
  temp = db->tables->head;
  while( temp != NULL ){
    tbl = (Table *)temp->data;
    printLine(tbl->tableName);
    temp = temp->next;
  }

  //Loop through linked list of functions and print them out
  temp = db->functions->head;
  printLine("\nFunctions:");
  while( temp != NULL ){
    func = (Function *)temp->data;
    printLine(func->functionName);
    temp = temp->next;
  }
}

/* Add a table to the database */
void db_addTable(Database *db, Table *tbl){
  ll_append(db->tables, tbl);
}

/* Add a function to the database */
void db_addFunction(Database *db, Function *func){
  ll_append(db->functions, func);
}

