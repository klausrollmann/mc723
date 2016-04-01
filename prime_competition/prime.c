#include<stdio.h>
#include<math.h>
#include<stdlib.h>

#define SIZE 2000000

// Calcula ate o SIZE-esimo primo
int primo(int test_prime, int primes[], int n_primes) {

	int i;
	int sqroot = sqrt(test_prime);

	for (i = 0; primes[i] <= sqroot; i++) {
		if (test_prime % primes[i] == 0)
			return 0;
	}
		
	// If we got this far our number is a prime
	if (n_primes < SIZE) {
		primes[n_primes] = test_prime;
	}
	return 1;

}
	
int main (int argc, char* argv[])  {

	// Cria vetor do tamanho maximo para salvar os primos
	int primes[SIZE];

	int nth = atoi(argv[1]);

	// Primeiro primo é o numero 2
	primes[0] = 2;

	int i = 3;
	int count = 1;

	while (count < nth) {
		while (primo(i++, primes, count) == 0);
		count++;
	}
			
	printf("%d\n", i - 1);
	return 0;
}	
