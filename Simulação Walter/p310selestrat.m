function estrat=p310selestrat(pif,prob_estrat,ano)
%separa os periódicos periféricos e seleciona dentre eles os que terão comportamento "estratégico"

%preparar cabeçalho da função


%a expressão "ano*3+3" dá o número da coluna de FI-2 correspondente ao ano especificado
%pif=[pif(:,1) pif(:,ano*3+3)]; pega a coluna com os códigos dos periódicos e o FI-2 do ano especificado
%pif=sortrows(pif,[2 1]); coloca em ordem crescente do FI-2
pif=sortrows(([pif(:,1) pif(:,ano*3+3)]),[2 1]);%pif tem a lista de periódicos ordenada por FI-2 do ano 3
pif=[pif cumsum(pif(:,2))/sum(pif(:,2))];  %inclui uma coluna com o valor acumulado relativo de FI-2
pif=pif(pif(:,3)<quantile(pif(:,3),0.25)); %separa apenas os periódicos incluídos no primeiro quartil de FI-2
sorteio=rand(size(pif,1),1)<prob_estrat; %vetor com sorteado dos índices dos periódicos estratégicos
while sum(sorteio)<2                     %sorteia até ter pelo menos 2 periódicos estratégicos
    sorteio=rand(size(pif,1),1)<prob_estrat;
end
estrat=pif(sorteio(:,1)==1); %seleciona o código dos periódicos correspondentes aos indices sorteados