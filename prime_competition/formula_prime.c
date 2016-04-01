#include <stdio.h>
#include <math.h>

main (int argc, char *argv[] )  {

	if (argc != 2) {
		printf("Too few arguments supplied.\n");
		return 0;
	}
	int nth = atoi(argv[1]);
	int prime = 0;
	if (nth == 1)
		prime = 2;
	else if (nth == 2)
		prime = 3;	
	else {
			int k;	
			k = (nth - 1)/2;
			if (nth % 2)
				prime = 6*k -1;
			else
				prime = 6*k + 1;
				
						
	}
	printf("%d\n", prime);		
		
}	
