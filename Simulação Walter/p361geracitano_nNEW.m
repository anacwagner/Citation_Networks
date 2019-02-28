function cit=p361geracitano_nNEW(a,an)
%gera o arquivo "cit" com as citações dos artigos de um ano 
%PROCESSO NORMAL: base completa dos artigos, citações dos artigos "normais"
%exatamente igual ao p060
%replicado por finalidade de organização: separação do processo estratégico
%tem que rodar com an = artigos "normais" gerados no período
%
%parâmetros de entrada:
    %a: lista de artigos existentes até o período passado
    %an: lista de artigos publicados neste período - LISTA DE ARTIGOS "NORMAIS"

%considera grau de entrada e valor de fitness de cada artigo para seleção
%estratégia de seleção: 
    %50% apenas pelo fitness
    %50% pelo fitness ponderado pelo grau de entrada

%SAÍDA
%formato de "cit"
    %coluna 01: código do artigo SOURCE
    %coluna 02: ano do artigo SOURCE
    %coluna 03: periódico do artigo SOURCE
    %coluna 04: código do artigo TARGET
    %coluna 05: ano do artigo TARGET
    %coluna 06: periódico do artigo TARGET
    %coluna 07: edição do periódico do artigo SOURCE 
    %coluna 08: edição do periódico do artigo TARGET

%ENTRADA
%formato de "a" e "an"
    %coluna 01: código do periódico
    %coluna 02: código do artigo
    %coluna 03: ano do artigo
    %coluna 04: fitness do artigo (lognormal com parâmetros de média e desvio do periódico)
    %coluna 05: fitness acumulado
    %coluna 06: quantidade de citações do artigo (poisson média ncit)
    %coluna 07: grau de entrada do artigo - total de citações recebidas
    %coluna 08: fitness ponderado por grau (fit*grau)
    %coluna 09: fitness ponderado acumulado
    %coluna 10: edição do periódico em que o artigo foi publicado

cit=zeros(sum(an(:,6)),8); %inicializa o arquivo com as citações
                           %sum(an(:,6)): total de citações dos artigos do ano
seq=0; %variável auxiliar para controlar a sequência de citações
for art=1:size(an,1)      %para cada artigo de an que servirá de SOURCE
    c=an(art,6);          %quantidade de citações do artigo
    %variáveis auxiliares para contagem de citações por tipo de estratégia
    %tipo1 - fitness ponderado por grau
    %tipo2 - apenas fitness
    %conta quantas citaçoes do tipo 1
    tipo1=0;
    for sel=1:c
        if rand(1)<0.5     %probabilidade de 50% de citação baseada em fitness ponderado
            tipo1=tipo1+1;
        end
    end
    tipo2=c-tipo1;
    indices=[];
    %----------------------------------------------------------------------
    %------------- Citações selecionadas apenas com base no fitness--------
    %----------------------------------------------------------------------
    f=rand(1)*a(end,5); %valor aleatório de fitness acumulado
    for j=1:tipo2
        f=rand(1)*a(end,5); %valor aleatório de fitness acumulado
        ind=find(a(:,5)>=f,1); %índice do elemento de a que corresponde ao valor sorteado de fitness
        while numel(find(indices==ind))~=0 %enquanto o índice sorteado já existir entre os sorteados
            f=rand(1)*a(end,5); %valor aleatório de fitness acumulado
            ind=find(a(:,5)>=f,1); %índice do elemento de a que corresponde ao valor sorteado de fitness
        end
        indices(j)=ind;
    end
    %-----------------------------------------------------------------------------------------------
    %------------- Citações selecionadas com base no fitness ponderado pelo grau de entrada --------
    %-----------------------------------------------------------------------------------------------
    for j=tipo2+1:tipo2+tipo1
        f=rand(1)*a(end,9); %valor aleatório de fitness ponderado acumulado
        ind=find(a(:,9)>=f,1); %índice do elemento de a que corresponde ao valor sorteado de fitness
        while numel(find(indices==ind))~=0 %enquanto o índice sorteado já existir entre os sorteados
            f=rand(1)*a(end,9); %valor aleatório de fitness acumulado
            ind=find(a(:,9)>=f,1); %índice do elemento de a que corresponde ao valor sorteado de fitness
        end
        indices(j)=ind;
    end
    
    citados=[a(indices,2) a(indices,3) a(indices,1) a(indices,10)];
    for j=1:c  %para todas as citações do artigo SOURCE
        cit(j+seq,1)=an(art,2);       %número do artigo SOURCE
        cit(j+seq,2)=an(art,3);       %ano do artigo SOURCE
        cit(j+seq,3)=an(art,1);       %periódico do artigo SOURCE
        cit(j+seq,4)=citados(j,1);   %número do artigo TARGET
        cit(j+seq,5)=citados(j,2);   %ano do artigo TARGET
        cit(j+seq,6)=citados(j,3);   %periódico do artigo TARGET
        cit(j+seq,7)=an(art,10);      %ediçao do periódico do artigo SOURCE
        cit(j+seq,8)=citados(j,4);   %ediçao do periódico do artigo TARGET
    end
    seq=seq+c;
%
%
%                    %serão feitas "tipo2" seleções apenas por fitness
%                    f=rand(1,tipo2)*a(end,5); %vetor com "tipo2" elementos de valores sorteados de fitness acum
%                                              %coluna 5 do arquivo a
%                    %cria o vetor "citados" com os números dos artigos TARGET correspondentes
%                    %     aos valores de ftness acumulado que foram gerados
%                    citados=zeros(tipo2,3);          %vetor com os dados dos artigos TARGET citados
%                    for j=1:tipo2
%                        indice=find(a(:,5)>=f(j),1); %indice do elemento correspondente ao fitness sorteado (col 5)
%                        citados(j,1)=a(indice,2);    %número do artigo TARGET citado
%                        citados(j,2)=a(indice,3);    %ano do artigo TARGET citado
%                        citados(j,3)=a(indice,1);    %periódico do artigo TARGET citado
%                    end
%                    %----------------------------------------------------------------------
%                    %retirar os artigos selecionados apenas por fitness repetidos do vetor "citados"
%                    semrep=citados;
%                    unicos=unique(semrep(:,1)); %lista ordenada de valores sem repetição
%                    n=histc(semrep(:,1),unicos);%lista com a contagem dos valores (histograma)
%                    valrep=unicos(n>1);    %lista com os valores repetidos
%                    qtdrep=n(find(n>1));   %lista com a quantidade de cada valor repetido
%                    nrepet=numel(valrep);  %quantidade de valores repetidos
%                    while nrepet~=0        %repetir enquanto houver valores repetidos
%                        for i=1:nrepet
%                            valor=valrep(i);                  %pega cada valor repetido
%                            indrep=find(semrep==valrep(i));   %lista de índices de cada valor repetido
%                            for t=2:qtdrep(i)                 %para todos as repetições exceto a primeira
%                                novofitacum=rand(1)*a(end,5); %sorteia um novo valor de fitness acumulado
%                                novoindice=find(a(:,5)>=novofitacum,1);
%                                novovalor=a(novoindice,2);    %código do artigo correspondente ao fitness
%                                novoano=a(novoindice,3);      %ano do artigo correspondente ao fitness
%                                novoperiodico=a(novoindice,1);%periódico do artigo correspondente ao fitness
%                                while novovalor==valor
%                                    novofitacum=rand(1)*a(end,5); %sorteia um novo valor de fitness acumulado
%                                    novoindice=find(a(:,5)>=novofitacum,1); %indice do elemento
%                                    novovalor=a(novoindice,2);    %artigo correspondente ao fitness
%                                    novoano=a(novoindice,3);      %ano do artigo correspondente ao fitness
%                                    novoperiodico=a(novoindice,1);%periódico do artigo correspondente ao fitness
%                                end
%                                semrep(indrep(t),1)=novovalor;     %coloca o novo valor no lugar do repetido
%                                semrep(indrep(t),2)=novoano;       %coloca o novo ano no lugar do repetido
%                            end
%                       end
%                        %prepara o vetor resultante para nova inspeção de repetições
%                        unicos=unique(semrep(:,1)); %lista ordenada de valores sem repetição
%                        n=histc(semrep(:,1),unicos);%lista com a contagem dos valores (histograma)
%                        valrep=unicos(n>1);         %lista com os valores repetidos
%                        qtdrep=n(find(n>1));        %lista com a quantidade de cada valor repetido
%                        nrepet=numel(valrep);       %quantidade de valores repetidos
%                    end 
%                    %------------salva as duplas SOURCE/TARGET no arquivo "cit"-------------------
%                    citados=semrep; %vetor com os artigos TARGET citados pelo SOURCE ativo selecionadas apenas por fitness
%                    for j=1:tipo2  %para todas as citações do artigo SOURCE
%                        cit(j+seq,1)=an(art,2);       %número do artigo SOURCE
%                        cit(j+seq,2)=an(art,3);       %ano do artigo SOURCE
%                        cit(j+seq,3)=an(art,1);       %periódico do artigo SOURCE
%                        cit(j+seq,4)=citados(j,1);   %número do artigo TARGET
%                        cit(j+seq,5)=citados(j,2);   %ano do artigo TARGET
%                        cit(j+seq,6)=citados(j,3);   %periódico do artigo TARGET
%                    end
%                    seq=seq+tipo2;
%                    %----------------------------------------------------------------------
%                    %------------- Citações selecionadas com base no fitness ponderado pelo grau de entrada --------
%                    %----------------------------------------------------------------------
%                    %serão feitas "tipo1" seleções por fitness ponderado por grau de entrada
%                    f=rand(1,tipo1)*a(end,9); %vetor com "tipo1" elementos de valores sorteados de fitness ponderado acum
%                                              %coluna 9 do arquivo a
%                    %cria o vetor "citados" com os números dos artigos TARGET correspondentes
%                    %     aos valores de fitness ponderado que foram gerados
%                    for j=1:tipo1
%                        indice=find(a(:,9)>=f(j),1); %indice do elemento correspondente ao fitness sorteado (col 9)
%                        citados(j,1)=a(indice,2);    %número do artigo TARGET citado
%                        citados(j,2)=a(indice,3);    %ano do artigo TARGET citado
%                        citados(j,3)=a(indice,1);    %periódico do artigo TARGET citado
%                    end
%                    %----------------------------------------------------------------------
%                    %retirar os artigos selecionados por fitness ponderado repetidos do vetor "citados"
%                    semrep=citados;
%                    unicos=unique(semrep(:,1)); %lista ordenada de valores sem repetição
%                    n=histc(semrep(:,1),unicos);%lista com a contagem dos valores (histograma)
%                    valrep=unicos(n>1);    %lista com os valores repetidos
%                    qtdrep=n(find(n>1));   %lista com a quantidade de cada valor repetido
%                    nrepet=numel(valrep);  %quantidade de valores repetidos
%                    while nrepet~=0        %repetir enquanto houver valores repetidos
%                        for i=1:nrepet
%                            valor=valrep(i);                  %pega cada valor repetido
%                            indrep=find(semrep==valrep(i));   %lista de índices de cada valor repetido
%                            for t=2:qtdrep(i)                 %para todos as repetições exceto a primeira
%                                novofitacum=rand(1)*a(end,9); %sorteia um novo valor de fitness ponderado
%                                novoindice=find(a(:,9)>=novofitacum,1);
%                                novovalor=a(novoindice,2);    %código do artigo correspondente ao fitness
%                                novoano=a(novoindice,3);      %ano do artigo correspondente ao fitness
%                                novoperiodico=a(novoindice,1);%periódico do artigo correspondente ao fitness
%                                while novovalor==valor
%                                    novofitacum=rand(1)*a(end,9); %sorteia um novo valor de fitness ponderado
%                                    novoindice=find(a(:,9)>=novofitacum,1); %indice do elemento
%                                    novovalor=a(novoindice,2);    %artigo correspondente ao fitness
%                                    novoano=a(novoindice,3);      %ano do artigo correspondente ao fitness
%                                    novoperiodico=a(novoindice,1);%periódico do artigo correspondente ao fitness
%                                end
%                                semrep(indrep(t),1)=novovalor;     %coloca o novo valor no lugar do repetido
%                                semrep(indrep(t),2)=novoano;       %coloca o novo ano no lugar do repetido
%                                semrep(indrep(t),3)=novoperiodico; %coloca o novo periódico no lugar do repetido
%                            end
%                        end
%                        %prepara o vetor resultante para nova inspeção de repetições
%                        unicos=unique(semrep(:,1)); %lista ordenada de valores sem repetição
%                        n=histc(semrep(:,1),unicos);%lista com a contagem dos valores (histograma)
%                        valrep=unicos(n>1);         %lista com os valores repetidos
%                        qtdrep=n(find(n>1));        %lista com a quantidade de cada valor repetido
%                        nrepet=numel(valrep);       %quantidade de valores repetidos
%                    end
%                    %------------salva as duplas SOURCE/TARGET no arquivo "cit"-------------------
%                    citados=semrep; %vetor com os artigos TARGET citados pelo SOURCE ativo selecionadas por fitness ponderado
%                    for j=1:tipo1  %para todas as citações do artigo SOURCE
%                        cit(j+seq,1)=an(art,2);       %número do artigo SOURCE
%                        cit(j+seq,2)=an(art,3);       %ano do artigo SOURCE
%                        cit(j+seq,3)=an(art,1);       %periódico do artigo SOURCE
%                        cit(j+seq,4)=citados(j,1);   %número do artigo TARGET
%                        cit(j+seq,5)=citados(j,2);   %ano do artigo TARGET
%                        cit(j+seq,6)=citados(j,3);   %periódico do artigo TARGET
%                    end
%                    seq=seq+tipo1;
end