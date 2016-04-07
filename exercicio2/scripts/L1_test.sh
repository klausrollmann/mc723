#!/bin/bash
echo -e "Teste 164 f2b\n\n" >> data_cachel1.txt

cd /home/staff/lucas/mc723/traces/164.gzip.f2b


echo "Teste tamanho da cache L1" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
echo "Block size: 32bytes" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
for ((i=1;i<=64;i=i*2)) ; do
	STR="K"
	echo "Tamanho da cache L1: $i$STR" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
	echo "Miss Rate" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
	../../dinero4sbc/dineroIV -informat s -trname gzip_f2b  -maxtrace 20 -l1-isize $i$STR -l1-dsize $i$STR -l1-ibsize 32 -l1-dbsize 32 | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_cachel1.txt
done

echo "Teste tamanho do bloco L1" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
echo "Cache size: 16KBytes" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
for ((i=1;i<=4096;i=i*2)) ; do
	echo "Tamanho do bloco: $i B" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
	echo "Miss Rate" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
	../../dinero4sbc/dineroIV -informat s -trname gzip_f2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize $i -l1-dbsize $i | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_cachel1.txt
done

echo "Teste associatividade cache L1" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
echo "Cache size: 16KBytes" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
echo "Block size: 64Bytes" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
for ((i=1;i<=16;i=i*2)) ; do
	echo "Associatividade: $i" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
	echo "Miss Rate" >> ~/Programas/MC723/exercicio2/data_cachel1.txt
	
	../../dinero4sbc/dineroIV -informat s -trname gzip_f2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 256 -l1-dbsize 64 -l1-dassoc $i -l1-iassoc $i | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_cachel1.txt
done
