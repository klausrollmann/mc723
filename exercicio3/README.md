# Exercicio 3 : Contagem de Ciclos

*Nome: Klaus Rollmann*

*RA: 146810*

## Introdução
Nessa atividade foi instalado o simulador do processador MIPS, e foram feitas alguams contagens de cycles per instruction (CPI) de três programas. Os programas utilizados foram `dijkstra`, `rijndael` e `susan`.

## Familiarização com o Simulador

Uma vez instalado o simulador, foram realizados alguns testes para familiarização com o processo de compilação e simulação.

#### Compilação
Inicialmente, foi criado um arquivo chamado `hello.c`, e em seguida ele foi compilado e executado.

	#include<stdio.h>

	int main () {
		printf("Hello World!\n");
		return 0;
	}

Para compilar, foi usado o compilador `mips-newlib-elf-gcc` para converter o código `.c` em instruções `mips`.

    mips-newlib-elf-gcc -specs=archc hello.c -o hello.mips

#### Simulação
O executável `.mips` foi criado, agora basta compilar e executar o simulador.

    acsim mips.ac -abi
    make -f Makefile.archc
    
Com isso o simulador foi compilado, e agora pode-se executar o `hello.mips` com o comando

    mips.x --load=hello.mips
    
## Contagem de instruções

O arquivo `mips_isa.cpp` foi alterado para contar o número de execuções da instrução `add`. Para isso, foi criado uma variável global `int counter_add` e em seguida as funções `ac_behavior(add)`, `ac_behavior(begin)` e `ac_behavior(end)` foram modificadas para contar e imprimir as instruções `add`.

**ac_behaviour(begin)**

    void ac_behavior(begin)
    {
        // Adicionado contador de instruções add
        counter_add = 0;
        dbg_printf("@@@ begin behavior @@@\n");
        ...
        
**ac_behaviour(add)**

    void ac_behavior( add )
    {
        // Incrementa número de instruções add
        counter_add++;
        ...
      
**ac_behaviour(end)**

    void ac_behavior(end)
    {
        // Imprime número de instruções add ao finalizar execução
        printf("Numero de instruções add: %d\n", counter_add);
    ...

O Simulador foi compilado novamente, e o `hello.mips` foi executado.

A saída mostrou que não houve instruções `add` no programa

    Numero de instruções add: 0
    
Um segundo programa `teste_add.c` foi feito para tentar forçar uma instrução `add`

    include<stdio.h>
    
    int main () {
    
            int i = 0;
            int v[100];
            for (i = 0; i < 100; i++) {
                v[i] = i * i;
            }
            for (i = 0; i < 50; i++) {
                v[i] = v[i] + v[100-i];
            }
            for (i = 0; i < 100; i++) {
                printf("%d ", v[i]);
            }
            printf("\n");
    
            return 0;
    
    }

Esse programa realiza diversas operações aritméticas de soma, e também possíveis somas de endreço.
   Os resultados mostram que, novamente, não foram executadas instruções `add`
   
    ArchC: -------------------- Starting Simulation --------------------
    0 9802 9608 9418 9232 9050 8872 8698 8528 8362 8200 8042 7888 7738 7592 7450 7312 7178 7048 6922 6800 6682 6568 6458 6352 6250 6152 6058 5968 5882 5800 5722 5648 5578 5512 5450 5392 5338 5288 5242 5200 5162 5128 5098 5072 5050 5032 5018 5008 5002 2500 2601 2704 2809 2916 3025 3136 3249 3364 3481 3600 3721 3844 3969 4096 4225 4356 4489 4624 4761 4900 5041 5184 5329 5476 5625 5776 5929 6084 6241 6400 6561 6724 6889 7056 7225 7396 7569 7744 7921 8100 8281 8464 8649 8836 9025 9216 9409 9604 9801 
    ArchC: -------------------- Simulation Finished --------------------
    Numero de instruções add: 0
    
Para ver que instruções o simulador executou, é possível usar o 
    
    mips-newlib-elf-objdump -d teste_add.mips
    
Usando o comando em conjunto com `grep add` é possível ver que ele executou apenas operações de `addu` e `addui`, mesmo nos casos em que o número era negativo.

    ...
    14910:	27bd0030 	addiu	sp,sp,48
    1495c:	24425430 	addiu	v0,v0,21552
    14960:	00822021 	addu	a0,a0,v0
    14988:	24425430 	addiu	v0,v0,21552
    1498c:	00822021 	addu	a0,a0,v0
    149ac:	24425430 	addiu	v0,v0,21552
    149b0:	00822021 	addu	a0,a0,v0
    149cc:	24425430 	addiu	v0,v0,21552
    149d0:	00822021 	addu	a0,a0,v0
    149e8:	27bdffd0 	addiu	sp,sp,-48
    14a5c:	2623007f 	addiu	v1,s1,127
    ...
    
Isso ocorre, pois a linguagem `.c` não causa exceção quando há um overflow. Caso fosse usado `add` e ocorresse overflow, essa instrução causaria uma exceção no processador, o que não é desejado. Sendo assim, ela opta pelo uso do `addu`, que não causa exceção em caso de overflow.

## Contagem do CPI

O simulador foi alterado para imprimir os CPI do programa executado. Para isso, cada tipo de instrução somou um certo número de ciclos em uma variável, e ao final a variável foi mostrada. 

Instruções de acesso à memória usam em média 10 ciclos, instruções de salto (branch/jump) 3 ciclos e as outras instruções levam em média 1 ciclo.

O arquivo `mips_isa.cpp` foi alterado da seguinte forma:

**Criação de variáveis globais**
    
    // Contador de ciclos
    long long cycles;
    // Contador de instruções
    long long intr;

**ac_behaviour(begin)**

    void ac_behavior(begin)
    {
        // Inicializa contadores
        cycles = 0;
        intr = 0;
        ...
        
**Instruções de salto**
Nas instruções de salto (j, beq, bz, bne, jal,...), foram adicionadas as linhas a seguir logo após o cabeçalho da função.

    // Incrementa 3 ciclos
    cycles = cycles + 3;
    // Incrementa número de instruções
    intr++;

**Instruções de acesso à memória**
Nas instruções de acesso à memória (lb, lbu, lh, sb, sh, swl, ...) foram adicionadas as linhas mostradas abaixo logo no início da função.

    // Incrementa 10 ciclos
    cycles = cycles + 10;
    // Incrementa número de instruções
    intr++;
        
**ac_behaviour(end)**
    
    void ac_behavior(end)
    {
        printf("Cycles: %d\n", cycles);
        printf("Instructions: %d\n", intr);
        printf("CPI: %.2f\n", (float) cycles/intr);
        ...

Em seguida, os benchmarks para `dijkstra small`, `rijndael coder small` e `susan corners large` foi executado a partir do script `script.sh`. A saída do simulador é mostrada abaixo:

    $ ./script.sh 
    DIJKSTRA SMALL

            SystemC 2.3.1-Accellera --- Apr  8 2016 10:10:37
            Copyright (c) 1996-2014 by all Contributors,
            ALL RIGHTS RESERVED
    ArchC: Reading ELF application file: dijkstra_small
    ArchC: -------------------- Starting Simulation --------------------
    
    ArchC: -------------------- Simulation Finished --------------------
    Cycles: 196784071
    Instructions: 35076723
    CPI: 5.61
    
    Info: /OSCI/SystemC: Simulation stopped by user.
    ArchC: Simulation statistics
        Times: 0.72 user, 0.00 system, 0.73 real
        Number of instructions executed: 49165900
        Simulation speed: 68285.97 K instr/s
    
    RIJNDAEL CODER SMALL
    
            SystemC 2.3.1-Accellera --- Apr  8 2016 10:10:37
            Copyright (c) 1996-2014 by all Contributors,
            ALL RIGHTS RESERVED
    ArchC: Reading ELF application file: rijndael
    ArchC: -------------------- Starting Simulation --------------------
    
    ArchC: -------------------- Simulation Finished --------------------
    Cycles: 158284329
    Instructions: 29879315
    CPI: 5.30
    
    Info: /OSCI/SystemC: Simulation stopped by user.
    ArchC: Simulation statistics
        Times: 0.58 user, 0.00 system, 0.61 real
        Number of instructions executed: 43561699
        Simulation speed: 75106.38 K instr/s
    
    SUSAN CORNERS LARGE
    
            SystemC 2.3.1-Accellera --- Apr  8 2016 10:10:37
            Copyright (c) 1996-2014 by all Contributors,
            ALL RIGHTS RESERVED
    ArchC: Reading ELF application file: susan
    ArchC: -------------------- Starting Simulation --------------------
    
    ArchC: -------------------- Simulation Finished --------------------
    Cycles: 179121222
    Instructions: 28118247
    CPI: 6.37
    
    Info: /OSCI/SystemC: Simulation stopped by user.
    ArchC: Simulation statistics
        Times: 0.65 user, 0.00 system, 0.67 real
        Number of instructions executed: 43413947
        Simulation speed: 66790.69 K instr/s

Com isso, foi possível medir o número de ciclos, número de instruções e CPI médio do programa. Essas informações podem ser úteis para comparar dois processadores para um mesmo conjunto de programas, e verificar qual o melhor processador, em termos de operações por segundo. A medida do CPI é tão importante quanto a medida padrão de Clock rate, porém, nenhuma delas pode ser usada individualmente para comparar processadores, mas podem ser usadas em conjunto para realizar uma comparação sólida entre as velocidades de processadores.

Uma medição que envolve o Clock Rate somente, não é uma boa fonte de comparação, pois um processador com Clock Rate alto, mas CPI também alto, exeucta menos operações que um com Clock Rate mais baixo e CPI baixo. Da mesma forma, um CPI baixo não implica um processador mais rápido, pois ele pode executar todas as instruções em um ciclo, mas realizar poucos ciclos por segundo. Portanto, o uso das medidas de CPI e Clock Rate em conjunto permitem encontrar o valor do número de instruções médio por segundo, o que traz uma boa avaliação de desempenho para o processador.



