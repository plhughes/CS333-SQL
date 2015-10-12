/*
 * File: operatorPrecedence.sql
 * Shows operator precedence for: 
 * logical (and, or, not), equality, comparison, and the standard binary and unary operators
 * Author: Jenny Lin & Phoebe Hughes
 * Date: 10/19/2015
 */
 
 /* TURE evaluates to 1 and FALSE is 0*/
 SELECT TRUE; 
 SELECT FALSE; 
  
 /*Integers evaluate to TRUE*/
 SELECT (30 OR FALSE); 
 
 
 /*-------------------------------------------------------*/

 /* Logic: Evaluates not, and, and then or.*/
 
 /* NOT TRUE is evaluated to FALSE first, then FALSE AND FALSE => FALSE*/ 
 SELECT NOT TRUE AND FALSE; 

 
 /* NOT TRUE is evaluated to FALSE first, then FALSE AND FALSE is evaluated, then FALSE OR TRUE => TRUE*/
 SELECT NOT TRUE AND FALSE OR TRUE; 

 
 /*-------------------------------------------------------*/
 /* Equality and Comparison: >, <, =>, <=, =, != */

 /* = is used to set variables and to compare them. Therefore, the parentheses are needed for equalities*/
 SELECT (5 = 5); /*TRUE*/
 
 /*Note: a statement like this is legal. It is evaluated left to right.*/
 SELECT (0 = 48 > 395 ); /*FALSE: 0 = 48 is FALSE, then FALSE is not greater than 395, therefore, it is FALSE*/
 SELECT (395 < 48 = 0 ); /*TRUE: 395 < 48 is FALSE, but FALSE is 0, therefore 0 = 0 is TRUE.*/ 
 SELECT (8 > 6 > 1); /*FALSE: 8>6 is TRUE but TRUE evaluates to 1 and 1 > 1 is FALSE*/
 
 /*Equalities and Comparisons have higher precedence than not, and, or. */
 SELECT (5 < 7 AND TRUE); /*TRUE*/
 SELECT (NOT 5 != 7); /*FALSE*/
 SELECT (1 = 6 OR FALSE ); /*TRUE*/
 
 
/*-------------------------------------------------------*/
/*Standard Binary Operations: *, /, %, +, - */

/* *, / , % have precedence over + or - */
SELECT ( 20 / 10 + 5 ); /*7*/ 
SELECT ( 3 - 3 * 9); /*-24*/

/* Operators are evaluated left to right if they have the same precedence */
SELECT ( 20 / 10 * 5); /*10*/
SELECT ( 50 * 10 % 3 ); /*2*/

/*Binary Operations have precedence over equalities and comparisons and logic*/
SELECT ( 5 + 10 > 1 ); /*TRUE*/ 
SELECT ( 20 / 2 OR FALSE ); /*TRUE*/
/*If OR evaluated first then 2 OR FALSE would be TRUE, which is 1 and 20/1 would be 20*/ 


/*-------------------------------------------------------*/
/*Standard Unary Operations: !, -, + (! has precedence over -) */

/*Example unary operation*/
SELECT !5; /*TRUE: -5 is TRUE, then !TRUE is FALSE*/
SELECT -10; 

/*Unary operations have precedence over Binary operations, equalities and comparisons, and logic*/
SELECT ! 5 + 30 ; /*30: !5 evaluates to FALSE => 0 and 0 + 30 is 30 */
SELECT ! 5 = 5; /*FALSE*/
SELECT ! 20 < 10; /*TRUE*/
SELECT ! FALSE AND FALSE /*FALSE*/