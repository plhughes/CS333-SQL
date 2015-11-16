/* Authors: Jenny Lin & Phoebe Hughes
 * CS333 Project 7
 * LinkedList data structure
 */

#include <stdio.h>
#include <stdlib.h>
#include "sql.h"

//creates a new LinkedList struct, initializes it, and returns it
LinkedList *ll_create(){
  LinkedList *l = malloc(sizeof(LinkedList));
  l->head = NULL;
  l->size = 0;
  return l;
}

//adds a node to the front of the list, storing the given data in the node
void ll_push(LinkedList *l, void *data){
  Node *n = malloc(sizeof(Node));
  n->data = data;
  n->next = l->head;
  l->head = n;
  l->size++;
}

//removes the node at the front of the list and returns the associated data
void *ll_pop(LinkedList *l){
  Node *n = l->head;
  void *data = n->data; 
  l->head = l->head->next;
  l->size--;
  free(n);
  return data;
}

//adds a node to the end of the list, storing the given data in the node
void ll_append(LinkedList *l, void *data){
  Node *n = malloc(sizeof(Node));
  n->data = data;
  n->next = NULL;

  //if the list is empty
  if(l->head == NULL){
    n->next = l->head;
    l->head = n;
  }
  else{
    Node *temp = l->head;
    //loop through until we hit the last node
    while(temp->next != NULL){
      temp = temp->next;
    }
    temp->next = n;
  }
  l->size++;
}

//removes the first node in the list whose data matches target given the 
//comparison function. The function returns the pointer to the data.
void *ll_remove(LinkedList *l, void *target, int (*compfunc)(void *, void *)){
  Node *temp = l->head;
  Node *tempPrev = NULL;
  void *data = NULL; //holds the data to be returned while the node is freed

  while( temp != NULL ){
    if(compfunc(target, temp->data) == 0){

      //removing at head of list
      if(tempPrev == NULL){
	l->head = l->head->next;
	l->size--;
	data = temp->data;
	free(temp);
	return data;
      }
      else{
	tempPrev->next = temp->next;
	l->size--;
	data = temp->data;
	free(temp);
	return data;
      }
    }
    tempPrev = temp;
    temp = temp->next;
  }
  return data;
}

//returns the size of the list
int ll_size(LinkedList *l){
  return l->size;
}

//removes all of the nodes from the list
//frees the associated data using the given function
void ll_clear(LinkedList *l, void (*freefunc)(void *)){
  Node *temp = l->head;
  while(temp != NULL){
    l->head = l->head->next;
    freefunc(temp->data);
    free(temp);
    temp = l->head;
  }
  l->size = 0;
}

//traverses the list and applies the given function to the data at each node
void ll_map(LinkedList *l, void (*mapfunc)(void *)){
  Node *n = l->head;
  while( n != NULL ){
    mapfunc(n->data);
    n = n->next;
  }
}
