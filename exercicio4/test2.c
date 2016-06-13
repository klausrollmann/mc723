#include<stdio.h>
#define STARTUP_ADDRESS 0x6400000;

volatile int procCounter = 0;
volatile int *lock = (volatile int *) STARTUP_ADDRESS;

void AcquireLock()
{
	while (*lock);
}

void ReleaseLock()
{
	*lock = 0;
}

int main( int ac, char *av[]) {
	int procNumber;
	int i;
	AcquireLock();
	procNumber = procCounter;
	procCounter++;
	ReleaseLock();
	
	for (i = 0; i < 10; i++) {
		AcquireLock();
		printf("Oi do processador %d\n", procNumber);
		ReleaseLock();
	}
	return 0;
}
