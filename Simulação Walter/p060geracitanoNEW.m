function cit=p060geracitanoNEW(a,an)
%gera o arquivo "cit" com as cita��es dos artigos de um ano
%
%par�metros de entrada:
    %a: lista de artigos existentes at� o per�odo passado
    %an: lista de artigos publicados neste per�odo

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
end