# Exercicio 2 : Configurações de Cache

*Nome: Klaus Rollmann*

*RA: 146810*

## Introdução
Nesse trabalho foram exploradas as configurações de cache para os níveis L1 e L2 e tentou-se encontrar a melhor configuração para reduzir a taxa de miss-rates de um determinado programa.

##  Metodologia
Para encontrar a menor taxa de miss-rates para um determinado programa, foram variados os valores do tamanho do cache L1, em seguida variou-se o tamanho do bloco do cache L1 e também variou-se a associatividade. O mesmo foi feito com o cache L2. A melhor configuração de cada teste foi usada para o próximo teste, com isso foi possível encontrar uma boa aproximação para a melhor configuração de cache possível, sem ter que realizar um número muito grande de testes.
É importante notar que algumas configurações foram escolhidas mesmo tendo uma taxa de miss rate maior. Isso ocorreu quando um aumento considerável na medida não trazia uma melhora significativa na taxa de miss.

## Ferramentas Utilizadas
As ferramentas utilizadas nesse experimento são mostradas abaixo.
##### Simulador de Cache
Para realizar os testes, foi usado um simulador de cache chamado `Dinero`. Esse software simula o cache para registros de memória de um programa e permite o usuário escolher configurações de cache das mais variadas. As opçoes utilizadas foram: o tamanho do cache, o tamanho do bloco e a associatividade.

##### Programa e Traces escolhidos
Os traces utilizados foram F2B e M2B para o programa 164 (gzip). O trace F2B executa 2 bilhões de instruções, e o M2B executa
2 bilhões de instruções depois de pular 50 bilhões, sendo assim os traces não executarão as mesmas posições de memória.

## Trace 164.F2B
### Cache L1
Inicialmente foram variadas as configurações do cache L1. As configurações que variaram foram tamanho do cache, tamanho do bloco e associatividade. Os caches L1 de dados e de instruções foram variados simultaneamente em um primeiro momento.
Os dados do experimento podem ser reproduzidos usando o script `L1-teste.sh`.

##### Tamanho do Cache
Para obter o melhor tamanho de cache foi variado o tamanho entre valores comuns de cache L1. Nesse caso o tamanho do bloco ficou fixo em 32KB, e somente o tamanho variou. O gráfico abaixo mostra os resultados.

![l1-f2b-size](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l1-f2b-size.png)

Nesse caso, é possível ver que o aumento do tamanho do cache L1 diminui a taxa de miss. Entrentanto essa melhora na taxa é reduzida a cada aumento. Por esse motivo, a partir de 16KB, dobrar o tamanho do cache não traz mudanças significativas. Levando isso em consideração, foi escolhido o cache L1 com tamanho 16KB como sendo uma boa configuração de tamanho para o cache L1, tanto de dados como de instruções.

##### Tamanho do Bloco
Usando o tamanho de cache de 16KB escolhido anteriormente, foi variado o tamanho do bloco, de 1KB até 4096KB. 

![l1-f2b-block](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l1-f2b-block.png)

No gráfico é possível ver que há um ponto em que o aumento do tamanho do bloco deixa de diminuir a taxa de miss e passa a aumentar essa taxa. No cache de dados, o tamanho de bloco ideal é 64B e 128B. No cache de instruções, o tamanho do bloco acima de 256B não traz melhoras na taxa de miss.  Sendo assim, optou-se pelo bloco de 64B no cache L1 de dados e o de 256B no cache L1 de instruções.

##### Associatividade
Para a associatividade, foi variado o valor de associatividade de 1 até 16, mantendo-se as configurações obtidas anteriormente para cache L1 de dados e instruções.

![l1-f2b-assoc](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l1-f2b-assoc.png)

Observando o gráfico, é possível ver que a partir da associatividade 2 não se nota diferenças nas taxas de miss. Sendo assim, tanto para cache de dados e de instruções, foi escolhido a configuração de cache com associatividade 2.

### Cache L2
Uma vez encontrada uma boa configuração de cache L1, tentou-se também reduzir a taxa de misses no cache L2. Para isso, foram variadas as configurações de cache L2, mantendo a configuração do cache L1 obtida anteriormente. O script com os comandos é o `L2-teste.sh`, e os resultados medidos estão na planilha.

##### Tamanho do Cache
O tamanho do cache L2 ideal foi facilmente verificado pelo gráfico mostrado abaixo.

![l2-f2b-size](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l2-f2b-size.png)

É possível ver que acima de 512KB de tamanho, o número de cache misses não diminui, sendo assim, a escolha para o tamanho do cache L2 é 512KB.

##### Tamanho do Bloco
Dentre os valores comuns de tamanho do bloco, optou-se pelo que tem a menor taxa de misses, mostrada abaixo.

![l2-f2b-block](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l2-f2b-block.png)

No gráfico, é possível ver que a taxa de misses é menor para o bloco de 4096B, sendo assim, foi escolhido o tamanho do bloco do cache L2 como 4096B.


##### Associatividade
A partir das configurações obtidas anteriormente, variou-se a associatividade..

![l2-f2b-assoc](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l2-f2b-assoc.png)

Pelo gráfico, é possível ver que a taxa de miss não diminui para associatividades maiores que 4. Deste modo, a associatividade escolhida foi 4.

## Trace 164.M2B
O mesmo procedimento foi feito para o trace M2B, para verificar se a melhor configuração obtida na parte F2B é a mesma, ou se há muita discrepância nos resultados. Os resultados são mostrados nas seções abaixo.
### Cache L1
O script `L1-teste2.sh` foi executado e os resultados encontram-se na planilha `resultados.ods`
##### Tamanho do Cache

![l1-m2b-assoc](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l1-m2b-assoc.png)

Variando o tamanho do cache L1, vemos um resultado muito semelhante ao do gráfico para F2B. Sendo assim, o tamanho do cache de 16KB foi mantido.

##### Tamanho do Bloco

![l1-m2b-block](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l1-m2b-block.png)

Novamente, o tamanho do bloco do cache L1 para as M2B instruções foi o mesmo encontrado para as F2B instruções. Por isso, foram mantidos os valores de 64B para o cache de dados e 128B para o cache de instruções. 

##### Associatividade

![l1-m2b-block](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l1-m2b-assoc.png)

Mais uma vez, a associatividade foi mantida, e o gráfico dos resultados é muito semelhante ao para as F2B instruções.

### Cache L2
Uma análise semelhante a feita para o conjunto F2B de instruções foi feita para as M2B instruções do programa 164. O script para executar os testes é o `L2-teste2.sh`. Os resultados são mostrados abaixo.

##### Tamanho do Cache

![l2-m2b-size](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l2-m2b-size.png)

No gráfico abaixo, é possível ver que o tamanho de 512KB escolhidos anteriormente traz bons resultados na taxa de miss, e que tamanhos maiores não trazem benefício relevante. 
##### Tamanho do Bloco

![l2-m2b-block](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l2-m2b-block.png)

Quanto ao tamanho do bloco, também é possível notar que a escolha usada para as F2B instruções também é a melhor escolha dentre os valores medidos.

##### Associatividade

![l2-m2b-assoc](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/l2-m2b-assoc.png)

Em relação à associatividade, nota-se que a associatividade escolhida de 4 não traz mais o melhor resultado. Sendo assim, a melhor configuração de associatividade considerando tanto as F2B instruções e M2B é 8.

## Testes para a melhor configuração
A melhor configuração obtida foi testada no programa 164 (gzip) para as duas partes e em seguida essa configuração foi testada em dois outros programas:168 (wupwise) e 172 (swim). Os resultados foram comparados para ver se uma configuração de cache boa para um programa também é boa em outros programas.

##### Configuração obtida
A melhor configuração obtida testando o programa 164 (gzip) foi:
*   Cache L1 Dados:
    *   Tamanho: 16KB
    *   Bloco: 64B
    *   Associatividade: 2
*   Cache L1 Instruções:
    *   Tamanho: 16KB
    *   Bloco: 256B
    *   Associatividade: 2
*   Cache L2 Unificado:
    *   Tamanho: 512KB
    *   Bloco: 4096B
    *   Associatividade: 8

##### Teste com outros programas
Usando essas configurações de cache, foi verificada a taxa de miss-rate para F2B e M2B para outros dois programas e foi comparada com o resultado obtido para as medições do programa gzip. O script para os testes usado foi o `comparation.sh`.

![testes](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio2/graphs/testes.png)

No gráfico, é possível ver que a configuração de L1-Instruções trouxe 0% de miss para os três casos. Isso pode ter ocorrido pelo tamanho do bloco da cache, que por ser grande, faz com que ao ler uma instrução, todas as seguintes sejam colocadas no mesmo bloco no cache.

Para a cache L1-Dados, é possível ver que a configuração utilizada foi melhor nos outros dois programas que no programa usado. Isso pode ser explicado pelo fato de o programa escolhido ser usado para compressão de dados, o que o torna muito dependente de leitura e escrita, o que dificulta muito a tarefa do cache de dados.

Já no cache L2, vemos que a escolha da configuração do cache L2 foi mais particular ao programa gzip e a taxa de miss para esse cache nos outros programas foi elevada. Isso pode ter ocorrido pelo uso de blocos grandes nessa cache.

## Conclusões
As configurações de cache devem ser pensadas de acordo com o tipo de cache, e também o tipo de programa utilizado. O cache de instruções, em geral, deve ser configurado com blocos maiores que o cache de dados. Já para o cache L1 de dados e L2 de instruções, depende muito do tipo de aplicação. Uma aplicação de compressão, como o programa gzip, depende muito de dados, sendo assim, o uso de caches maiores para L1 de dados pode ser uma boa escolha.

### Referências
[1] David A. Patterson and John L. Hennessy, Computer Organization and Design, 4th Edition, p.458-491.
   
