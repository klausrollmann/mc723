# Projeto 1: Benchmarking
## Parte 3: avaliação de desempenho
Nome: Klaus Rollmann
RA: 146810

### Introdução
Nessa etapa do projeto, foram avaliados os desempenhos dos 30 computadores com base nas medições realizadas nas etapas anteriores, mostradas na tabela `benchmarks_medidas.ods`.

Para os benchmarks 1, 2 e 3 foram feitas análises de desempenho e classificação dos computadores para cada medida avaliada. Em seguida, todos os computadores foram avaliados com relação ao tempo de execução e foi feita uma classificação geral.

### Metodologia
A comparação dos computadores foi feita de forma semelhante a feita pelo SPEC[1], que calcula uma taxa que representa a relação de desempenho entre o computador avaliado e o computador de referência, e então calcula a média geométrica dessas taxas para um conjunto de benchmarks.

As taxas calculadas são sempre uma medida de 'quão rápido uma máquina é em relação a máquina referência'. Sendo assim, algumas vezes, a máquina mais rápida é a que apresenta a menor medida, nesses casos o inverso das medidas pode ser considerado para obter a medida de rapidez em relação a outra máquina.

Entretanto, as medidas obtidas foram limitadas, pois não houve um conjunto considerável de computadores que realizou um mesmo grupo de benchmarks. Desse modo, as medidas de benchmarks aqui obtidas poderiam ser mais precisas se todos os computadores tivessem feito todos os benchmarks.

### Análise dos Benchmarks

Para os benchmarks 1, 2 e 3 foram feitas análises das medidas obtidas para verificar se a medida obtida é uma medida boa ou não para avaliar o desempenho de um computador.

#### Benchmark 1 : Genetic
No primeiro benchmark foi analisada a taxa de escrita em disco do programa Genetic, que é um programa que recria a imagem através de polígonos semi transparentes que são gerados por um algoritmo genético.

Para esse experimento, a máquina de referência foi a máquina `12 - debios`, e as taxas de disco e taxa de tempo foram calculadas da seguinte forma:

##### Taxa de disco
Uma máquina é mais rápida na escrita no disco se tem uma maior taxa de escrita, sendo assim a taxa de disco é calculada como:

![formula1](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/write_formula.png)

Assim, quanto mais rápido a escrita, maior o valor da taxa calculada.

##### Taxa de tempo
Uma máquina é mais rápida se leva menos tempo para completar uma tarefa, sendo assim ela é mais rápida de o inverso do tempo for maior. A taxa de tempo é então:

![formula2](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/time_formula.png)
    
Assim, a taxa indica que a máquina é tantas vezes mais rápida que a referência.

##### Resultados
Para chegar a uma classificação, foi feita  média geométrica das duas taxas encontradas.
A tabela abaixo mostra os resultados

Tabela 1 - Classificação dos computadores do melhor desempenho para o menor para o benchmark 1.

| Máquina | Nome               | Tempo  | Desvio | Performance Disco | Desvio | Taxa Tempo | Taxa Disco | Média |
|---------|--------------------|--------|--------|-------------------|--------|------------|------------|-------|
| 5       | Klaus Rollman      | 59,38  | 4,58   | 133,61            | 7,58   | 1,04       | 1,64       | 1,30  |
| 18      | João Fidélis       | 54,38  | 1,58   | 106,73            | 12,40  | 1,13       | 1,31       | 1,22  |
| 10      | Renan Gomes        | 55,97  | 1,97   | 96,95             | 9,18   | 1,10       | 1,19       | 1,14  |
| 25      | Matheus Figueiredo | 62,43  | 1,71   | 101,34            | 12,86  | 0,99       | 1,24       | 1,11  |
| 13      | Gabriel Bueno      | 61,60  | 4,27   | 81,60             | 17,06  | 1,00       | 1,00       | 1,00  |
| 12      | debios             | 67,00  |        | 84,41             |        | 0,92       | 1,03       | 0,98  |
| 3       | Mateus Ruivo       | 84,64  | 5,32   | 78,30             | 14,17  | 0,73       | 0,96       | 0,84  |
| 22      | Pedro Grijó        | 68,93  | 3,23   | 56,63             | 4,92   | 0,89       | 0,69       | 0,79  |
| 30      | Matheus Pinheiro   | 78,80  | 9,58   | 58,24             | 19,20  | 0,78       | 0,71       | 0,75  |
| 4       | Pedro Meireles     | 48,85  | 3,99   | 25,68             | 1,92   | 1,26       | 0,31       | 0,63  |
| 8       | Luiz Sekijima      | 106,47 | 10,05  | 41,71             | 15,55  | 0,58       | 0,51       | 0,54  |
| 23      | Pedro Vasconcellos | 568,41 | 39,12  | 10,40             | 0,68   | 0,11       | 0,13       | 0,12  |

##### Análise

Com base na tabela, é possível ver que os dois fatores estão ligados, pois as máquinas com melhores tempos de execução também tiveram melhores tempos de escrita. Assim, a classificação gerada é uma boa avaliação da performance dos computadores em realizar essa tarefa.


#### Benchmark 2 : FFmpeg 
Nesse benchmark foi analisado a quantidade de `page-faults` e `stalled cycles` ocorridos durante o transcode de uma amostra de vídeo blu-ray 1080p no formato mp4 para o formato avi. A outra medida, de `stalled cycles`, não foi considerada pois alguns computadores não foram capazes de realizar essa medição. 

Para esse benchmark, a máquina de referência foi a máquina `5 - Klaus Rollmann`

##### Taxa de page-faults
Para calcular a taxa de page-faults, foi feito

![formula3](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/page_fault_formula.png)

##### Taxa de cache-misses
De forma semelhante, a taxa de cache-misses foi calculada como:

![formula4](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/cache_formula.png)
##### Taxa de tempo
A taxa de tempo também foi calculada como:

![formula5](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/time_formula.png)

##### Resultados
Novamente, os resultados foram obtidos tirando a média geométrica das três taxas. 

Tabela 2 - Classificação dos computadores do melhor desempenho para o menor para o benchmark 2.

| Máquina | Nome              | Page Faults | Misses          | Tempo de Execução | Taxa PF | Taxa CM | Taxa Tempo | Média |
|---------|-------------------|-------------|-----------------|-------------------|---------|---------|------------|-------|
| 6       | yk0 - Yugo Kuno   | 16470       | 918315918       | 32,576            | 1,24    | 1,34    | 0,95       | 1,17  |
| 8       | Luiz Sekijima     | 12112       | 2119978252      | 19,880            | 1,69    | 0,58    | 1,55       | 1,15  |
| 24      | Wendrey           | 16225       | 2608186738      | 14,840            | 1,26    | 0,47    | 2,08       | 1,07  |
| 13      | Gabriel Bueno     | 16509       | 2358000000      | 16,640            | 1,24    | 0,52    | 1,85       | 1,06  |
| 14      | Renan Castro      | 14145       | <not-supported> | 31,490            | 1,45    |         | 0,98       | 1,19  |
| 26      | Titouan Thibaud   | 20475       | 1234062095      | 30,860            | 1,00    | 1,00    | 1,00       | 1,00  |
| 16      | Victor Souza      | 21057       | 2156530201      | 18,190            | 0,97    | 0,57    | 1,70       | 0,98  |
| 15      | Gabriel Magalhães | 25168       | 2307322153      | 29,730            | 0,81    | 0,53    | 1,04       | 0,77  |
| 12      | debios            | 29942       | 2315532150      | 27,700            | 0,68    | 0,53    | 1,11       | 0,74  |
| 18      | João Fidélis      | 25172       | 2481891508      | 32,830            | 0,81    | 0,50    | 0,94       | 0,72  |
| 5       | Klaus Rollman     | 29618       | 2377000000      | 29,600            | 0,69    | 0,52    | 1,04       | 0,72  |
| 10      | Renan Gomes       | 25000       | 2531634416      | 69,650            | 0,82    | 0,49    | 0,44       | 0,56  |


##### Análise
Na tabela é possível ver que o número de cache-misses e page-faults não afetaram de modo significante o tempo de execução. Os computadores que tiveram melhores tempos de execução não necessáriamente foram os que tiveram menos page-faults e/ou cache miss. Sendo assim, para esse benchmark, as medidas de page-faults e cache-misses não implicam necessáriamente em um melhor desempenho para realizar a tarefa em questão.

#### Benchmark 3 : Convolução
O terceiro benchmark utilizado consistiu em realizar a operação de convolução com a Transformada de Fourier. Nesse caso as medidas de benchmark utilizadas foram escrita e leitura em disco. As medidas consideradas foram as médias e a máquina de referência é a máquina `yk0 - Yugo Kuno`

##### Taxa de escrita
Para escrita, a fórmula utilizada é dada por:

![formula223](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/write_formula.png)

##### Taxa de leitura
Para leitura a taxa é:

![formula2](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/read_formula.png)

##### Taxa de tempo
![formula2](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/time_formula.png)

##### Resultados
A tabela com a classificação dos computadores para escrita, leitura e tempo estão mostradas abaixo.

Tabela 3 - Classificação dos computadores do melhor desempenho para o menor para o benchmark 3.

| Máquina | Nome              | escrita (MB/s) | leitura (MB/s) | Tempo (s) | Taxa WR | Taxa RD | Taxa Tempo | Média |
|---------|-------------------|----------------|----------------|-----------|---------|---------|------------|-------|
| 15      | Gabriel Magalhães | 1758,20        | 4031,00        | 7,98      | 127,41  | 43,77   | 3,17       | 26,06 |
| 13      | Gabriel Bueno     | 1840,00        | 3144,46        | 7,90      | 133,33  | 34,14   | 3,20       | 24,43 |
| 5       | Klaus Rollman     | 1780,00        | 2360,00        | 7,60      | 128,99  | 25,62   | 3,33       | 22,25 |
| 7       | Cygnus X-1        | 1627,30        | 3702,80        | 13,70     | 117,92  | 40,20   | 1,85       | 20,61 |
| 27      | Titouan Thibaud   | 1103,20        | 2742,60        | 10,46     | 79,94   | 29,78   | 2,42       | 17,93 |
| 12      | debios            | 1085,00        | 2021,00        | 14,18     | 78,62   | 21,94   | 1,79       | 14,55 |
| 14      | Renan Castro      | 641,00         | 2781,00        | 36,30     | 46,45   | 30,20   | 0,70       | 9,93  |
| 24      | Wendrey           | 1426,10        | 2413,40        | 89,60     | 103,34  | 26,20   | 0,28       | 9,15  |
| 30      | Gustavo Basso     | 82,10          | 2065,64        | 123,70    | 5,95    | 22,43   | 0,20       | 3,01  |
| 16      | Victor Souza      | 10,90          | 793,00         | 7,01      | 0,79    | 8,61    | 3,61       | 2,91  |
| 6       | yk0 - Yugo Kuno   | 13,80          | 92,10          | 25,31     | 1,00    | 1,00    | 1,00       | 1,00  |

###### Análise

Para esse benchmark, é possível notar que a máquina de referência não era uma boa máquina para realizar essa tarefa, pois todas as outras tiveram um desempenho muito melhor em relação à ela. 

Além disso, tanto a escrita e leitura parecem ter tido certa influência no tempo de execução do programa. Com exceção da máquina 16, as máquinas com os melhores desempenhos gerais foram as com menor tempo de execução. 

Assim, esse benchmark, assim como o primeiro, parece ser uma boa forma de avaliar o desempenho de um computador para realizar a tarefa.

#### Comparação dos Benchmarks
A partir dos resultados obtidos nos benchmarks 1, 2 e 3, foi possível notar que a classificação dos computadores variou muito. Alguns computadores tiveram bons resultados em relação ao disco, mas resultados ruins para tempo de execução. O contrário também pode ser visto. Isso reforça a importância de que o benchmark avalia somente o desempenho para uma tarefa específica, sendo necessário, portanto, o uso de múltiplos benchmarks para se ter uma boa medida de desempenho de um computador. Somente assim pode-se considerar a comparação entre um computador e outro.

### Classificação Geral
Nessa etapa foi feita a classificação geral dos computadores com base no resultado de todos os benchmark.

Vale lembrar que os computadores não realizaram todos os benchmarks, sendo assim, os resultados são somente uma aproximação de qual máquina tem um melhor desempenho em relação às outras. 

Para chegar nos resultadoso abaixo, foi calculada a taxa de cada computador referente à máquina de referência para cada benchmark realizado, e foi tirada a média geométrica dessas medidas. Em seguida foi feita a classificação com base nesse resultado.


##### Taxa de Tempo

A taxa para cada benchmark foi calculada da seguinte forma:

![formula657](https://raw.githubusercontent.com/klausrollmann/mc723/master/trabalho1/time_formula.png)

Todas as medidas de tempo foram consideradas, para mais detalhes pode-se verificar a planilha `benchmark_medidas.ods`

A classificação geral é mostrada abaixo, em que a média representa a média geométrica de todas as taxas para todos os benchmarks. Basicamente ela indica qual computador foi mais rápido que a referência considerando a média de testes.

Tabela 4 - Classificação geral dos computadores do melhor desempenho para o menor para as medidas de benchmark de tempo de todos os benchmarks.

| #  | Máquina | Nome                  | Descrição CPU                                                                                                                                  | Média        |
|----|---------|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 1  | 18      | João Fidélis          | Intel Core i7-Intel(R) Core(TM) i7-4700HQ CPU @ 2.40GHz x 4, 16GB DDR3, Ubuntu 14.04LTS, HD: WD10S21X-24R1BTO / 7200RPM / Sata III             | 1,5676611742 |
| 2  | 5       | Klaus Rollman         | Intel(R) Core(TM) i7-3610QM CPU 4 cores, 8 threads @ 2.30GHz @ L1 256 KB / L2 1024 KB / L3 6144 KB                                             | 1,2465912614 |
| 3  | 10      | Renan Gomes           | Intel® Core™ i7-4702MQ CPU @ 2.20GHz × 8 (64 bits) Memory 8 GiB; Graphics Intel® Haswell Mobile ; Ubuntu 14.04                                 | 1,1309487961 |
| 4  | 26      | Titouan Thibaud       | Intel® Core™ i5-4590 CPU @ 3.30GHz × 4;  Memory 8 GiB;  64-bit graph: Intel® Haswell Desktop , Gnome: Version 3.18.2; Disk 216.9 GB; Fedora 23 | 1,1046350844 |
| 5  | 13      | Gabriel Bueno         | Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz x 2, 4 threads, 64-bit; Memory 8 GB DDR3; HD SATA 5400rpm;Ubuntu  15.10                               | 1,1022066318 |
| 6  | 7       | Cygnus X-1            | Intel® Core™ i7 × 4;  Memory 8 GiB;                                                                                                            | 1,0800330945 |
| 7  | 15      | Gabriel Magalhães     | Intel® Core™ i7-3612QM CPU @ 2.10GHz × 8; Memory 8GB, SSD Kingston 240GB V300 Sata III;  Ubuntu 15.04                                          | 1,040228573  |
| 8  | 25      | Matheus Figueiredo    | Intel Core i7-4700HQ CPU @ 2.4GHz, 16GB DDR3, Ubuntu 14.04LTS, HDD 5400RPM                                                                     | 0,9913970864 |
| 9  | 20      | Rodrigo Silva         | Intel(R) Core(TM) i5-2450M @ 2.5GHZ; Memory 6GB                                                                                                | 0,90157832   |
| 10 | 24      | Wendrey               | Intel Core i5-5200U CPU 2.20GHz x 4 L1 32KiB L2 256KiB L3 3MiB Memory 8GiB DDR3 Disk 1TB WDC WD10JPVX-22J Ubuntu 14.04 LTS                     | 0,8910700992 |
| 11 | 3       | Mateus Ruivo          | Intel(R) Core(TM) i3-3110M CPU @ 2.40GHz 3072 KB Cache, 4GB RAM DDR3, 5400rpm SATA                                                             | 0,8896889926 |
| 12 | 12      | debios                | Intel(R) Core(TM) i7-3612QM CPU @ 2.10GHz x 4, 8 threads, 8GB, 64-bit, SSD 32GB, HDD1TB (5400rpm), Debian                                      | 0,8756235707 |
| 13 | 6       | yk0 - Yugo Kuno       | AMD PhenonII, 4 cores, 3.2MHz; 10GB, ddr3, 1.333 MHz; hdd sata3, 7200rpm, 32MB buffer                                                          | 0,8719101579 |
| 14 | 22      | Pedro Grijó           | Intel(R) Core(TM) i7-2670QM CPU @ 2.20GHz x4, 8GB DDR 1333Mhz ,Ubuntu 14.04LTS 32bits,HDD: SAMSUNG HN-M101MBB / 5400 RPM/ Sata III             | 0,8586835957 |
| 15 | 19      | floyd                 | Intel(R) Core(TM)2 Quad CPU    Q8400  @ 2.66GHz, Memory 4GB                                                                                    | 0,8052289551 |
| 16 | 4       | Pedro Meireles        | Intel® Core™ i5-4590 CPU @ 3.30GHz × 4;  Memory 8 GiB;  64-bit graph: Intel® Haswell Desktop , Gnome: Version 3.18.2; Disk 216.9 GB; Fedora 23 | 0,7557484268 |
| 17 | 11      | Bruno Hori - Mamonas  | Intel(R) Core(TM)2 Quad CPU    Q8400  @ 2.66GHz                                                                                                | 0,5982168798 |
| 18 | 17      | IC301-Titan           | Intel® Core™2 Quad CPU Q8400 @ 2.66GHz × 4 Intel® Q45/Q43, 3.8GB RAM                                                                           | 0,5430286792 |
| 19 | 30      | Gustavo Basso         | Intel Core i7 @ 2.3GHz; 8 GB 1600 MHz DDR3                                                                                                     | 0,5412024966 |
| 20 | 8       | Luiz Sekijima         | Intel® Core™2 Duo CPU T6500 @ 2.10GHz × 2, 4GB RAM                                                                                             | 0,5171321845 |
| 21 | 9       | IC-legiao             | Intel® Core™2 Quad CPU Q8400 @ 2.66GHz × 4 Intel® Q45/Q43                                                                                      | 0,3953352267 |
| 22 | 14      | Renan Castro          | Intel(R) Core(TM) i7-3740QM CPU @ 2.70GHz @ 2 CORES @ Virtual Machine                                                                          | 0,3901707242 |
| 23 | 30      | Matheus Pinheiro      | Intel® Core™ i5-4200U CPU @ 1.60GHz × 4 ; Memory 3,8 GiB; Ubuntu 15.04 64-bit;                                                                 | 0,3832431082 |
| 24 | 21      | IC-sepultura          | Intel® Core™2 Quad CPU Q8400 @ 2.66GHz × 4 Intel® Q45/Q43 × 3.8GB RAM                                                                          | 0,3770542459 |
| 25 | 16      | Victor Souza          | Intel(R) Core(TM)2 Quad CPU Q8400  @ 2.66GHz; Memory 4GB, Fedora release 21                                                                    | 0,3159991016 |
| 26 | 31      | Netbook - Felipe Emos | Intel Atom Processor D4xx/D5xx/N4xx/N5xx DMI Bridge                                                                                            | 0,1727163467 |
| 27 | 23      | Pedro Vasconcellos    | Raspberry Pi, 900MHz quad-core ARM Cortex-A7 CPU, 1GB RAM, 32GB SD Card                                                                        | 0,0536008539 |
| -  | 1       | lab-3 baia 5          | Intel Core i5 Haswell 2MB Cache, 4GB DDR3 1600, Seagate 1TB 7200rpm 8MB cache, Gigabit Ethernet                                                | Insuficiente |
| -  | 2       | DeepLOL               | Intel 486DX 33MHz 64KB Cache, 8MB SRAM, 512MB, 5400rpm Barracuda, 10MB Ethernet                                                                | Insuficiente |
| -  | 27      | Titouan Thibaud       | Intel Core i7-2630QM CPU @2.00GHz Memory 4GiB Linux Mint                                                                                       | Insuficiente |
| -  | 28      | Rafael Faria          | Intel(R) Core(TM) i7-4750HQ CPU @ 2.00GHz; Memory 8 GB 1600 MHz DDR3; Mac OS X El Capitan (version 10.11.4)                                    | Insuficiente |
| -  | 29      | João Paulo            | Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz; Memory 16 GB; Ubuntu 14.04.4                                                                         | Insuficiente |

#### Análise dos Resultados
Pela tabela, é possível notar que as máquinas com melhor classificação são as com melhor processador, e as com pior classificação são as com os piores processadores. Sendo assim, pode-se concluir que o benchmark conseguiu comparar as máquinas corretamente para o fator de melhor desempenho de processamento.

### Referências
[1]: David A. Patterson and John L. Hennessy, Computer Organization and Design, 4th Edition, p.48-50.
