# Exercício 1: Compilação e Otimização
Nome: Klaus Rollmann  
RA: 146810

#### Perguntas Iniciais
Antes de iniciar foram respondidas algumas perguntas importantes para o desenvolvimento do exercício.

**1. Como especificar as otimizações que um compilador deve utilizar num programa?**    
As otimizações são especificadas através de flags passadas ao compilador.

**2. Quais otimizações são importantes para o processador que você está utilizando?**    
Para o processador usado, é possível otimizar as instruções, substituindo as instruções comuns por instruções que são executadas rapidamente na arquitetura específica do processador 

**3. Qual a diferença entre um Makefile e um script?**    
Um Makefile se diferencia de um script por ter opções adicionais para evitar recompilar codigo já compilado. 

**4. O que é "depurar um programa"?**   
Depurar um programa é o processo utilizado para encontrar e corrigir erros que estão ocorrendo no programa e que estão levando a resultados inesperados.

**5. Como executar o GDB?**   
É necessário compilar o programa com uma flag específica para o compilador gerar informações de debugging. Então basta abrir o gdb executar o programa. 

**6. Como utilizar um ambiente gráfico com o GDB?**   
Para utilizar um ambiente gráfico como o DDD, basta executar o ddd no lugar do gdb.

**7. Como descobrir a parte que é mais executada de um programa?**   
Uma forma de fazer isso é utilizando a ferramenta gprof

**8. Como utilizar o gprof?**   
Para utilizar o gprof deve-se primeiramente compilar o programa com uma flag especial para habilitar a função de profiling do programa. Em seguida, basta executar o gprof para analisar os dados gerados pelo compilador.

**9. Como fazer com que um programa tire proveito de multiprocessamento de forma escalável?**   
Uma forma é utilizando a API OpenMP.

## Compilador 

Inicialmente foi explorado o tempo de execução do programa `primos.c` para diferentes flags de otimização utilizadas com o GCC.
Para cada flag foram medidos o realtime minimo, máximo e médio da execução do programa para 10 execuções utilizando o script `time_measure.sh`.

##### Sem flags de otimização:
Comandos:

    $ gcc primo.c -o run
    $ ./time_measure.sh run 10

Saida:

    Min: 0.3010	Max: 0.3090	Average: 0.3041

### Otimizações Gerais do GCC
##### Com flag de otimização O0:
Comandos:

    $ gcc primo.c -O0 -o run
    $ ./time_measure.sh run 10

Saida:

    Min: 0.3010	Max: 0.3120	Average: 0.3036

##### Com flag de otimização O1:
Comandos:

    $ gcc primo.c -O1 -o run
    $ ./time_measure.sh run 10

Saida:

    Min: 0.3010	Max: 0.3100	Average: 0.3052
    
##### Com flag de otimização O2:
Comandos:

    $ gcc primo.c -O2 -o run
    $ ./time_measure.sh run 10

Saida:

    Min: 0.3350	Max: 0.3440	Average: 0.3376
    
##### Com flag de otimização O3:
Comandos:

    $ gcc primo.c -O3 -o run
    $ ./time_measure.sh run 10

Saida:

    Min: 0.3330	Max: 0.3420	Average: 0.3361

#### Análise:
Como houve uma variação nos valores de `Min` e `Max`, foi considerada somente a precisão de 0.01s.

Analisando os dados é possível notar que nenhuma das otimizações melhorou o tempo de execução do programa. Além disso, as flags `-O2` e `-O3` aumentaram o tempo de execução do programa, o que não foi esperado.
A partir disso, vemos que a otimização pelo compilador depende muito do código compilado, e que nem sempre leva a um tempo menor de execução do programa.

### Otimizações para processador

##### Com flag de otimização mtune:
O uso do `-mtune` gera o codigo com instrucoes que são executadas mais rapidamente na CPU indicada, para isso foi especificado como parametro da flag o codigo para a cpu utilizada.

Processador:

    Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
    
Para esse processador, foram testadas algumas flags obtidas de acordo com a referência:
##### native

Comandos:

    $ gcc primo.c -mtune=native -o run
    $ ./time_measure.sh run 10

Saida:

    Min: 0.3020	Max: 0.3160	Average: 0.3074

##### core-avx-i
Comandos:

    $ gcc primo.c -mtune=core-avx-i -o run
    $ ./time_measure.sh run 10

Saida:

    Min: 0.3010	Max: 0.3130	Average: 0.3053


Mesmo com a otimização das instruções, não houve redução no tempo de execução em relação ao código compilado sem otimizações.
 O resultado foi esperado, uma vez que o código utilizado é simples e não possui instruções relevantes para esse tipo de otimização. Novamente é possível perceber que a otimização pelo compilador depende muito do código utilizado, e nem sempre reduz o tempo de execução.


### Separação em arquivos
Nessa etapa, o arquivo `primos.c` foi separado em dois arquivos `main.c` e `calc_primo.c`.
Comandos:

    $ gcc main.c calc_primo.c -o run
    $ ./time_measure.sh run 10

Saida:

	Min: 0.3190	Max: 0.3250	Average: 0.3210

Esse resultado não foi esperado, pois era de se esperar que a execução do programa levasse o mesmo tempo, pois o programa é o mesmo.

Efetuando mais alguns testes, foi possível notar que invertendo a ordem de passagem de parametros no gcc, a execução levou o tempo esperado. O mesmo ocorreu usando a flag de otimização `-O1`


Comandos:

    $ gcc calc_primo.c main.c -o run
    $ ./time_measure.sh run 10

Saida:

	Min: 0.3000	Max: 0.3030	Average: 0.3007

Nesse caso, a execução levou o mesmo tempo que a execução quando foi usado um único arquivo.

Os mesmos resultados foram observados utilizando tanto o Makefile como o script, o que era esperado, pois o executavel gerado é o mesmo.

#### Números primos de 1 até n

O código `primos.c` foi modificado para encontrar a quantidade de primos no intervalo 2 até n e então foram comparados os tempos de execução para um único arquivo e para os dois arquivos.

##### Um único arquivo 
Comandos:

	 $ gcc primo_to_n.c -o run
	 $ time ./run 100000

Saida:

	Primos de 2 até 100000: 9592

Tempo:

	real	0m1.484s
	user	0m1.480s
	sys	0m0.000s

##### Dois arquivos 
Comandos:

    $ gcc calc_to_n.c main_to_n.c -o run
    $ time ./run 100000

Saida:

	 Primos de 2 até 100000: 9592

Tempo:

	real	0m1.481s
	user	0m1.480s
	sys	0m0.000s

Novamente o uso de múltiplos arquivos não afetou o tempo de execução do programa de forma significativa. Esse resultado foi esperado, pois o programa executado é o mesmo após a compilação.

### Algoritmo

Nessa etapa o código `primos_to_n.c` foi alterado para verificar somente os números primos ímpares. 

Comandos:

    $ gcc primo_to_n_odd.c -o run
    $ time ./run 100000

Saida:

	 Primos de 2 até 100000: 9592

Tempo:

	real	0m0.711s
	user	0m0.708s
	sys	0m0.000s

O tempo medido para esse algoritmo foi muito próximo da metade, o que foi esperado, uma vez que o conjunto de números testados é reduzido pela metade.

#### Ferramenta gprof
A ferramenta _gprof_ foi usada para analisar quais as partes do código que estão sendo executadas mais vezes, para então tentar melhorar o algoritmo nessas regiões. O código avaliado foi o `primo_to_n_odd.c`

Comandos:

	$ gcc -pg primo_to_n_odd.c -o run
	$ ./run 100000
	Primos de 2 até 100000: 9592
	$  gprof run gmon.out > analysis.txt
	$ vim analysis.txt 

O resultado do gprof foi simplificado e está mostrado abaixo.

  	index % time    self  children    called     name
  	                0.64    0.00   99998/99998       main [2]
  	[1]    100.0    0.64    0.00   99998         primo [1]
  	-----------------------------------------------
  	                                                 <spontaneous>
  	[2]    100.0    0.00    0.64                 main [2]
  	                0.64    0.00   99998/99998       primo [1]
  	-----------------------------------------------

É possível ver que a função _main_ chama a função _primo_ e todo o tempo é gasto na função _primo_. Sendo assim, a região do código que deverá ser alterada, para que o tempo de execução seja reduzido, é a função _primo_.
	
### Paralelismo
Como visto anteriormente, a região do código mais usada é a função _primo_. Uma forma de tornar o programa mais rápido é paralelizar a execução dessa função.
O programa usado anteriormente `primo_to_n_odd.c` foi alterado e a função primo foi modificada para rodar em multiplas threads. Para isso foi utilizado o OpenMP, que permite criar aplicações paralelas de forma portátil e escalável.

#### Funcionamento
A função _main_ chama a função _primo_ para todos os números no intervalo desejado. Como cada chamada da função _primo_ é independente, podemos separar o intervalo em subintervalos menores e calcular o número de primos em cada subintervalo em threads diferentes. 
A região alterada no código é mostrada abaixo:
	
```c
...
// Especifica que 'n' deve ser compartilhado entre todas as threads e que cada thread deve ter seu valor de 'i'
# pragma omp parallel \ 
  shared (n) \
  private (i) 

// Especifica que ao final do loop a variável 'count' deve ser reduzida somando-se os valores de 'count' de cada thread.
# pragma omp for reduction (+ : count)
	for (i = 2; i < n; i++) {
		if (primo(i))
			count++;
	}
```

Comandos:

	$ gcc -fopenmp primo_parallel.c -o run
	$ time ./run 100000

Saida:

	Primos de 2 até 100000: 9592

Tempo:

	real	0m0.214s
	user	0m0.976s
	sys	0m0.000s

Com a paralelização, foi possível notar que o uso de multiplos cores para processamento reduziu bastante o tempo de execução. O tempo de execução, que antes era 0.711s, com o uso de multithreads passou a 0.214s, o que é uma redução de mais de 3x.

### Referências
Flags para cada processador:                                https://gcc.gnu.org/onlinedocs/gcc-4.8.3/gcc/i386-and-x86-64-Options.html  
Tutorial da ferramenta gprof:											http://www.thegeekstuff.com/2012/08/gprof-tutorial/     
Cláusulas OpenMP:															https://msdn.microsoft.com/pt-br/library/2kwb957d.aspx  
Cláusula de reduction para 'for':									https://msdn.microsoft.com/pt-br/library/88b1k8y5.aspx  
