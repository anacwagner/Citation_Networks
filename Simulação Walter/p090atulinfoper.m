function [pg,pa,pf,pif]=p090atulinfoper(pg,pa,pf,pif,citper,a,ano)
%atualiza as informa��es dos peri�dicos
%grau de entrada
%quantidade de artigos publicados
%quantidade de artigos publicados no bi�nio
%quantidade de artigos publicados nos 5 anos
%formato de "p"
    %coluna 01: c�digo do peri�dico (sequencial)
    %coluna 02: m�dia de fitness dos artigos do peri�dico (uniforme/range 1:f)
    %coluna 03: dp de fitness dos artigos do peri�dico: fun��o da m�dia de fitness: dp=m/2
    %coluna 04: n�mero inicial de artigos (poisson m�dia na_i)
    %coluna 05: n�mero de artigos por ano (poisson m�dia na_a)
    %coluna 06: fitness m�dio real TOTAL
    %coluna 07: fitness m�dio real DOIS ANOS
    %coluna 08: fitness m�dio real CINCO ANOS
    %coluna 09: grau de entrada TOTAL
    %coluna 10: grau de entrada DOIS ANOS
    %coluna 11: grau de entrada CINCO ANOS
    %coluna 12: n�mero de edi��es ao ano do peri�dico (aleat�rio: 1, 2, 3, 4)
    

for i=1:size(pg,1)
    pg(i,(ano*3)+2)=sum((citper(:,4)==pg(i,1)).*(citper(:,2)<=(ano)).*(citper(:,5))); %quantidade total de cita�oes recebidas at� o ano
    pg(i,(ano*3)+3)=sum((citper(:,4)==pg(i,1)).*(citper(:,2)>(ano-2)).*(citper(:,2)<=(ano)).*(citper(:,5))); %quantidade total de cita�oes recebidas pelos artgos dos �ltimos dois anos
    pg(i,(ano*3)+4)=sum((citper(:,4)==pg(i,1)).*(citper(:,2)>(ano-5)).*(citper(:,2)<=(ano)).*(citper(:,5))); %quantidade total de cita�oes recebidas pelos artgos dos �ltimos cinco anos

    pa(i,(ano)+2)=sum((a(:,1)==pg(i,1)).*(a(:,3)==ano)); %quantidade de artigos publicados no ano
    
    pf(i,(ano)+2)=sum((a(:,1)==pg(i,1)).*(a(:,3)==ano).*(a(:,4)))/sum((a(:,1)==pg(i,1)).*(a(:,3)==ano)); %fitness m�dia dos artigos do ano
    
    pif(i,(ano*3)+2)=pg(i,(ano*3)+2)/sum(pa(i,1:(ano)+2)); %FI total at� o ano: quantidade total de cita��es at� o ano dividido pelo total de artigos at� o ano
    pif(i,(ano*3)+3)=pg(i,(ano*3)+3)/pa(i,(ano)+2); %FI-2 no ano: quantidade de cita��es recebidas de artigos dos dois �ltimos anos dividido pela quantidade de artigos publicados no ano
    pif(i,(ano*3)+4)=pg(i,(ano*3)+4)/pa(i,(ano)+2); %FI-5 no ano: quantidade de cita��es recebidas de artigos dos cinco �ltimos anos dividido pela quantidade de artigos publicados no ano
    
end
