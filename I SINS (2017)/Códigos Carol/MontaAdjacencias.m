function A = MontaAdjacencias(lista_arestas, ano)

A = zeros(400,400);

lista_ano = lista_arestas((lista_arestas(:,1)<=ano)&(lista_arestas(:,1)>(ano-5)), :);

for k=1:size(lista_ano,1)
    source = lista_ano(k,3);
    target = lista_ano(k,4);
    qtd = lista_ano(k,5);
    A(target, source) = A(target,source)+qtd;
end
    