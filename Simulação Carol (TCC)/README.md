# Simulação TCC Carol

* Código original elaborado pelo professor [Walter Sande](https://emap.fgv.br/corpo-docente/walter-wagner-carvalho-sande) para sua tese de Doutorado.

* Código adaptado por Ana Carolina Wagner para seu TCC. A dinâmica de simulação original foi alterada de modo a tentar ficar mais realista. Aqui, uma nova dinâmica de simulação de uma rede de citações foi desenvolvida e analisada. Em seguida, seus resultados foram comparados aos originais. 

## Dinâmica da Simulação: Matching entre Artigos e Periódicos

Em cada período (ano),

Os periódicos já possuem uma reputação inicial, que é herdada da média da qualidade de seus artigos em períodos anteriores.

  1. Os artigos de todos os autores são gerados com seu fitness correspondente gerado a partir de uma distribuição normal (independentemente dos periódicos).

  2. Os artigos são enviados aos periódicos para avaliação. Os artigos são preferncialmente enviados aos periódicos que têm reputação semelhante à qualidade do artigo produzido. Componente Estocástico: os artigos de qualidade $\theta$ são enviados aos periódicos de reputação $\alpha$ de acordo com uma função de probabilidade $1/|\alpha − \tehta|$. Dessa forma, quanto mais próximo $\tehta$ e $\alpha$, maior a probabilidade.

  3. Depois do processo de submissão dos artigos aos periódicos, estes fazem uma seleção dos artigos que serão publicados. É determinado que cada periódico escolhe os 30 melhores artigos que foram submetidos.

  4. Com a publicação dos novos artigos, os periódicos atualizam sua reputação 𝛼 com base nos artigos publicados.

  5. Se poucos artigos são publicados pelo periódico, ele morre. Quando muitos artigs são rejeitados por um periódico, há a criação de um novo periódico.

  6. Volta ao passo (1) para um novo período.

## Resultados 





