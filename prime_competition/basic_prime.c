#include <stdio.h>
#include <math.h>
#include <omp.h>

int primo(int n) {
	int i;
	if (n > 2 && n % 2 == 0)
		return 0;

	for(i = 3; i <= sqrt(n); i += 2)
		if (n % i == 0)
			return 0;

	return 1;
}

main (int argc, char *argv[] )  {

	if (argc != 2) {
		printf("Too few arguments supplied.\n");
		return 0;
	}
	int nth = atoi(argv[1]);
	int i = 2;
	int count = 0;

	if (nth < 10000) {
		while (count < nth) {
			while (primo(i++) == 0);
			count++;
		}
	}
	else {
		
		// Acha a estimativa inferior para Pn com base em n de forma paralela
		int logn = log(nth);
		int loglogn = log(logn);
		int estimate = nth*(logn + loglogn - 1);
		printf("%d\n", estimate);

		#pragma omp parallel \
		shared (estimate) \
		private (i) 

		#pragma omp for reduction (+ : count)
		for (i = 2; i < estimate; i++) {
			if (primo(i))
				count++;
		}

		while (count < nth) {
			while (primo(i++) == 0);
			count++;
		}
	}

	printf("%d\n", i - 1);
}	
