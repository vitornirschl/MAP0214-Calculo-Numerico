/* Preâmbulo */
#import "@preview/physica:0.9.5": *
#set math.equation(numbering: "(1)")
#set text(lang: "pt")
#set par(
  first-line-indent: 1em,
  spacing: 0.65em,
  justify: true,
)

/* Cabeçalho */

#align(center)[
  #text(size: 18pt, weight: "bold")[Problemas de Cauchy] \
  #text[Vitor Nirschl | vitor.nirschl\@usp.br | Nº USP 13685771]
  #v(10pt)
]

/* Corpo */

São propostos dois modelos matemáticos descritos por equações diferenciais ordinárias com condições iniciais (problemas de Cauchy), sendo o primeiro unidimensional (Lei de resfriamento de Newton) e, o segundo, multidimensional (modelo de Lotka-Volterra), descrito por duas variáveis de estado. Aqui, eles são apresentados na forma normal.

= Lei de resfriamento de Newton

A Lei de resfriamento de Newton relaciona a taxa de perda de temperatura de um corpo com a diferença entre sua temperatura e a do ambiente, desde que essa seja pequena. Além disso, assume-se que o coeficiente térmico do corpo permaneça constante. Além disso, assume-se que o ambiente seja um reservatório térmico, no sentido de que sua temperatura não varia pela troca de calor. Matematicamente, o modelo é dado por
$
  dv(T, t) = r (T(t) - T_"amb")
$ 
em que $T(t)$ representa a temperatura do corpo no instante $t$, $T_"amb"$ representa a temperatura ambiente e $r$ é o coeficiente de transferência térmica, dado em unidades de frequência (inverso de tempo). Dada a temperatura num instante inicial, $T(0)$, podemos determinar a temperatura do corpo em qualquer outro instante. @ahtt6e @bergman2011fundamentals @sagar2022fundamentals

= Modelo de caça-presa de Lotka-Volterra

O modelo matemático de Lotka-Volterra consiste num sistema de equações diferenciais que descrevem a evolução temporal de sistemas biológicos compostos por duas espécies interagentes, uma como predadora e outra como presa. Trata-se de uma idealização primitiva que lida com um sistema isolado e desconsidera outros fatores influentes na dinâmica de um biossistema, como doenças e competição entre espécies. 

Sejam $x(t)$ e $y(t)$, respectivamente, as densidades populacionais de uma espécie de presas e uma de predadores ao longo do tempo $t$, dadas em quantidade de indíviduos por unidade de área; digamos, por exemplo, de coelhos e raposas.

O sistema de Lotka-Volterra é descrito pelas equações
$
  dv(x, t) = alpha x(t) - beta x(t) y(t) \
  dv(y, t) = - gamma y(t) + delta x(t) y(t)
$

em que $alpha$ descreve a taxa máxima de crescimento populacional da presa, dada em unidades de frequência, $beta$ descreve a influência da espécie predadora na taxa de mortalidade da espécie presa, em unidades de frequência vezes área, $gamma$ descreve a taxa de mortalidade per capita da espécie predadora, em unidades de frequência, e $delta$ descreve a influência da presença da espécie presa na taxa de crescimento da espécie predadora, em unidades de frequência vezes área. Todos esses parâmetros são positivos e reais. Dadas as condições iniciais do sistema, isto é, as densidades populacionais num instante fixo $t_0$, podemos determinar $x(t)$ e $y(t)$ em qualquer instante. @brauer2001mathematical @monteiro2002sistemas @hofbauer1988theory

/* Bibliografia */

#bibliography("bibliografia.bib", style: "american-physics-society")