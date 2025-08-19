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
    if (not isinstance(temperatura_ambiente, (int, float))) or (not isinstance(temperatura_corpo, (int, float))):
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
    partitioned_interval = np.array([t_start])
    t = t_start
    while t <= t_end:
        t += dt
        partitioned_interval = np.append(partitioned_interval, t)
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
        temperature = temperature + dt * rk4(r, dt, temperature, amb_temperature)
        approx_table = np.append(approx_table, [[partitioned_interval[i], temperature]], 0)

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
