#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<omp.h>

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
	
main (int argc, char *argv[] )  {

	if (argc != 2) {
		printf("Too few arguments supplied.\n");
		return 0;
	}
	int nth = atoi(argv[1]);

	// Cria vetor do tamanho maximo para salvar os primos
	int primes[SIZE];

	// Primeiro primo é o numero 2
	primes[0] = 2;

	int i = 3;
	int count = 1;

	if (nth <= 6) {
		while (count < nth) {
			while (primo(i++, primes, count) == 0);
			count++;
		}
	}
	else {
		// Acha a estimativa inferior para Pn com base em n de forma paralela
		int logn = log(nth);
		int loglogn = log(logn);
		int estimate = nth*(logn + loglogn - 1);

		#pragma omp parallel \
		shared (estimate) \
		private (i) 

		#pragma omp for reduction (+ : count)
		for (i = 3; i < estimate; i++) {
			if (primo(i++, primes, count))
				count++;
		}

		while (count < nth) {
			while (primo(i++, primes, count) == 0);
			count++;
		}
	}

			
	printf("%d\n", i - 1);
}	
