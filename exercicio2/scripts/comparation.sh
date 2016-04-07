#!/bin/bash

echo "Comparacao melhor configuração cache" >> ~/Programas/MC723/exercicio2/data_caches.txt

echo "164-F2B">> ~/Programas/MC723/exercicio2/data_caches.txt
cd /home/staff/lucas/mc723/traces/164.gzip.f2b

../../dinero4sbc/dineroIV -informat s -trname gzip_f2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 64 -l1-dbsize 256 -l1-iassoc 2 -l1-dassoc 2 -l2-usize 512K -l2-ubsize 4096 -l2-uassoc 8 | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_caches.txt

echo "164-M2B">> ~/Programas/MC723/exercicio2/data_caches.txt
cd /home/staff/lucas/mc723/traces/164.gzip.m2b

../../dinero4sbc/dineroIV -informat s -trname gzip_m2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 64 -l1-dbsize 256 -l1-iassoc 2 -l1-dassoc 2 -l2-usize 512K -l2-ubsize 4096 -l2-uassoc 8 | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_caches.txt

echo "168-F2B">> ~/Programas/MC723/exercicio2/data_caches.txt
cd /home/staff/lucas/mc723/traces/168.wupwise.f2b

../../dinero4sbc/dineroIV -informat s -trname wupwise_f2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 64 -l1-dbsize 256 -l1-iassoc 2 -l1-dassoc 2 -l2-usize 512K -l2-ubsize 4096 -l2-uassoc 8 | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_caches.txt

echo "168-M2B">> ~/Programas/MC723/exercicio2/data_caches.txt
cd /home/staff/lucas/mc723/traces/168.wupwise.m2b

../../dinero4sbc/dineroIV -informat s -trname wupwise_m2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 64 -l1-dbsize 256 -l1-iassoc 2 -l1-dassoc 2 -l2-usize 512K -l2-ubsize 4096 -l2-uassoc 8 | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_caches.txt

echo "171-F2B">> ~/Programas/MC723/exercicio2/data_caches.txt
cd /home/staff/lucas/mc723/traces/171.swim.f2b

../../dinero4sbc/dineroIV -informat s -trname swim_f2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 64 -l1-dbsize 256 -l1-iassoc 2 -l1-dassoc 2 -l2-usize 512K -l2-ubsize 4096 -l2-uassoc 8 | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_caches.txt

echo "171-M2B">> ~/Programas/MC723/exercicio2/data_caches.txt
cd /home/staff/lucas/mc723/traces/171.swim.m2b

../../dinero4sbc/dineroIV -informat s -trname swim_m2b  -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 64 -l1-dbsize 256 -l1-iassoc 2 -l1-dassoc 2 -l2-usize 512K -l2-ubsize 4096 -l2-uassoc 8 | grep "miss rate" | awk '{ print $4 }' >> ~/Programas/MC723/exercicio2/data_caches.txt
