# Exercicio 4 : Plataformas e Periféricos

*Nome: Klaus Rollmann*

*RA: 146810*

## Introdução
Nessa atividade foi feito um simples periférico que atua como um simples lock de hardware. Usando esse periférico, também foi simulada uma plataforma dual-core que utiliza dois processadores do tipo MIPS. 

## Periférico

Uma vez compilado e instalado o `mips_tlm`, o código do `ac_tlm_peripheral.cpp` foi modificado para retornar um valor salvo na variável lock. Assim, quando um processador acessa esse periférico, o valor de lock é alterado, e o próximo processador não consegue o lock, sendo necessário que este espere pelo outro processador liberar o lock.

### Implementação
Os passos para implementação do periférico de lock são mostrados abaixo.

#### Variável de lock
Uma variável global foi criada para representar o valor do lock. Em que `lock = 0` significa que o lock está livre, e `lock = 1` significa que o lock está em uso.

	/// Variavel global de lock
	int lock = 0; // inicialmente 0

#### Lock
Quando o periférico é acessado para leitura, o lock é setado como 1, indicado que o lock foi fechado. O valor de `d` é o valor lido pelo processador, que será o valor do lock no instante em que o periférico foi chamado.

    ac_tlm_rsp_status ac_tlm_peripheral::readm( const uint32_t &a , uint32_t &d )
    {
      d = lock;
      lock = 1;
      return SUCCESS;
    }

#### Unlock
Para liberar o lock, o processador deve escrever o valor 0 no periférico, assim o próximo processador irá conseguir obter o lock.

	ac_tlm_rsp_status ac_tlm_peripheral::writem( const uint32_t &a , const uint32_t &d )
    {
      cout << "addr: " <<  std::hex  << a << " data: " << d << endl;
      lock = d;
      return SUCCESS;
    }

### Funcionamento

O MIPS usado contém um router que redireciona cada acesso à memória para um periférico específico. O código abaixo demonstra o trecho do `ac_tlm_router.cpp` que faz isso:

    ac_tlm_rsp ac_tlm_router::transport( const ac_tlm_req &request ) {

            if((request.addr < 100*1024*1024))
            {
                    return MEM_port->transport(request);
            }else{
                    return PERIPHERAL_port->transport(request);
            }

	}

Vemos que se o endereço requisitado for menor que 100 * 1024 * 1024, o router redireciona para a memória, caso contrário, redireciona para o periférico criado.

Inicialmente, foi criado um arquivo chamado `test.c`, que testa o funcionamento do periférico.

    #include<stdio.h>
    #define STARTUP_ADDRESS 0x6400000;

    volatile int *lock = (volatile int *) STARTUP_ADDRESS;

    int main( int ac, char *av[]) {

            printf("Lock está como %d\n", *lock);
            printf("Lock agora está como %d\n", *lock);
            printf("Libera o lock\n");
            (*lock) = 0;
            printf("Lock voltou a ser %d\n", *lock);

            return 0;
    }

O valor 0x6400000 representa o endereço 100 * 1024 * 1024 que acessa o periférico. Nota-se que a variável que acessa o periférico deve ser do tipo `volatile`, para indicar que o valor da variável pode mudar em diferentes acessos. Isso faz com que em todo acesso seu valor seja obtido diretamente da memória.

A saída do programa é mostrada abaixo.

            SystemC 2.3.1-Accellera --- Mar 31 2016 17:15:46
            Copyright (c) 1996-2014 by all Contributors,
            ALL RIGHTS RESERVED
    ArchC: Reading ELF application file: test.mips
    ArchC: -------------------- Starting Simulation --------------------

    Lock está como 0
    Lock agora está como 16777216
    Libera o lock
    addr: 6400000 data: 0
    Lock voltou a ser 0
    ArchC: -------------------- Simulation Finished --------------------

    Info: /OSCI/SystemC: Simulation stopped by user.
    ArchC: Simulation statistics
        Times: 0.00 user, 0.00 system, 0.00 real
        Number of instructions executed: 10144
        Simulation speed: (too fast to be precise)

Nota-se que a primeira vez que o lock foi lido, o valor do lock passou a ser 16777216, e em seguida, o valor 0 foi escrito e o lock voltou a ser 0.
O valor 16777216 é o valor 1, representado em big-endian, usado no simulador. Como o lock será obtido somente quando o valor do lock está como 0, então o valor obtido de 16777216 será usado como o valor do lock em uso, para evitar a conversão.


## Processador Dual Core

Agora, o simulador MIPS foi modificado para usar dois processadores ao mesmo tempo, de modo a simular um processador Dual Core. Para isso, o código `main.cpp` foi alterado para instanciar dois processadores.

### Implementação
Os passos para implementação do segundo processador são mostrados abaixo

#### Criação de um novo processador
O arquivo `main.cpp` foi alterado para ter dois processadores. Para isso, os dados do processador 1 foram duplicados em um segundo processador.

##### Novo processador
O novo processador foi criado duplicando-se o processador 1

      mips mips_proc1("mips");
      mips mips_proc2("mips2"); // segundo processador

##### Argumentos
Os argumentos passados também foram copiados, pois a implementação do simulador retira o primeiro argumento após o processador ser instanciado.

      // Copia ac e av para o segundo processador
      int ac1 = ac;
      char *av1[2];
      av1[0] = strdup(av[0]);
      av1[1] = strdup(av[1]);

##### Associa ao roteador
Em seguida, o processador dois foi associado à porta do roteador:

      mips_proc1.DM_port(router.target_export);
      mips_proc2.DM_port(router.target_export);


##### Inicialização
O novo processador foi inicializado com a cópia dos argumentos
    
      mips_proc1.init(ac, av);
      mips_proc2.init(ac1, av1);
      
##### Tamanho do batch de instruções
Para que cada instrução seja executada uma vez em cada processador, foi colocado o tamanho do batch de instruções como 1, assim as instruções serão executadas alternadamente entre os processadores, simulando um processador paralelo, mas perdendo na performance do simulador [1].

	 mips_proc1.set_instr_batch_size(1);
 	 mips_proc2.set_instr_batch_size(1);

    
##### PrintStat e retorno
O segundo processador também chamou a função PrintStat(). 

	mips_proc1.PrintStat();
    mips_proc2.PrintStat();

E o retorno da função foi ajustado como a soma dos `ac_exit_status` de cada processador.

	return mips_proc1.ac_exit_status + mips_proc2.ac_exit_status;

### Funcionamento
Para testar o funcionamento do processador com dois cores, foi feito um simples programa que imprime 10 vezes o nome de cada processador que executou a instrução. Para facilitar o uso do periférico de hardware lock, foram implementadas duas funções macro que executam o lock e unlock. As funções são mostradas abaixo.

    void AcquireLock()
    {
            while (*lock);
    }

    void ReleaseLock()
    {
            *lock = 0;
    }


Agora, para imprimir o número do processador, foi usado o código mostrado em `test2.c`. Lembrando que foi compilado com a flag `-Os` para otimizar o tamanho do código.
A função `main` está mostrada abaixo

	int main( int ac, char *av[]) {
        int procNumber;
        int i;
        AcquireLock();
        procNumber = procCounter;
        procCounter++;
        ReleaseLock();

        for (i = 0; i < 10; i++) {
                AcquireLock();
                printf("Oi do processador %d\n", procNumber);
                ReleaseLock();
        }
        return 0;
	}

A saída é mostrada abaixo.

	ArchC: Reading ELF application file: test2.mips
    ArchC: -------------------- Starting Simulation --------------------

    ArchC: Reading ELF application file: test2.mips
    ArchC: -------------------- Starting Simulation --------------------

    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    Oi do processador 1
    Oi do processador 0
    ArchC: -------------------- Simulation Finished --------------------
    Oi do processador 1
    ArchC: -------------------- Simulation Finished --------------------

É possível notar que as duas execuções foram simultâneas, pois a saída está dentro do intervalo *Starting Simulation* e *Simulation Finished* dos dois processadores. Vemos também que o simulador com número 0 terminou a simulação primeiro, e o simulador 1 continuou e imprimiu sua ultima mensagem, para só então terminar.

## Simulando aplicação com paralelismo

Para testar o funcionamento do processador dual-core e comparar com o processador single-core, foi feita uma aplicação que processa uma imagem com um filtro de sharpening.

### Aplicação

O código fonte da aplicação usado para o teste é o `sharpenBig.c`. A imagem usada está instanciada no arquivo `sharpenBig.h`, e é formada por uma matrix 256x256 que representa a intensidade da cor cinza da imagem. A imagem usada é mostrada abaixo:

![lena256.jpg](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio4/lena256.jpg)

O programa divide a imagem em duas, e cada processador computa o novo valor do pixel da sua região da imagem e salva em uma variável compartilhada. Após terminar, o processador 0 imprime a imagem em um arquivo de saida, que será usado para converter a matriz para uma imagem visível.

O filtro utilizado é mostrado abaixo, e tem a função de realçar alguns traços da imagem (sharpen)[2]
	
     0 -3  0
    -3  21 -3
     0 -3  0

### Execução

A conversão entre imagem-matriz e matriz-imagem foi feita no Matlab, usando os scripts `convertImage.m` e `showImage.m`.

Inicialmente o programa foi compilado com:

	$ mips-newlib-elf-gcc -specs=archc sharpenBig.h sharpenBig.c -o sharpenBig.mips -Os
     
Em seguida, o programa foi executado redirecionando a saída para o arquivo `output.out`

    $ ./mips.x --load=sharpenBig.mips >output.out
    
Por fim o script Matlab `showImage.m` foi usado para mostrar a imagem final

A imagem resultante é mostrada abaixo.

![lena256sharpen.jpg](https://raw.githubusercontent.com/klausrollmann/mc723/master/exercicio4/lena256sharpen.jpg)

### Resultados
Os resultados da execução para o programa executado no simulador com dois processadores e com um único processador são mostrados abaixo

#### Dual-Core

	Info: /OSCI/SystemC: Simulation stopped by user.
    ArchC: Simulation statistics
        Times: 1.86 user, 0.00 system, 1.88 real
        Number of instructions executed: 108016784
        Simulation speed: 58073.54 K instr/s

    ArchC: Simulation statistics
        Times: 1.86 user, 0.00 system, 1.88 real
        Number of instructions executed: 4145873
        Simulation speed: 2228.96 K instr/s

#### Single-Core

	
    
Nota-se que a execução do programa dual-core, as instruções foram executadas em paralelo, sendo assim, o tempo para o programa terminar a execução é equivalente ao tempo para executar 108016784 instruções. No programa single-core, vemos que há um número maior de instruções executado, e o tempo de execução é o tempo para executar <<>> instruções.

É importante notar que a melhor do processador dual-core não é metade, pois há tarefas que não podem ser feitas em paralelo. A impressão da matriz, por exemplo, foi feita somente pelo processador 0, o que fez com que a divisão de tarefas entre o processador 0 e 1 fosse desigual, e o ganho de desempenho fosse menor.
Além disso, tarefas que necessitam de concorrência causam um overhead devido às instruções de `AcquireLock()` e `ReleaseLock()`.
Portanto, a escolha de um processador com vários cores deve sempre levar em conta se a aplicação pode ser paralelizável e também se as tarefas executadas em paralelo possuem dependência.
    

## Referências
[1] Sandro Rigo, Rodolfo Azevedo, Luiz Santos. Electronic System Level Design: An Open-Source Approach Springer, 2011.\
[2] https://en.wikipedia.org/wiki/Kernel_%28image_processing%29
