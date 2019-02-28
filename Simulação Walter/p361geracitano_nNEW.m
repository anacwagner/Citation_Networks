function cit=p361geracitano_nNEW(a,an)
%gera o arquivo "cit" com as cita��es dos artigos de um ano 
%PROCESSO NORMAL: base completa dos artigos, cita��es dos artigos "normais"
%exatamente igual ao p060
%replicado por finalidade de organiza��o: separa��o do processo estrat�gico
%tem que rodar com an = artigos "normais" gerados no per�odo
%
%par�metros de entrada:
    %a: lista de artigos existentes at� o per�odo passado
    %an: lista de artigos publicados neste per�odo - LISTA DE ARTIGOS "NORMAIS"

%considera grau de entrada e valor de fitness de cada artigo para sele��o
%estrat�gia de sele��o: 
    %50% apenas pelo fitness
    %50% pelo fitness ponderado pelo grau de entrada

%SA�DA
%formato de "cit"
    %coluna 01: c�digo do artigo SOURCE
    %coluna 02: ano do artigo SOURCE
    %coluna 03: peri�dico do artigo SOURCE
    %coluna 04: c�digo do artigo TARGET
    %coluna 05: ano do artigo TARGET
    %coluna 06: peri�dico do artigo TARGET
    %coluna 07: edi��o do peri�dico do artigo SOURCE 
    %coluna 08: edi��o do peri�dico do artigo TARGET

%ENTRADA
%formato de "a" e "an"
    %coluna 01: c�digo do peri�dico
    %coluna 02: c�digo do artigo
    %coluna 03: ano do artigo
    %coluna 04: fitness do artigo (lognormal com par�metros de m�dia e desvio do peri�dico)
    %coluna 05: fitness acumulado
    %coluna 06: quantidade de cita��es do artigo (poisson m�dia ncit)
    %coluna 07: grau de entrada do artigo - total de cita��es recebidas
    %coluna 08: fitness ponderado por grau (fit*grau)
    %coluna 09: fitness ponderado acumulado
    %coluna 10: edi��o do peri�dico em que o artigo foi publicado

cit=zeros(sum(an(:,6)),8); %inicializa o arquivo com as cita��es
                           %sum(an(:,6)): total de cita��es dos artigos do ano
seq=0; %vari�vel auxiliar para controlar a sequ�ncia de cita��es
for art=1:size(an,1)      %para cada artigo de an que servir� de SOURCE
    c=an(art,6);          %quantidade de cita��es do artigo
    %vari�veis auxiliares para contagem de cita��es por tipo de estrat�gia
    %tipo1 - fitness ponderado por grau
    %tipo2 - apenas fitness
    %conta quantas cita�oes do tipo 1
    tipo1=0;
    for sel=1:c
        if rand(1)<0.5     %probabilidade de 50% de cita��o baseada em fitness ponderado
            tipo1=tipo1+1;
        end
    end
    tipo2=c-tipo1;
    indices=[];
    %----------------------------------------------------------------------
    %------------- Cita��es selecionadas apenas com base no fitness--------
    %----------------------------------------------------------------------
    f=rand(1)*a(end,5); %valor aleat�rio de fitness acumulado
    for j=1:tipo2
        f=rand(1)*a(end,5); %valor aleat�rio de fitness acumulado
        ind=find(a(:,5)>=f,1); %�ndice do elemento de a que corresponde ao valor sorteado de fitness
        while numel(find(indices==ind))~=0 %enquanto o �ndice sorteado j� existir entre os sorteados
            f=rand(1)*a(end,5); %valor aleat�rio de fitness acumulado
            ind=find(a(:,5)>=f,1); %�ndice do elemento de a que corresponde ao valor sorteado de fitness
        end
        indices(j)=ind;
    end
    %-----------------------------------------------------------------------------------------------
    %------------- Cita��es selecionadas com base no fitness ponderado pelo grau de entrada --------
    %-----------------------------------------------------------------------------------------------
    for j=tipo2+1:tipo2+tipo1
        f=rand(1)*a(end,9); %valor aleat�rio de fitness ponderado acumulado
        ind=find(a(:,9)>=f,1); %�ndice do elemento de a que corresponde ao valor sorteado de fitness
        while numel(find(indices==ind))~=0 %enquanto o �ndice sorteado j� existir entre os sorteados
            f=rand(1)*a(end,9); %valor aleat�rio de fitness acumulado
            ind=find(a(:,9)>=f,1); %�ndice do elemento de a que corresponde ao valor sorteado de fitness
        end
        indices(j)=ind;
    end
    
    citados=[a(indices,2) a(indices,3) a(indices,1) a(indices,10)];
    for j=1:c  %para todas as cita��es do artigo SOURCE
        cit(j+seq,1)=an(art,2);       %n�mero do artigo SOURCE
        cit(j+seq,2)=an(art,3);       %ano do artigo SOURCE
        cit(j+seq,3)=an(art,1);       %peri�dico do artigo SOURCE
        cit(j+seq,4)=citados(j,1);   %n�mero do artigo TARGET
        cit(j+seq,5)=citados(j,2);   %ano do artigo TARGET
        cit(j+seq,6)=citados(j,3);   %peri�dico do artigo TARGET
        cit(j+seq,7)=an(art,10);      %edi�ao do peri�dico do artigo SOURCE
        cit(j+seq,8)=citados(j,4);   %edi�ao do peri�dico do artigo TARGET
    end
    seq=seq+c;
%
%
%                    %ser�o feitas "tipo2" sele��es apenas por fitness
%                    f=rand(1,tipo2)*a(end,5); %vetor com "tipo2" elementos de valores sorteados de fitness acum
%                                              %coluna 5 do arquivo a
%                    %cria o vetor "citados" com os n�meros dos artigos TARGET correspondentes
%                    %     aos valores de ftness acumulado que foram gerados
%                    citados=zeros(tipo2,3);          %vetor com os dados dos artigos TARGET citados
%                    for j=1:tipo2
%                        indice=find(a(:,5)>=f(j),1); %indice do elemento correspondente ao fitness sorteado (col 5)
%                        citados(j,1)=a(indice,2);    %n�mero do artigo TARGET citado
%                        citados(j,2)=a(indice,3);    %ano do artigo TARGET citado
%                        citados(j,3)=a(indice,1);    %peri�dico do artigo TARGET citado
%                    end
%                    %----------------------------------------------------------------------
%                    %retirar os artigos selecionados apenas por fitness repetidos do vetor "citados"
%                    semrep=citados;
%                    unicos=unique(semrep(:,1)); %lista ordenada de valores sem repeti��o
%                    n=histc(semrep(:,1),unicos);%lista com a contagem dos valores (histograma)
%                    valrep=unicos(n>1);    %lista com os valores repetidos
%                    qtdrep=n(find(n>1));   %lista com a quantidade de cada valor repetido
%                    nrepet=numel(valrep);  %quantidade de valores repetidos
%                    while nrepet~=0        %repetir enquanto houver valores repetidos
%                        for i=1:nrepet
%                            valor=valrep(i);                  %pega cada valor repetido
%                            indrep=find(semrep==valrep(i));   %lista de �ndices de cada valor repetido
%                            for t=2:qtdrep(i)                 %para todos as repeti��es exceto a primeira
%                                novofitacum=rand(1)*a(end,5); %sorteia um novo valor de fitness acumulado
%                                novoindice=find(a(:,5)>=novofitacum,1);
%                                novovalor=a(novoindice,2);    %c�digo do artigo correspondente ao fitness
%                                novoano=a(novoindice,3);      %ano do artigo correspondente ao fitness
%                                novoperiodico=a(novoindice,1);%peri�dico do artigo correspondente ao fitness
%                                while novovalor==valor
%                                    novofitacum=rand(1)*a(end,5); %sorteia um novo valor de fitness acumulado
%                                    novoindice=find(a(:,5)>=novofitacum,1); %indice do elemento
%                                    novovalor=a(novoindice,2);    %artigo correspondente ao fitness
%                                    novoano=a(novoindice,3);      %ano do artigo correspondente ao fitness
%                                    novoperiodico=a(novoindice,1);%peri�dico do artigo correspondente ao fitness
%                                end
%                                semrep(indrep(t),1)=novovalor;     %coloca o novo valor no lugar do repetido
%                                semrep(indrep(t),2)=novoano;       %coloca o novo ano no lugar do repetido
%                            end
%                       end
%                        %prepara o vetor resultante para nova inspe��o de repeti��es
%                        unicos=unique(semrep(:,1)); %lista ordenada de valores sem repeti��o
%                        n=histc(semrep(:,1),unicos);%lista com a contagem dos valores (histograma)
%                        valrep=unicos(n>1);         %lista com os valores repetidos
%                        qtdrep=n(find(n>1));        %lista com a quantidade de cada valor repetido
%                        nrepet=numel(valrep);       %quantidade de valores repetidos
%                    end 
%                    %------------salva as duplas SOURCE/TARGET no arquivo "cit"-------------------
%                    citados=semrep; %vetor com os artigos TARGET citados pelo SOURCE ativo selecionadas apenas por fitness
%                    for j=1:tipo2  %para todas as cita��es do artigo SOURCE
%                        cit(j+seq,1)=an(art,2);       %n�mero do artigo SOURCE
%                        cit(j+seq,2)=an(art,3);       %ano do artigo SOURCE
%                        cit(j+seq,3)=an(art,1);       %peri�dico do artigo SOURCE
%                        cit(j+seq,4)=citados(j,1);   %n�mero do artigo TARGET
%                        cit(j+seq,5)=citados(j,2);   %ano do artigo TARGET
%                        cit(j+seq,6)=citados(j,3);   %peri�dico do artigo TARGET
%                    end
%                    seq=seq+tipo2;
%                    %----------------------------------------------------------------------
%                    %------------- Cita��es selecionadas com base no fitness ponderado pelo grau de entrada --------
%                    %----------------------------------------------------------------------
%                    %ser�o feitas "tipo1" sele��es por fitness ponderado por grau de entrada
%                    f=rand(1,tipo1)*a(end,9); %vetor com "tipo1" elementos de valores sorteados de fitness ponderado acum
%                                              %coluna 9 do arquivo a
%                    %cria o vetor "citados" com os n�meros dos artigos TARGET correspondentes
%                    %     aos valores de fitness ponderado que foram gerados
%                    for j=1:tipo1
%                        indice=find(a(:,9)>=f(j),1); %indice do elemento correspondente ao fitness sorteado (col 9)
%                        citados(j,1)=a(indice,2);    %n�mero do artigo TARGET citado
%                        citados(j,2)=a(indice,3);    %ano do artigo TARGET citado
%                        citados(j,3)=a(indice,1);    %peri�dico do artigo TARGET citado
%                    end
%                    %----------------------------------------------------------------------
%                    %retirar os artigos selecionados por fitness ponderado repetidos do vetor "citados"
%                    semrep=citados;
%                    unicos=unique(semrep(:,1)); %lista ordenada de valores sem repeti��o
%                    n=histc(semrep(:,1),unicos);%lista com a contagem dos valores (histograma)
%                    valrep=unicos(n>1);    %lista com os valores repetidos
%                    qtdrep=n(find(n>1));   %lista com a quantidade de cada valor repetido
%                    nrepet=numel(valrep);  %quantidade de valores repetidos
%                    while nrepet~=0        %repetir enquanto houver valores repetidos
%                        for i=1:nrepet
%                            valor=valrep(i);                  %pega cada valor repetido
%                            indrep=find(semrep==valrep(i));   %lista de �ndices de cada valor repetido
%                            for t=2:qtdrep(i)                 %para todos as repeti��es exceto a primeira
%                                novofitacum=rand(1)*a(end,9); %sorteia um novo valor de fitness ponderado
%                                novoindice=find(a(:,9)>=novofitacum,1);
%                                novovalor=a(novoindice,2);    %c�digo do artigo correspondente ao fitness
%                                novoano=a(novoindice,3);      %ano do artigo correspondente ao fitness
%                                novoperiodico=a(novoindice,1);%peri�dico do artigo correspondente ao fitness
%                                while novovalor==valor
%                                    novofitacum=rand(1)*a(end,9); %sorteia um novo valor de fitness ponderado
%                                    novoindice=find(a(:,9)>=novofitacum,1); %indice do elemento
%                                    novovalor=a(novoindice,2);    %artigo correspondente ao fitness
%                                    novoano=a(novoindice,3);      %ano do artigo correspondente ao fitness
%                                    novoperiodico=a(novoindice,1);%peri�dico do artigo correspondente ao fitness
%                                end
%                                semrep(indrep(t),1)=novovalor;     %coloca o novo valor no lugar do repetido
%                                semrep(indrep(t),2)=novoano;       %coloca o novo ano no lugar do repetido
%                                semrep(indrep(t),3)=novoperiodico; %coloca o novo peri�dico no lugar do repetido
%                            end
%                        end
%                        %prepara o vetor resultante para nova inspe��o de repeti��es
%                        unicos=unique(semrep(:,1)); %lista ordenada de valores sem repeti��o
%                        n=histc(semrep(:,1),unicos);%lista com a contagem dos valores (histograma)
%                        valrep=unicos(n>1);         %lista com os valores repetidos
%                        qtdrep=n(find(n>1));        %lista com a quantidade de cada valor repetido
%                        nrepet=numel(valrep);       %quantidade de valores repetidos
%                    end
%                    %------------salva as duplas SOURCE/TARGET no arquivo "cit"-------------------
%                    citados=semrep; %vetor com os artigos TARGET citados pelo SOURCE ativo selecionadas por fitness ponderado
%                    for j=1:tipo1  %para todas as cita��es do artigo SOURCE
%                        cit(j+seq,1)=an(art,2);       %n�mero do artigo SOURCE
%                        cit(j+seq,2)=an(art,3);       %ano do artigo SOURCE
%                        cit(j+seq,3)=an(art,1);       %peri�dico do artigo SOURCE
%                        cit(j+seq,4)=citados(j,1);   %n�mero do artigo TARGET
%                        cit(j+seq,5)=citados(j,2);   %ano do artigo TARGET
%                        cit(j+seq,6)=citados(j,3);   %peri�dico do artigo TARGET
%                    end
%                    seq=seq+tipo1;
end