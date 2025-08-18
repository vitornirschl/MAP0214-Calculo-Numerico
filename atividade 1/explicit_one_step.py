'''
Método de um passo explícito para a atividade 1
'''
# imports

import numpy as np

# funções

def partition_interval(t_start, t_end, n):
    '''
    Particiona um intervalo [t_start, t_end] em n intervalos.
    '''
    # consistências
    if t_start >= t_end:
        raise ValueError("O tempo inicial deve ser menor do que o tempo final.")
    if (not isinstance(t_start, (int, float))) or (not isinstance(t_end, (int, float))):
        raise TypeError("Os extremos do intervalo devem ser números.")
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

def f(r, T, T_amb):
    '''
    Derivada da temperatura T(t) num instante arbitrário t.
    '''
    # consistências
    if not isinstance(r, (float, int)):
        raise TypeError("O coeficiente de perda térmica deve ser um número.")
    if (not isinstance(T, (float, int))) or (not isinstance(T_amb, (int, float))):
        raise TypeError("A temperatura deve ser um número.")

    return r * (T - T_amb)

def rk4(r, dt, T_k, T_amb):
    '''
    Função de discretização runge-kutta clássica (RK4) para a lei de resfriamento de Newton.
    - r é o coeficiente de perda térmica
    - dt é o passo de integração
    - T_k é a aproximação da temperatura do corpo no instante t_k
    - T_amb é a temperatura ambiente
    '''
    # consistências
    if not isinstance(r, (int, float)):
        raise TypeError("O coeficiente de perda térmica deve ser um número.")
    if not isinstance(dt, (int, float)):
        raise TypeError("O passo dt deve ser um número.")
    if (not isinstance(T_k, (int, float))) or (not isinstance(T_amb, (int, float))):
        raise TypeError("A temperatura deve ser um número.")

    # parâmetros auxiliares

    k1 = f(r, T_k, T_amb)
    k2 = f(r, T_k + (dt * k1)/2, T_amb)
    k3 = f(r, T_k + (dt * k2)/2, T_amb)
    k4 = f(r, T_k + dt * k3, T_amb)

    return (k1 + 2 * k2 + 2 * k3 + k4)/6

def explicit_one_step(r, T0, T_amb, dt, partitioned_interval):
    '''
    Algoritmo de um passo explícito para a Lei de Resfriamento de newton.
    r é o coeficiente de perda térmica
    T0 é a temperatura inicial do corpo
    T_amb é a temperatura ambiente
    dt é o passo de integração
    partitioned_interval é o intervalo de tempo particionado
    '''
    # consistências
    if not isinstance(r, (int, float)):
        raise TypeError("O coeficiente de perda térmica deve ser um número.")
    if not isinstance(dt, (int, float)):
        raise TypeError("O passo de integração deve ser um número.")
    if (not isinstance(T0, (int, float))) or (not isinstance(T_amb, (int, float))):
        raise TypeError("A temperatura deve ser um número.")
    if not isinstance(partitioned_interval, np.ndarray):
        raise TypeError("partitioned_interval deve ser um ndarray do numpy.")

    t0 = partitioned_interval[0]
    approx_table = np.array([[t0, T0]])
    T = T0
    for i in range(1, partitioned_interval.size):
        T = T + dt * rk4(r, dt, T, T_amb)
        approx_table = np.append(approx_table, [[partitioned_interval[i], T]], 0)

    return approx_table


if __name__ == "__main__":
    # Intervalo de estudo
    t_start = 0
    t_end = 2

    # Quantidade de partições
    n = 50

    # Temperatura inicial do corpo e temperatura ambiente
    T0 = 100
    T_amb = 10

    # Coeficiente de perda térmica
    r = -1

    dt, partitioned_interval = partition_interval(t_start, t_end, n)
    table = explicit_one_step(r, T0, T_amb, dt, partitioned_interval)

    print(table)
