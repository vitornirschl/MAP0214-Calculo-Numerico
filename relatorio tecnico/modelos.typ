#import "@preview/physica:0.9.5": *
#set math.equation(numbering: "(1)")
#set text(lang: "pt")

#align(center)[
  #text(size: 18pt, weight: "bold")[Problemas de Cauchy] \
  #text[Vitor Nirschl | vitor.nirschl\@usp.br | Nº USP 13685771]
  #v(10pt)
]

São propostos dois modelos matemáticos descritos por equações diferenciais ordinárias com condições iniciais (problemas de Cauchy), sendo o primeiro unidimensional (ATUALIZAR MODELO) e, o segundo, multidimensional (modelo de Lotka-Volterra), descrito por duas variáveis de estado. Aqui, eles são apresentados na forma normal.

= 

= Modelo de caça-presa de Lotka-Volterra

O modelo matemático de Lotka-Volterra consiste num sistema de equações diferenciais que descrevem a evolução temporal de sistemas biológicos compostos por duas espécies interagentes, uma como predadora e outra como presa. Trata-se de uma idealização primitiva que lida com um sistema isolado e desconsidera outros fatores influentes na dinâmica de um biossistema, como doenças e competição entre espécies. 

Sejam $x(t)$ e $y(t)$, respectivamente, as densidades populacionais de uma espécie de presas e uma de predadores ao longo do tempo $t$, dadas em quantidade de indíviduos por unidade de área; digamos, por exemplo, de coelhos e raposas.

O sistema de Lotka-Volterra é descrito pelas equações
$
  dv(x, t) = alpha x(t) - beta x(t) y(t) \
  dv(y, t) = - gamma y(t) + delta x(t) y(t)
$

em que $alpha$ descreve a taxa máxima de crescimento populacional da presa, dada em unidades de frequência, $beta$ descreve a influência da espécie predadora na taxa de mortalidade da espécie presa, em unidades de frequência vezes área, $gamma$ descreve a taxa de mortalidade per capita da espécie predadora, em unidades de frequência, e $delta$ descreve a influência da presença da espécie presa na taxa de crescimento da espécie predadora, em unidades de frequência vezes área. Todos esses parâmetros são positivos e reais. Dadas as condições iniciais do sistema, isto é, as densidades populacionais num instante fixo $t_0$, podemos determinar $x(t)$ e $y(t)$ em qualquer instante. @brauer2001mathematical @monteiro2002sistemas @hofbauer1988theory

#bibliography("bibliografia.bib", style: "american-physics-society")