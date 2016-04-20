#include<stdio.h>

int main () {

	int i = 0;
	int v[100];
	for (i = 0; i < 100; i++) {
		v[i] = i * i;
	}
	for (i = 0; i < 50; i++) {
		v[i] = v[i] + v[100-i];
	}
	for (i = 0; i < 100; i++) {
		printf("%d ", v[i]);
	}
	printf("\n");
	
	return 0;

}
