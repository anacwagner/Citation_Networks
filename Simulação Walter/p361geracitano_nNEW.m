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
    %coluna 07: mês do artigo SOURCE (edição do periódico)
    %coluna 08: mês do artigo TARGET (edição do periódico)

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
    %coluna 10: mês em que o artigo foi publicado (controle da edição)

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
end
