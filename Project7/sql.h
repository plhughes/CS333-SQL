/* Authors: Jenny Lin & Phoebe Hughes
 * CS333 Project 7
 * Extension: Demostrating SQL memory management in C
 * SQL imitation header file
 */

#ifndef SQL_H
#define SQL_H

struct node{
  void *data; //arbitrary pointer to data
  struct node *next; //next pointer
};

typedef struct node Node; //so that we don't have to type struct everytime

typedef struct{
  Node *head; //points to the head of the list
  int size; //stores the size of the list
} LinkedList;

typedef struct{
  int primaryID;
  LinkedList *data;
} Row;

typedef struct{
  char *tableName;
  LinkedList *rows;
} Table;

typedef struct{
  char *functionName;
  void (*func)(void *);
} Function;

typedef struct{
  LinkedList *tables;
  LinkedList *functions;
} Database;

/* Helper functions */
void printTab(void *s);
void printLine(void *s);

/* Linked List */
LinkedList *ll_create();
void ll_push(LinkedList *l, void *data);
void *ll_pop(LinkedList *l);
void ll_append(LinkedList *l, void *data);
void *ll_remove(LinkedList *l, void *target, int (*compfunc)(void *, void *));
int ll_size(LinkedList *l);
void ll_clear(LinkedList *l, void (*freefunc)(void *));
void ll_map(LinkedList *l, void (*mapfunc)(void *));

/* Row */
Row *row_create(int PID, LinkedList *data);
void row_clear(Row *r);
void row_print(Row *r);

/* Table */
Table *tbl_exists(Database *db, char *name);
void tbl_create(Database *db, char *name);
void tbl_clear(Database *db , char *name);
void tbl_delete(Database *db , char *name);
void tbl_insert(Database *db, char *tblName, LinkedList *data);
void tbl_print(Database *db, char *tblName);

/* Function */
Function *func_exists(Database *db, char *name);
void func_create(Database *db, char *name, void (*function)(void *));
void func_delete(Database *db, char *name);

/* Database */
Database *db_create(char *name);
void db_delete(Database *db);
void db_print(Database *db);
void db_addTable(Database *db, Table *tbl);
void db_addFunction(Database *db, Function *func);
#endif
