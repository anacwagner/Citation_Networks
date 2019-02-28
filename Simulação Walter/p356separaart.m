function [a_estrat]=p356separaart(a,estrat)
%separa os artigos dos periódicos "estratégicos" existentes
a_estrat=[];
for i=1:size(a,1)
    if find(estrat(:,1)==a(i,1)) %se o periódico está na lista de estratégicos
        a_estrat=[a_estrat;a(i,:)];  %o artigo é colocado na lista de "estratégicos"
    end
end
%recalcular os valores acumulados (fitness e fitness ponderado por grau)
%valores válidos para este arquivo filtrado
a_estrat=[a_estrat(:,1:4) cumsum(a_estrat(:,4)) a_estrat(:,6:8) cumsum(a_estrat(:,8)) a_estrat(:,10)];