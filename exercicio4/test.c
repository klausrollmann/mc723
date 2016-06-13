#include<stdio.h>
#define STARTUP_ADDRESS 0x6400000;

volatile int *lock = (volatile int *) STARTUP_ADDRESS;

int main( int ac, char *av[]) {

	printf("Lock está como %d\n", (*lock));
	printf("Lock agora está como %d\n", (*lock));
	printf("Libera o lock\n");
	*lock = 0;
	printf("Lock voltou a ser %d\n", (*lock));

	return 0;
}
