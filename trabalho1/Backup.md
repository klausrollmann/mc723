# Projeto 1: Benchmarking
## Parte 3: avaliação de desempenho
Nome: Klaus Rollmann  
RA: 146810

### Introdução
Nessa etapa do projeto, foram avaliados os desempenhos dos 30 computadores com base nas medições realizadas nas etapas anteriores, mostradas na tabela.
Para os benchmarks 1, 2 e 3 foram feitas análises de desempenho e classificação dos computadores para cada medida avaliada. Em seguida, todos os computadores foram avaliados com relação ao tempo de execução e taxa de escrita em disco e foi feita uma classificação geral.

### Avaliação de desempenho
A comparação dos computadores foi feita de forma semelhante a feita pelo SPEC[^fn1], que calcula uma taxa que representa a relação de desempenho entre o computador avaliado e o computador de referência, e então calcula a média geométrica dessas taxas para um conjunto de benchmarks.

Para os benchmarks 1, 2 e 3, foi feita uma classificação considerando somente os computadores que realizaram a medida do benchmark analisada.

Para a classificação geral, foi tirada a média geométrica das taxas dos benchmarks para cada computador e o valor encontrado foi usado para comparar os computadores e gerar uma classificação geral para todos os computadores.

### Benchmarks e Classificação
#### Benchmark 1 : Genetic
No primeiro benchmark foi analisada a taxa de escrita em disco do programa Genetic, que é um programa que recria a imagem através de polígonos semi transparentes que são gerados por um algoritmo genético. O tempo de execução foi considerado somente ao avaliar todos os computadores

Essa taxa foi calculada da seguinte forma:

<img src="http://www.sciweavers.org/tex2img.php?eq=%5Cfrac%7B%5Ctext%7Btaxa%20de%20escrita%20referencia%7D%7D%7B%5Ctext%7Btaxa%20de%20escrita%20computador%7D%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="\frac{\text{taxa de escrita referencia}}{\text{taxa de escrita computador}}" width="233" height="47" />

Assim, quanto mais rápido a escrita, menor o valor da taxa calculada.
A tabela abaixo mostra a taxa calculada para cada computador e sua classificação

| Classificação | Máquina | Nome               | Tx Referencia/Tx Máquina |
|---------------|---------|--------------------|--------------------------|
| 1             | 5       | Klaus Rollman      | 0,6317640895             |
| 2             | 18      | João Fidélis       | 0,7908741685             |
| 3             | 25      | Matheus Figueiredo | 0,8329386225             |
| 4             | 10      | Renan Gomes        | 0,8706316282             |
| 5             | 12      | debios             | 1                        |
| 6             | 13      | Gabriel Bueno      | 1,0344362745             |
| 7             | 3       | Mateus Ruivo       | 1,0780029169             |
| 8             | 30      | Matheus Pinheiro   | 1,4492977576             |
| 9             | 22      | Pedro Grijó        | 1,4906316775             |
| 10            | 8       | Luiz Sekijima      | 2,0238080967             |
| 11            | 4       | Pedro Meireles     | 3,2870321694             |
| 12            | 23      | Pedro Vasconcellos | 8,1199376647             |


A tabela mostra a classificação dos computadores do mais rápido em escrita a disco até o mais lento.


#### Benchmark 2 : FFmpeg 
Nesse benchmark foi analisado a quantidade de `page-faults` ocorridos durante o transcode de uma amostra de vídeo blu-ray 1080p no formato mp4 para o formato avi. As outras medidas desse bechmark, como `stalled cycles` e `L1-dcache-load-misses` não foram consideradas pois alguns computadores não foram capazes de realizar essa medição. A fórmula utilizada foi:

##### Análise do Benchmark
Nesse benchmark tentou-se verificar se o número de page-faults e cache misses afeta o tempo de execução de modo significante. A tabela abaixo contém as medidas de page-faults, cache-misses e o tempo de execução.

<<< tabela >>>>

Nessa tabela é possível ver que o número de cache-misses e page-faults não afetaram de modo significante o tempo de execução. Os computadores que tiveram melhores tempos de execução não necessáriamente foram os que tiveram menos page-faults e/ou cache miss.

##### Classificação dos Computadores
Como as medidas de stalled cycles e cache-miss não afetaram o tempo de execução, então os computadores foram classificados somente na medida de 
<img src="http://www.sciweavers.org/tex2img.php?eq=%5Cfrac%7B%5Ctext%7Bpage-faults%20referencia%7D%7D%7B%5Ctext%7Bpage-faults%20computador%7D%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="\frac{\text{page-faults referencia}}{\text{page-faults computador}}" width="203" height="47" /> 
A tabela abaixo mostra a classificação das máquinas que realizaram esse benchmark.
|Classificação| Máquina | Nome              | Page Faults | Taxa         |
|--------|---------|-------------------|-------------|--------------|
|1| 8       | Luiz Sekijima     | 12112       | 2,445343461  |
|2| 14      | Renan Castro      | 14145       | 2,0938847649 |
|3| 24      | Wendrey           | 16225       | 1,8254545455 |
|4| 6       | yk0 - Yugo Kuno   | 16470       | 1,7982999393 |
|5| 13      | Gabriel Bueno     | 16509       | 1,7940517294 |
|6| 26      | Titouan Thibaud   | 20475       | 1,4465445665 |
|7| 16      | Victor Souza      | 21057       | 1,4065631381 |
|8| 10      | Renan Gomes       | 25000       | 1,18472      |
|9| 15      | Gabriel Magalhães | 25168       | 1,1768118245 |
|10| 18      | João Fidélis      | 25172       | 1,1766248212 |
|11| 5       | Klaus Rollmann     | 29618       | 1            |
|12| 12      | debios            | 29942       | 0,9891790796 |

##### Benchmark 3 : Convolução
O terceiro benchmark utilizado consistiu em realizar a operação de convolução com a Transformada de Fourier. Nesse caso as medidas de benchmark utilizadas foram escrita e leitura em disco.

Para escrita, a fórmula utilizada foi:

<img src="http://www.sciweavers.org/tex2img.php?eq=%5Cfrac%7B%5Ctext%7Bescrita%20referencia%7D%7D%7B%5Ctext%7Bescrita%20computador%7D%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="\frac{\text{escrita referencia}}{\text{escrita computador}}" width="164" height="47" />

Para leitura a fórmula foi:

<img src="http://www.sciweavers.org/tex2img.php?eq=%5Cfrac%7B%5Ctext%7Bleitura%20referencia%7D%7D%7B%5Ctext%7Bleitura%20computador%7D%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="\frac{\text{leitura referencia}}{\text{leitura computador}}" width="162" height="47" />

A tabela com a classificação dos computadores para escrita e leitura estão mostradas abaixo.

| Classif. Escrita | Classif. Leitura | Máquina | Nome              | Medido por | escrita média (MB/s) | leitura média (MB/s) | Tx Escrita   | Tx Leitura   |
|-----------------------|-----------------------|---------|-------------------|------------|----------------------|----------------------|--------------|--------------|
| 3                     | 1                     | 15      | Gabriel Magalhães | Grupo C    | 1758,20              | 4031,00              | 0,0078489364 | 0,0228479286 |
| 4                     | 2                     | 7       | Cygnus X-1        | Grupo G    | 1627,30              | 3702,80              | 0,0084803048 | 0,024873069  |
| 1                     | 3                     | 13      | Gabriel Bueno     | Grupo A    | 1840,00              | 3144,46              | 0,0075       | 0,0292896078 |
| 8                     | 4                     | 14      | Renan Castro      | Grupo C    | 641,00               | 2781,00              | 0,0215288612 | 0,0331175836 |
| 6                     | 5                     | 27      | Titouan Thibaud   | Grupo H    | 1103,20              | 2742,60              | 0,0125090645 | 0,0335812732 |
| 5                     | 6                     | 24      | Wendrey           | Grupo H    | 1426,10              | 2413,40              | 0,0096767408 | 0,0381619292 |
| 2                     | 7                     | 5       | Klaus Rollmann     | Grupo A    | 1780,00              | 2360,00              | 0,007752809  | 0,0390254237 |
| 9                     | 8                     | 30      | Gustavo Basso     | Grupo G    | 82,10                | 2065,64              | 0,1680876979 | 0,0445866656 |
| 7                     | 9                     | 12      | debios            | Grupo A    | 1085,00              | 2021,00              | 0,012718894  | 0,0455714993 |
| 11                    | 10                    | 16      | Victor Souza      | Grupo C    | 10,90                | 793,00               | 1,2660550459 | 0,1161412358 |
| 10                    | 11                    | 6       | yk0 - Yugo Kuno   | Grupo 3    | 13,80                | 92,10                | 1            | 1            |

#### Comparação dos Benchmarks
A partir dos resultados obtidos nos benchmarks 1,2 e 3, foi possível notar que os benchmarks de disco variaram muito. Um exemplo é a classificação da máquina 13 - Gabriel Bueno nos benchmarks 1 e 3. No benchmark 3, esse computador teve o melhor desempenho de escrita em disco, já no primeiro, teve uma classificação na média. Quanto ao tempo de execução, esses computadores não tiveram
### Classificação com base no tempo de execução
Nessa etapa foi feita a classificação geral dos computadores com base no tempo de execução de cada benchmark.

Para isso foi calculada a taxa de cada computador para cada benchmark realizado e foi tirada a média geométrica dessas medidas. Em seguida foi feita a classificação com base nesse resultado.

A taxa para cada benchmark foi calculada da seguinte forma:

<img src="http://www.sciweavers.org/tex2img.php?eq=%5Cfrac%7B%5Ctext%7Btempo%20de%20execucao%20referencia%7D%7D%7B%5Ctext%7Btempo%20de%20execucao%20computador%7D%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="\frac{\text{tempo de execucao referencia}}{\text{tempo de execucao computador}}" width="272" height="47" />

Os benchmarks que não especificaram a máquina de referência foram desconsiderados para o cálculo.

A classificação geral é mostrada abaixo considerando o tempo de execução dos benchmarks 1,2,3,4 e 5

| Classif. | Máquina | Nome                  | Media          |
|----------|---------|-----------------------|----------------|
| 1        | 27      | Cygnus X-1            | 1,7342         |
| 2        | 7       | Titouan Thibaud       | 1,7058         |
| 3        | 18      | João Fidélis          | 1,5677         |
| 4        | 15      | Gabriel Magalhães     | 1,3113         |
| 5        | 5       | Klaus Rollman         | 1,2466         |
| 6        | 10      | Renan Gomes           | 1,1309         |
| 7        | 13      | Gabriel Bueno         | 1,1022         |
| 8        | 25      | Matheus Figueiredo    | 0,9914         |
| 9        | 24      | Wendrey               | 0,9628         |
| 10       | 6       | yk0 - Yugo Kuno       | 0,9532         |
| 11       | 20      | Rodrigo Silva         | 0,9197         |
| 12       | 3       | Mateus Ruivo          | 0,8897         |
| 13       | 12      | debios                | 0,8756         |
| 14       | 19      | floyd                 | 0,8052         |
| 15       | 4       | Pedro Meireles        | 0,6884         |
| 16       | 17      | IC301-Titan           | 0,5751         |
| 17       | 11      | Bruno Hori - Mamonas  | 0,5714         |
| 18       | 30      | Gustavo Basso         | 0,5412         |
| 19       | 8       | Luiz Sekijima         | 0,5171         |
| 20       | 30      | Matheus Pinheiro      | 0,5115         |
| 21       | 14      | Renan Castro          | 0,3902         |
| 22       | 16      | Victor Souza          | 0,3160         |
| 23       | 31      | Netbook - Felipe Emos | 0,1271         |
| 24       | 23      | Pedro Vasconcellos    | 0,0447         |
| 25       | 1       | lab-3 baia 5          | 0,0000         |
| 26       | 2       | DeepLOL               | 0,0000         |
| 27       | 9       | IC-legiao             | 0,0000         |
| 28       | 21      | IC-sepultura          | 0,0000         |
| 29       | 28      | Rafael Faria          | 0,0000         |
| 30       | 29      | João Paulo            | 0,0000         |
| 31       | 22      | Pedro Grijó           | Desconsiderado |

### Referências
[^fn1]: David A. Patterson and John L. Hennessy, Computer Organization and Design, 4th Edition, p.48-50.
