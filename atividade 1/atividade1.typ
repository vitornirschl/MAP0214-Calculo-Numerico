/* Preâmbulo */
#import "@preview/physica:0.9.5":*
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#set par(
  first-line-indent: 1em,
  spacing: 0.65em,
  justify: true,
)
#set text(
  lang: "pt"
)


/* Cabeçalho */
#align(center)[
    = Atividade 1 (MAP0214) - 20 de agosto de 2025

    Vitor Nirschl | vitor.nirschl\@usp.br | Nº USP 13685771 
]

#v(10pt)

/* Corpo */

O modelo a ser utilizado nessa atividade é a Lei de resfriamento de Newton, que trata da perda de temperatura $T(t)$ de um corpo, com capacidade térmica constante, para um ambiente com temperatura constante $T_"amb"$. Ele é dado pela equação diferencial ordinária de primeira ordem
$
  dv(T, t) = r(T(t) - T_"amb")
$
em que $r$ é o coeficiente de perda térmica, dado em unidades inversas de tempo.

Estamos interessados em fazer uma aproximação numérica para esse problema. Se reescrevemos
$
  dv(T, t) = f(t, T(t))
$
então temos 
$
  f(t, T(t)) = r(T(t) - T_"amb")
$

Sendo $t_0$ um instante inicial em que conheçemos $T(t_0) eq.triple T_0$, consideramos o intervalo de tempo de interesse $[t_0, t_f]$ e o particionamos em $n$ intervalos $(t_k, t_(k+1))$, em que 
$
  t_(k+1) = t_k + Delta t #text[com] k = 0, 1, ... n-1, #text[sendo] Delta t = (t_f - t_0)/n
$
Sendo $T_k$ a aproximação numérica de $T(t_k)$, teremos
$
  T_(k+1) = T_k + Delta t phi.alt_("RK4")(t_k, T_k, Delta t)
$
em que $phi.alt_"RK4"$ é a função de discretização dada pelo método de Runge-Kutta clássico
$
  phi.alt_"RK4" (t_k, T_k, Delta t) = 1/6 (k_1 + 2 k_2 + 2 k_3 + k_4)
$
em que
$
  k_1(t_k, T_k, Delta t) = f(t_k, T_k)
  \
  k_2(t_k, T_k, Delta t) = f(t_k + (Delta t)/2, T_k + (Delta t)/2 k_1)
  \
  k_3(t_k, T_k, Delta t) = f(t_k + (Delta t)/2, T_k + (Delta t)/2 k_2)
  \
  k_4(t_k, T_k, Delta t) = f(t_k + Delta t, T_k + Delta t k_3)
$

Nossa EDO tem solução exata, que poderemos utilizar para avaliar a qualidade da aproximação feita. Ela é dada por
$
  T(t) = T_0 e^(r t) + T_"amb" (1 - e^(r t))
$

Implementando em Python o código exibido no Apêndice, utilizamos como parâmetros $r = -0.5 "s"^(-1)$, $T(0) eq.triple T_0 = 373 "K"$ e $T_"amb" = 273 "K"$, e o processo foi estudado num intervalo de $0"s a" 10 "s"$. O passo de integração escolhido foi $Delta t = 0.1 "s"$, observando graficamente a convergência das aproximações por passos de integração sucessivamente, em que os pontos cada vez mais sobrepuseram-se. Além disso, foi feita a comparação da aproximação com a solução exata.

A @aproximacao apresenta 20 pontos das temperaturas $T_K$ do corpo aproximadas em cada instante $t_k$.

#figure(
  table(
    columns: 2,

    table.header[Tempo (s)][Temperatura (K)],
    [0.50], [350.88],
    [0.60], [347.08],
    [0.70], [343.47],
    [0.80], [340.03],
    [0.90], [336.76],
    [1.00], [333.65],
    [1.10], [330.69],
    [1.20], [327.88],
    [1.30], [325.20],
    [1.40], [322.66],
    [1.50], [320.24],
    [1.60], [317.93],
    [1.70], [315.74],
    [1.80], [313.66],
    [1.90], [311.67],
    [2.00], [309.79],
    [2.10], [307.99],
    [2.20], [306.29],
    [2.30], [304.66],
    [2.40], [303.12],
      ),
      caption: [Resultados de 20 dos pontos obtidos com a aproximação de Runge-Kutta clássica para o resultado da lei de resfriamento de Newton, utilizando passo de integração de $Delta t = 0.1s$.]
)<aproximacao>

#figure(
  image("/aproximacoes.png", width: 80%),
  caption: [
    Aproximações com passos de integração sucessivamente menores para o problema, sendo aquela com $Delta t = 0.1s$ a escolhida.
  ],
)

#figure(
  image("/comparacao_com_exata.png", width: 80%),
  caption: [
    Comparação da melhor aproximação, com passo de integração $Delta t = 0.1s$, com a solução exata do problema (linha contínua).
  ],
)

= Apêndice: Código utilizado

Todo o código aqui apresentado e utilizado durante a atividade foi integralmente desenvolvido por mim, *sem* utilização de auxilio de inteligência artifícial generativa ou de outras espécies.

```py
'''
Método de um passo explícito para a atividade 1 de cálculo numérico
'''
# imports

import numpy as np

# funções de consistência

def verifica_tempo(tempo_inicial, tempo_final):
    '''
    Verifica que os tempos fornecidos são números; garante a ordenação temporal.
    '''
    if tempo_inicial >= tempo_final:
        raise ValueError("O tempo inicial deve ser menor do que o tempo final.")
    if (not isinstance(tempo_inicial, (int, float))) or (not isinstance(tempo_final, (int, float))):
        raise TypeError("Os extremos do intervalo devem ser números.")

def verifica_temperaturas(temperatura_corpo, temperatura_ambiente):
    '''
    Verifica que as temperaturas são números e garante que a 
    temperatura ambiente seja inferior à do corpo.
    '''
    if (not isinstance(temperatura_ambiente, (int, float))) or (not
        isinstance(temperatura_corpo, (int, float))):
        raise TypeError("As temperaturas devem ser números.")
    if not temperatura_corpo > temperatura_ambiente:
        raise ValueError("A temperatura do corpo deve ser maior do que a temperatura ambiente.")

def verifica_coeficiente(r):
    '''
    Verifica que o coeficiente de perda térmica é um 
    número negativo.
    '''
    message = "O coeficiente de perda térmica deve ser um número negativo."
    if not isinstance(r, (int, float)):
        raise TypeError(message)
    if not r < 0:
        raise ValueError(message)

def verifica_passo_integracao(dt):
    '''
    Verifica que o passo de integração é um número positivo.
    '''
    message = "O passo de inegração deve ser um número positivo."
    if not isinstance(dt, (int, float)):
        raise TypeError(message)
    if not dt > 0:
        raise ValueError(message)

# funções do programa

def partition_interval(t_start, t_end, n):
    '''
    Particiona um intervalo [t_start, t_end] em n intervalos.
    '''
    # consistências
    verifica_tempo(t_start, t_end)
    if not isinstance(n, int) or n <= 0:
        raise TypeError("O número de passos deve ser um número inteiro positivo.")

    # time-steps
    dt = (t_end - t_start)/n

    # pontos de partição
    partitioned_interval = np.linspace(t_start, t_end, n+1)
    return dt, partitioned_interval

def f(r, temperature, amb_temperature):
    '''
    Derivada da temperatura temperature(t) num instante arbitrário t.
    '''
    # consistências
    verifica_coeficiente(r)
    verifica_temperaturas(temperature, amb_temperature)
    return r * (temperature - amb_temperature)

def rk4(r, dt, temperature_k, amb_temperature):
    '''
    Função de discretização runge-kutta clássica (RK4) para a lei de resfriamento de Newton.
    - r é o coeficiente de perda térmica
    - dt é o passo de integração
    - temperature_k é a aproximação da temperatura do corpo no instante t_k
    - amb_temperature é a temperatura ambiente
    '''
    # consistências
    verifica_passo_integracao(dt)
    verifica_coeficiente(r)
    verifica_temperaturas(temperature_k, amb_temperature)

    # parâmetros auxiliares
    k1 = f(r, temperature_k, amb_temperature)
    k2 = f(r, temperature_k + (dt * k1)/2, amb_temperature)
    k3 = f(r, temperature_k + (dt * k2)/2, amb_temperature)
    k4 = f(r, temperature_k + dt * k3, amb_temperature)

    return (k1 + 2 * k2 + 2 * k3 + k4)/6

def explicit_one_step(r, start_temperature, amb_temperature, dt, partitioned_interval):
    '''
    Algoritmo de um passo explícito para a Lei de Resfriamento de Newton.
    r é o coeficiente de perda térmica
    start_temperature é a temperatura inicial do corpo
    amb_temperature é a temperatura ambiente
    dt é o passo de integração
    partitioned_interval é o intervalo de tempo particionado
    '''
    # consistências
    verifica_coeficiente(r)
    verifica_passo_integracao(dt)
    verifica_temperaturas(start_temperature, amb_temperature)
    if not isinstance(partitioned_interval, np.ndarray):
        raise TypeError("partitioned_interval deve ser um ndarray do numpy.")

    t0 = partitioned_interval[0]
    approx_table = np.array([[t0, start_temperature]])
    temperature = start_temperature
    for i in range(1, partitioned_interval.size):
        if temperature > amb_temperature:
            temperature = temperature + dt * rk4(r, dt, temperature, amb_temperature)
            approx_table = np.append(approx_table, [[partitioned_interval[i], temperature]], 0)
        else: break

    return approx_table


if __name__ == "__main__":
    # Intervalo de estudo
    TIME_START = 0
    TIME_END = 2

    # Quantidade de partições
    N = 50

    # Temperatura inicial do corpo e temperatura ambiente
    INITIAL_TEMP = 100
    AMBIENT_TEMP = 10

    # Coeficiente de perda térmica
    R = -1

    delta_t, interval_partitioned = partition_interval(TIME_START, TIME_END, N)
    table = explicit_one_step(R, INITIAL_TEMP, AMBIENT_TEMP, delta_t, interval_partitioned)

    print(table)
    print(table.transpose())

```

```py
'''
Gera tabelas e gráficos para a atividade 1 de cálculo numérico
'''

# imports

import numpy as np
import explicit_one_step as eos
import matplotlib.pyplot as plt

# funções do programa

def gera_tabela_typst():
    '''
    Recebe array (n, 1) do numpy, com n inteiro positivo, e retorna
    tabela formatada do typst, com cabeçalho (t, T(t)).
    '''
    return

def funcao_exata(params, t):
    '''
    Solução exata para a Lei de Resfriamento de Newton, em que
    params[0] é a temperatura ambiente,
    params[1] é a temperatura inicial do corpo,
    params[2] é o coeficiente de perda térmica,
    t é uma array do numpy com o intervalo de tempo discretizado.
    '''
    # consistências
    ambient_temperature = params[0]
    start_temperature = params[1]
    r = params[2]

    eos.verifica_temperaturas(start_temperature, ambient_temperature)
    eos.verifica_coeficiente(r)

    return start_temperature * np.exp(r * t) + ambient_temperature * (1 - np.exp(r * t))

if __name__ == "__main__":
    STEPS_NUMBERS = [5, 10, 15, 30, 100]
    STEPS_SIZES = []
    TABLES = []

    R = -.5
    START_TEMPERATURE = 373
    AMBIENT_TEMPERATURE = 273

    TIME_START = 0
    TIME_END = 10

    # aproximações
    for number in STEPS_NUMBERS:
        dt, intervals = eos.partition_interval(TIME_START, TIME_END, number)
        STEPS_SIZES.append(dt)
        APPROX_TABLE = eos.explicit_one_step(R, START_TEMPERATURE, AMBIENT_TEMPERATURE, dt,
            intervals)
        TABLES.append(APPROX_TABLE)

    # função exata
    TIME_ARRAY = np.linspace(TIME_START, TIME_END, 500)
    Y = funcao_exata([AMBIENT_TEMPERATURE, START_TEMPERATURE, R], TIME_ARRAY)

    # gráfico de aproximações sucessivas
    fig1, ax1 = plt.subplots()

    ax1.plot(TABLES[0].transpose()[0], TABLES[0].transpose()[1], label="Δt = 2s", marker="v", linestyle="--")
    ax1.plot(TABLES[1].transpose()[0], TABLES[1].transpose()[1], label="Δt = 1s", marker="x", linestyle="--", markersize="10")
    ax1.plot(TABLES[3].transpose()[0], TABLES[3].transpose()[1], label="Δt = 0.33s", marker="s", linestyle="--")
    ax1.plot(TABLES[4].transpose()[0], TABLES[4].transpose()[1], label="Δt = 0.1s", marker=">", linestyle="--")
 
    ax1.set_xlabel('Tempo [s]')
    ax1.set_ylabel('Temperatura [K]')
    ax1.set_title('Lei de resfriamento de Newton')
    ax1.legend()
    ax1.grid()
    fig1.savefig('aproximacoes.png')

    # gráfico da aproximação final com resultado exato
    fig2, ax2 = plt.subplots()

    ax2.plot(TABLES[4].transpose()[0], TABLES[4].transpose()[1], label="Aproximação", marker="x", linestyle="None")
    ax2.plot(TIME_ARRAY, Y, label="Solução exata")
    ax2.set_xlabel('Tempo [s]')
    ax2.set_ylabel('Temperatura [K]')
    ax2.set_title('Lei de resfriamento de Newton')
    ax2.legend()
    ax2.grid()
    fig2.savefig('comparacao_com_exata.png')

    # tabela com todos os valores da aproximação final
    data = ""
    for point in TABLES[4]:
        data += f"[{point[0]:.2f}], [{point[1]:.2f}],\n"
    
    with open("tabela.txt", "w") as f:
        f.write(data)

```