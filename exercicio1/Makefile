# Makefile

CC = gcc

run: main.o calc_primo.o
	$(CC) -o run calc_primo.o main.o

main.o: main.c
	$(CC) -c main.c

calc_primo.o: calc_primo.c 
	$(CC) -c calc_primo.c 
