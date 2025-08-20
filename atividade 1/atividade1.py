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
