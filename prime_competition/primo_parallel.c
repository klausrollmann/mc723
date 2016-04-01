#include <stdio.h>
#include <math.h>
#include<omp.h>

int primo(int n) {
	int i;
	if (n > 2 && n % 2 == 0)
		return 0;
	for(i = 3; i * i <= n; i += 2)
		if (n % i == 0)
			return 0;

	return 1;
}

main (int argc, char *argv[] )  {

	if (argc != 2) {
		printf("Too many arguments supplied.\n");
		return 0;
	}
	int n = atoi(argv[1]);
	int i = 0;
	int count = 0;

// Especifica que 'n' deve ser compartilhado entre todas as threads e que cada thread deve ter seu valor de 'i'
/*
# pragma omp parallel \
  shared (n) \
  private (i) 
*/

// Especifica que a variável 'count' deve ser reduzida somando-se os valores de 'count' de cada thread. Ao final 'count' possui a soma dos valores de 'count' de cada thread gerada.
# pragma omp for reduction (+ : count)
	for (i = 2; i < n; i++) {
		if (primo(i))
			count++;
	}

	printf("Primos de 2 até %d: %d\n", n, count);
}	
