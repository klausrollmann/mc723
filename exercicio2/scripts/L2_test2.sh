#!/bin/bash
echo -e "Teste 164 m2b\n\n" >> data2_cachel2.txt

cd /home/staff/lucas/mc723/traces/164.gzip.m2b

echo "Teste tamanho da cache L2" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt

echo "Block size: 64bytes" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
for ((i=8;i<=1024;i=i*2)) ; do
       STR="K"
	echo "Tamanho da cache L2: $i$STR" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
	echo "Miss Rate" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
	../../dinero4sbc/dineroIV -informat s -trname gzip_m2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 256 -l1-dbsize 64 -l1-dassoc 2 -l1-iassoc 2 -l2-usize $i$STR -l2-ubsize 128 | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
done

echo "Teste tamanho do bloco L2" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
echo "Cache size: 512KBytes" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
for ((i=4;i<=4096;i=i*2)) ; do
	echo "Tamanho do bloco: $i B" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
	echo "Miss Rate" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
	../../dinero4sbc/dineroIV -informat s -trname gzip_m2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 256 -l1-dbsize 64 -l1-dassoc 2 -l1-iassoc 2 -l2-usize 512K -l2-ubsize $i | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
done

echo "Teste associatividade L2" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
echo "Cache size: 4KBytes" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
echo "Block size: 4096Bytes" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
for ((i=1;i<=32;i=i*2)) ; do
	echo "Associatividade: $i" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
	echo "Miss Rate" >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
       ../../dinero4sbc/dineroIV -informat s -trname gzip_m2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 256 -l1-dbsize 64 -l1-dassoc 2 -l1-iassoc 2 -l2-usize 512K -l2-ubsize 4096 -l2-uassoc $i | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data2_cachel2.txt
done
