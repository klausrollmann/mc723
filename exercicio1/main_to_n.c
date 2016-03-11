#include <stdio.h>

main (int argc, char *argv[] )  {

   if (argc != 2) {
      printf("Too many arguments supplied.\n");
		return 0;
	}
	int i = 0;
	int count = 0;
	int n = atoi(argv[1]);
	for (i = 2; i < n; i++) {
		if (primo(i))
			count++;
	}
	printf("Primos de 2 até %d: %d\n", n, count);
}	
