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

Estamos interessados em fazer uma aproximação numérica para esse problema. Para isso, nossa função de discretização será dada pelo método de de Runge-Kutta clássico (RK4). Se reescrevemos
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
Sendo $T_k$ a aproximação numérica de $T(t_k)$, a função de discretização será
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

Traduzindo essas equações para a função $f$ de nosso problema, temos
$
  k_1 (t_k, T_k, Delta t) = r(T_k - T_"amb")
  \
  k_2 (t_k, T_k, Delta t) = (r + (Delta t)/2 r^2) (T_k - T_"amb")
  \
  k_3 (t_k, T_k, Delta t) = (r + (Delta t)/2 r^2 + ((Delta t)/2)^2 r^3)(T_k - T_"amb")
  \
  k_4 (t_k, T_k, Delta t) = (r + 2 (Delta t)/2 r^2 + 2 ((Delta t)/2)^2 r^3 + 2 ((Delta t)/2)^3 r^4)(T_k - T_"amb")
$
de modo que
$
  phi.alt_"RK4" (t_k, T_k, Delta t) = r (1 + 1/2 (Delta t) r + 1/6 (Delta t)^2 r^2 + 1/24 (Delta t)^3 r^3) (T_k - T_"amb")
$