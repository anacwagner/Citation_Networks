function [pg,pa,pf,pif]=p090atulinfoper(pg,pa,pf,pif,citper,a,ano)
%atualiza as informações dos periódicos
%grau de entrada
%quantidade de artigos publicados
%quantidade de artigos publicados no biênio
%quantidade de artigos publicados nos 5 anos
%formato de "p"
    %coluna 01: código do periódico (sequencial)
    %coluna 02: média de fitness dos artigos do periódico (uniforme/range 1:f)
    %coluna 03: dp de fitness dos artigos do periódico: função da média de fitness: dp=m/2
    %coluna 04: número inicial de artigos (poisson média na_i)
    %coluna 05: número de artigos por ano (poisson média na_a)
    %coluna 06: fitness médio real TOTAL
    %coluna 07: fitness médio real DOIS ANOS
    %coluna 08: fitness médio real CINCO ANOS
    %coluna 09: grau de entrada TOTAL
    %coluna 10: grau de entrada DOIS ANOS
    %coluna 11: grau de entrada CINCO ANOS
    %coluna 12: número de edições ao ano do periódico (aleatório: 1, 2, 3, 4)
    

for i=1:size(pg,1)
    pg(i,(ano*3)+2)=sum((citper(:,4)==pg(i,1)).*(citper(:,2)<=(ano)).*(citper(:,5))); %quantidade total de citaçoes recebidas até o ano
    pg(i,(ano*3)+3)=sum((citper(:,4)==pg(i,1)).*(citper(:,2)>(ano-2)).*(citper(:,2)<=(ano)).*(citper(:,5))); %quantidade total de citaçoes recebidas pelos artgos dos últimos dois anos
    pg(i,(ano*3)+4)=sum((citper(:,4)==pg(i,1)).*(citper(:,2)>(ano-5)).*(citper(:,2)<=(ano)).*(citper(:,5))); %quantidade total de citaçoes recebidas pelos artgos dos últimos cinco anos

    pa(i,(ano)+2)=sum((a(:,1)==pg(i,1)).*(a(:,3)==ano)); %quantidade de artigos publicados no ano
    
    pf(i,(ano)+2)=sum((a(:,1)==pg(i,1)).*(a(:,3)==ano).*(a(:,4)))/sum((a(:,1)==pg(i,1)).*(a(:,3)==ano)); %fitness média dos artigos do ano
    
    pif(i,(ano*3)+2)=pg(i,(ano*3)+2)/sum(pa(i,1:(ano)+2)); %FI total até o ano: quantidade total de citações até o ano dividido pelo total de artigos até o ano
    pif(i,(ano*3)+3)=pg(i,(ano*3)+3)/pa(i,(ano)+2); %FI-2 no ano: quantidade de citações recebidas de artigos dos dois últimos anos dividido pela quantidade de artigos publicados no ano
    pif(i,(ano*3)+4)=pg(i,(ano*3)+4)/pa(i,(ano)+2); %FI-5 no ano: quantidade de citações recebidas de artigos dos cinco últimos anos dividido pela quantidade de artigos publicados no ano
    
end
