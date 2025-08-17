'''
Método de um passo explícito para a atividade 1
'''
# imports

import numpy as np

# funções

def part_interval(t_start, t_end, n):
    '''
    Particiona um intervalo [t_start, t_end] em n intervalos.
    '''
    # consistências
    if t_start >= t_end:
        raise ValueError("O tempo inicial deve ser menor do que o tempo final.")
    if (not isinstance(t_start, float)) or (not isinstance(t_end, float)):
        raise TypeError("Os extremos do intervalo devem ser floats.")
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
    if not isinstance(r, float):
        raise TypeError("O coeficiente de perda térmica deve ser um float.")
    if (not isinstance(T, float)) or (not isinstance(T_amb, float)):
        raise TypeError("A temperatura deve ser um float.")

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
    if not isinstance(r, float):
        raise TypeError("O coeficiente de perda térmica deve ser um float.")
    if not isinstance(dt, float):
        raise TypeError("O passo dt deve ser um float.")
    if (not isinstance(T_k, float)) or (not isinstance(T_amb, float)):
        raise TypeError("A temperatura deve ser um float.")

    # parâmetros auxiliares

    k1 = f(r, T_k, T_amb)
    k2 = f(r, T_k + (dt * k1)/2, T_amb)
    k3 = f(r, T_k + (dt * k2)/2, T_amb)
    k4 = f(r, T_k + dt * k3, T_amb)

    return (k1 + 2 * k2 + 2 * k3 + k4)/6

def explicit_one_step(r, T0, T_amb, dt, part_interval):
    '''
    Algoritmo de um passo explícito para a Lei de Resfriamento de newton.
    r é o coeficiente de perda térmica
    T0 é a temperatura inicial do corpo
    T_amb é a temperatura ambiente
    dt é o passo de integração
    part_interval é o intervalo de tempo particionado
    '''
    t0 = part_interval[0]
    approx_table = np.array([[t0, T0]])
    T = T0
    for i in range(1, part_interval.size):
        T = rk4(r, dt, T, T_amb)
        np.append(approx_table, [part_interval[i], T])

    return approx_table
