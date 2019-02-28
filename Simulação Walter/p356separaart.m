function [a_estrat]=p356separaart(a,estrat)
%separa os artigos dos peri�dicos "estrat�gicos" existentes
a_estrat=[];
for i=1:size(a,1)
    if find(estrat(:,1)==a(i,1)) %se o peri�dico est� na lista de estrat�gicos
        a_estrat=[a_estrat;a(i,:)];  %o artigo � colocado na lista de "estrat�gicos"
    end
end
%recalcular os valores acumulados (fitness e fitness ponderado por grau)
%valores v�lidos para este arquivo filtrado
a_estrat=[a_estrat(:,1:4) cumsum(a_estrat(:,4)) a_estrat(:,6:8) cumsum(a_estrat(:,8)) a_estrat(:,10)];