#!/bin/sh

# Diretório com o simulador e archC
MYDIR="/home/ec2013/ra146810/Programas/MC723/exercicio3/"
cd $MYDIR

# Pasta com o simulador
SIMULATOR=$MYDIR"/mips-1.0.2/mips.x --load="

# Pasta com os programas que serão executados
DIR="/home/staff/lucas/mc723/ex3/MipsMibench/"

# Comando para realizar a compilaçao
COMPILE="mips-newlib-elf-gcc -specs=archc "

# Executa Dijkstra Small
echo "DIJKSTRA SMALL"
cd $DIR"network/dijkstra"
${SIMULATOR}dijkstra_small input.dat > $MYDIR/output_small.dat

# Executa Rijndael Coder Small
echo "RIJNDAEL CODER SMALL" 
cd $DIR"security/rijndael/"
${SIMULATOR}rijndael input_small.asc $MYDIR/output_small.enc e 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321

# Executa Susan Corners Large
echo "SUSAN CORNERS LARGE"
cd $DIR"automotive/susan/"
${SIMULATOR}susan input_large.pgm $MYDIR/output_large.corners.pgm -c
