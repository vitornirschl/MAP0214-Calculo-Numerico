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

Estamos interessados em fazer uma aproximação numérica para esse problema. Para isso, utilizaremos o método de Runge-Kutta clássico.