#!/bin/sh

export PATH=$PATH:/home/ec2013/ra146810/Programas/MC723/exercicio3/archc/bin/:/home/ec2013/ra146810/Programas/MC723/exercicio3/archc/compilers/mips-newlib-elf/bin/

export LD_LIBRARY_PATH=/home/ec2013/ra146810/Programas/MC723/exercicio3/systemc/lib-linux64:$LD_LIBRARY_PATH

MYDIR="/home/ec2013/ra146810/Programas/MC723/exercicio3/"
cd $MYDIR

SIMULATOR=$MYDIR"/mips-1.0.2/mips.x --load="
RIJNDAEL="/home/staff/lucas/mc723/ex3/MipsMibench/security/RIJNDAEL"
DIJKSTRA="/home/staff/lucas/mc723/ex3/MipsMibench/"
DIR="/home/staff/lucas/mc723/ex3/MipsMibench/"
COMPILE="mips-newlib-elf-gcc -specs=archc "

echo "DIJKSTRA SMALL"
cd $DIR"network/dijkstra"
${SIMULATOR}dijkstra_small input.dat > $MYDIR/output_small.dat

echo "RIJNDAEL CODER SMALL" 
cd $DIR"security/rijndael/"
${SIMULATOR}rijndael input_small.asc $MYDIR/output_small.enc e 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321

echo "SUSAN CORNERS LARGE"
cd $DIR"automotive/susan/"
${SIMULATOR}susan input_large.pgm $MYDIR/output_large.corners.pgm -c


