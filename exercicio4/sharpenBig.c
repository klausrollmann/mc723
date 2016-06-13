#include<stdio.h>
#include "sharpenBig.h"

void AcquireLock()
{
	while (*lock);
}
void ReleaseLock()
{
	*lock = 0;
}

// aplica filtro sharpen e retorna novo valor da imagem
int calcSharpen(int i, int j) {
	int sum = 0;
	int div = 0;

	// norte
	if (i > 0) {
		// pixel noroeste
		if (j > 0) {
			div++;
			sum += image[i-1][j-1] * sharpen[0][0];
		}
		// pixel norte
		div++;
		sum += image[i-1][j] * sharpen[0][1];
		// pixel nordeste
		if (j < IMGSZ - 1) {
			div++;
			sum += image[i-1][j+1] * sharpen[0][2];
		}
	}
	// centro
	// pixel oeste
	if (j > 0) {
		div++;
		sum += image[i][j-1] * sharpen[1][0];
	}
	// pixel central
	div++;
	sum += image[i][j] * sharpen[1][1];
	// pixel leste
	if (j < IMGSZ - 1) {
		div++;
		sum += image[i][j+1] * sharpen[1][2];
	}
	// sul 
	if (i < IMGSZ - 1) {
		// pixel sudoeste
		if (j > 0) {
			div++;
			sum += image[i+1][j-1] * sharpen[2][0];
		}
		// pixel sul
		div++;
		sum += image[i+1][j] * sharpen[2][1];
		// pixel sudeste
		if (j < IMGSZ - 1) {
			div++;
			sum += image[i+1][j+1] * sharpen[2][2];
		}
	}

	return sum/div;
}

int main( int ac, char *av[]) {
	int procNumber;
	int i, j;

	/* Atualiza procCounter */
	AcquireLock();
	procNumber = procCounter;
	procCounter++;
	ReleaseLock();

	/* Cada processador faz uma metade da imagem */
	int start = (IMGSZ/2)*procNumber;
	int end = start + IMGSZ/2;

	for (i = start; i < end; i++) {
		for (j = 0; j < IMGSZ; j++) { 
			image[i][j] = calcSharpen(i, j);	
		}
	}


	/* Processador 0 imprime a imagem */
	if (procNumber == 0) {
		for (i = 0; i < IMGSZ; i++) { 
			for (j = 0; j < IMGSZ; j++) { 
				printf("%d ", image[i][j]);
			}
			printf("\n");
		}
	}

	return 0;
}
