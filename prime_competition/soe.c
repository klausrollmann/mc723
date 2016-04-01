#include <stdio.h>

void sieve(int n, int primes[]);
main()
{
    int i, n = 2000000; // find the primes up to 500000
	int find = 100000;
    int v[n];
    sieve(n, v);
	int counter = 0;
	while (counter < find && i < n) {
        if (v[i++] == 1)
				counter++;
	}
	printf("%ld\n", i);
}
void sieve(int n, int primes[])
{
    int i, j;
    for (i=0;i<n;i++)
        primes[i]=1; // we initialize the sieve list to all 1's (True)
    primes[0]=0,primes[1]=0; // Set the first two numbers (0 and 1) to 0 (False)
    for (i=2;i*i< n;i++) // loop through all the numbers up to the sqrt(n)
        for (j=i*i;j<n;j+=i) // mark off each factor of i by setting it to 0 (False)
            primes[j] = 0;
}
