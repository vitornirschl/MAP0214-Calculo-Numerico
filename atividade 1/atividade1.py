'''
Gera tabelas e gráficos para a atividade 1 de cálculo numérico
'''

# imports

import numpy as np
import math
import explicit_one_step as eos

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
    params[2] é o coeficiente de perda térmica.
    '''
    # consistências
    ambient_temperature = params[0]
    start_temperature = params[1]
    r = params[2]

    eos.verifica_temperaturas(start_temperature, ambient_temperature)
    eos.verifica_coeficiente(r)

    return

if __name__ == "__main__":
    STEPS_NUMBERS = [10, 25, 50, 100, 200, 500]
    STEPS_SIZES = []
    TABLES = []

    R = -1
    START_TEMPERATURE = 373
    AMBIENT_TEMPERATURE = 273

    TIME_START = 0
    TIME_END = 10
    for number in STEPS_NUMBERS:
        dt, intervals = eos.partition_interval(TIME_START, TIME_END, STEPS_NUMBERS[number])
        STEPS_SIZES.append(dt)
        TABLES.append(eos.explicit_one_step(R, START_TEMPERATURE, AMBIENT_TEMPERATURE, dt, intervals))
