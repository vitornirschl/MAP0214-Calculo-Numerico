/* Preâmbulo */
#import "@preview/physica:0.9.5":*
#set par(
  first-line-indent: 1em,
  spacing: 0.65em,
  justify: true,
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

A tabela [REF] apresenta as temperaturas $T_K$ do corpo aproximadas em cada instante $t_k$.