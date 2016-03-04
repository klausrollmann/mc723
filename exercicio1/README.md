Exercício 1: Compilação e Otimização

1. As otimizações que o compilador devem usar são especificadas através de flags passadas na execução do compilador.
2.
3. Um Makefile se diferencia de um script por ter opções adicionais para evitar rebuilds. No Makefile é possível especificar quais partes dependem de quais outras partes, evitando o rebuild de todo o programa. 
4. Depurar um programa é o processo utilizado para encontrar e corrigir erros que estão ocorrendo no programa e que estão levando o programa a executar resultados não esperados.
5. Para executar o gdb é necessário compilar o programa com uma flag específica para o compilador gerar informações de debugging. Após compilar basta abrir o gdb e especificar qual programa deve ser executado.
6. Para utilizar um ambiente gráfico como o DDD, basta executar o ddd no lugar do gdb após ter compilado o programa para debugging.
7. Para descobrir a parte que é mais executada em um programa, basta utilizar alguma ferramenta que verifica quais partes são executadas mais vezes no programa.
8. Para utilizar o gprof deve-se primeiramente compilar o programa com uma flag especial para habilitar a função de profiling do programa. Em seguida, basta executar o gprof para analisar os dados gerados pelo compilador.
9. 

Execução do programa para geração de números primos

Inicialmente foi explorado o tempo de compilação para diferentes flags de otimização.
Para cada flag foram medidos o realtime da execução do gcc para 5 execuções
Sem flags de otimização:
Comando 'gcc primo.c -o run'
Tempos
0.060s
0.042s
0.040s
0.072s
0.081s


Flag O0:
Comando 'gcc primo.c -O0 -o run'
Tempos
0.060s
0.042s
0.040s
0.072s
0.081s

