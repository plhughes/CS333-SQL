/**
*Phoebe Hughes and Jenny Lin
*CS333
*Project 4
*semantics.c
*/

#include <stdio.h>
#include <stdlib.h>

int main(int arg, char *argv[]){
	long l = 6;      //makes long
	unsigned char *ptr;
	int h; /*loop count*/
	
	ptr= (unsigned char *)&(l);
	
	for (h=0; h<sizeof(l); h++){
		printf("Long 6: %u \n", ptr[h]);
		//shows how long is stored in memory
	}
	
	return 0;
}
