/* Preâmbulo */
#import "@preview/physica:0.9.5": *
#set math.equation(numbering: "(1)")
#set text(lang: "pt")
#show heading: smallcaps

/* Cabeçalho */

#align(center)[
  #text(size: 18pt, weight: "bold", hyphenate: false)[#smallcaps()[Aproximações numéricas para soluções de problemas de Cauchy]]
  #v(-5pt)
  #text[Vitor Nirschl | vitor.nirschl\@usp.br | Instituto de Física da USP | Nº USP 13685771]
  #v(10pt)
  #par(first-line-indent: 0em)[#text(size: 10pt, style: "italic")[Palavras-chave: Problema de Cauchy, Lei de Resfriamento de Newton, Modelo Lotka-Volterra, Métodos Numéricos, Interpolação Polinomial, Splines.]]
  #v(5pt)
]

#set par(
  first-line-indent: 1em,
  spacing: 0.65em,
  justify: true,
)

/* Corpo */

São propostos dois modelos matemáticos descritos por equações diferenciais ordinárias com condições iniciais (problemas de Cauchy), sendo o primeiro unidimensional (Lei de resfriamento de Newton) e, o segundo, multidimensional (modelo de Lotka-Volterra), descrito por duas variáveis de estado. Aqui, eles são apresentados na forma normal.

= Lei de resfriamento de Newton

Considere um corpo incrompressível com capacidade térmica constante $C$, cuja temperatura é dada ao longo do tempo por $T(t)$. Se o ambiente no qual o corpo se encontra permanece a temperatura fixa $T_"amb"$ (sendo aqui idealizado como um reservatório térmico), então o fluxo de calor perdido pelo corpo para o ambiente $q$ (dado em unidades de potência por área) é descrito pela equação
$
  q = h(T(t) - T_"amb")
$

Integrando sobre toda a área do corpo, $A$, encontramos a taxa de transferência de calor do corpo $dot(Q)$, dada em unidades de potência,
$
  dv(Q, t) = integral_A dd(A) h (T(t) - T_"amb") = h A (T(t) - T_"amb")
$

Mas sabemos que a capacidade térmica de um corpo incompressível é dada por
$
  C = dv(U, T) quad "em que" U "é a energia interna do corpo" => dv(U, t) = C dv(T, t)
$
e, sendo $dv(U, t) = - dv(Q, t)$, finalmente podemos agrupar as constantes e reescrever a Lei de resfriamento de Newton na forma

$
  dv(T, t) = r (T(t) - T_"amb")
$<lei-resfriamento-newton>
em que $T(t)$ representa a temperatura do corpo no instante $t$, $T_"amb"$ representa a temperatura ambiente e $r$ é o coeficiente de transferência térmica, dado em unidades de frequência (inverso de tempo). 

Dada a temperatura num instante inicial, $T(0) eq.triple T_0$, podemos determinar a temperatura do corpo em qualquer outro instante. @ahtt6e @bergman2011fundamentals @sagar2022fundamentals

== Adimensionalização do modelo

Podemos adimensionalizar a equação da Lei de Resfriamento de Newton. Para isso, começamos estabelecendo o "tempo adimensional", dado pela relação entre a variável temporal $t$ e um tempo de referência, aqui escolhido $t_0$. Ele será dado por $t^* = t "/" t_0$. Com isso, podemos escrever a temperatura do corpo como uma função do tempo adimensional, $T(t) = T(t_0 t^*)$. Mais ainda, podemos definir convenientemente uma função de temperatura adimensional $T^*(t^*)$, fazendo simplesmente
$
  T^*(t^*) eq.triple (T(t_0 t^*) - T_"amb")/(T_0)
$
Veja que podemos derivar essa expressão com respeito a $t^*$ e usar a regra da cadeia,
$
  dv(T^*, t^*) = 1/(T_0) dv(T, t^*) = 1/(T_0) dv(T, t) dv(t, t^*) = r t_0 (T(t_0 t^*) - T_"amb")/(T_0) => dv(T^*, t^*) = r t_0 T^*(t^*)
$
de modo a encontrar uma EDO adimensional para nosso problema.

= Modelo de caça-presa de Lotka-Volterra

O modelo matemático de Lotka-Volterra consiste num sistema de equações diferenciais que descrevem a evolução temporal de sistemas biológicos compostos por duas espécies interagentes, uma como predadora e outra como presa. Trata-se de uma idealização primitiva que lida com um sistema isolado e desconsidera outros fatores influentes na dinâmica de um biossistema, como doenças e competição entre espécies. 

Sejam $x(t)$ e $y(t)$, respectivamente, as densidades populacionais de uma espécie de presas e uma de predadores ao longo do tempo $t$, dadas em quantidade de indíviduos por unidade de área; digamos, por exemplo, de coelhos e raposas.

O sistema de Lotka-Volterra é descrito pelas equações
$
  dv(x, t) = alpha x(t) - beta x(t) y(t) \
  dv(y, t) = - gamma y(t) + delta x(t) y(t)
$

em que $alpha$ descreve a taxa máxima de crescimento populacional da presa, dada em unidades de frequência, $beta$ descreve a influência da espécie predadora na taxa de mortalidade da espécie presa, em unidades de frequência vezes área, $gamma$ descreve a taxa de mortalidade per capita da espécie predadora, em unidades de frequência, e $delta$ descreve a influência da presença da espécie presa na taxa de crescimento da espécie predadora, em unidades de frequência vezes área. Todos esses parâmetros são positivos e reais. 

  Sendo $X(t) = vec(x(t), y(t))$, podemos reescrever o sistema na forma normal como
$
  dv(X(t), t) = M X(t) + G(X(t))
$
em que
$
  M = mat(alpha, 0; 0, -gamma) quad "e" quad G(X(t)) = vec(-beta x(t) y(t), delta x(t) y(t))
$
Dadas as condições iniciais do sistema, isto é, as densidades populacionais num instante fixo $t_0$, $x(t_0) eq.triple x_0$ e $y(t_0) eq.triple y_0$ (ou, na forma vetorial, $X(t_0) = vec(x_0, y_0) eq.triple X_0$), podemos determinar $x(t)$ e $y(t)$ em qualquer instante. @brauer2001mathematical @monteiro2002sistemas @hofbauer1988theory @JCBarata

/* Bibliografia */

#bibliography("bibliografia.bib", style: "american-physics-society")