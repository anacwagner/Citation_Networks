function estrat=p310selestrat(pif,prob_estrat,ano)
%separa os peri�dicos perif�ricos e seleciona dentre eles os que ter�o comportamento "estrat�gico"

%preparar cabe�alho da fun��o


%a express�o "ano*3+3" d� o n�mero da coluna de FI-2 correspondente ao ano especificado
%pif=[pif(:,1) pif(:,ano*3+3)]; pega a coluna com os c�digos dos peri�dicos e o FI-2 do ano especificado
%pif=sortrows(pif,[2 1]); coloca em ordem crescente do FI-2
pif=sortrows(([pif(:,1) pif(:,ano*3+3)]),[2 1]);%pif tem a lista de peri�dicos ordenada por FI-2 do ano 3
pif=[pif cumsum(pif(:,2))/sum(pif(:,2))];  %inclui uma coluna com o valor acumulado relativo de FI-2
pif=pif(pif(:,3)<quantile(pif(:,3),0.25)); %separa apenas os peri�dicos inclu�dos no primeiro quartil de FI-2
sorteio=rand(size(pif,1),1)<prob_estrat; %vetor com sorteado dos �ndices dos peri�dicos estrat�gicos
while sum(sorteio)<2                     %sorteia at� ter pelo menos 2 peri�dicos estrat�gicos
    sorteio=rand(size(pif,1),1)<prob_estrat;
end
estrat=pif(sorteio(:,1)==1); %seleciona o c�digo dos peri�dicos correspondentes aos indices sorteados