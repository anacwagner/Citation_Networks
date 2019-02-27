function cit=p030geracitiniNEW(a,ano)
%gera "cit": conjunto de cita��es iniciais entre os artigos
%
%par�metros de entrada:
    %a: lista de arquivos
    %ano: ano dos artigos SOURCE -----VERIFICAR COMO VAI USAR

%considera apenas o valor de fitness de cada artigo para sele��o das cita��es
%estrat�gia de sele��o: 
    %100% apenas pelo fitness
    
%SA�DA
%formato de "cit"
    %coluna 01: c�digo do artigo SOURCE 
    %coluna 02: ano do artigo SOURCE
    %coluna 03: peri�dico do artigo SOURCE
    %coluna 04: c�digo do artigo TARGET
    %coluna 05: ano do artigo TARGET
    %coluna 06: peri�dico do artigo TARGET
    %coluna 07: m�s do artigo SOURCE (edi��o do peri�dico)
    %coluna 08: m�s do artigo TARGET (edi��o do peri�dico)

%ENTRADA
%formato de "a"
    %coluna 01: c�digo do peri�dico
    %coluna 02: c�digo do artigo
    %coluna 03: ano do artigo
    %coluna 04: fitness do artigo (lognormal com par�metros de m�dia e desvio do peri�dico)
    %coluna 05: fitness acumulado
    %coluna 06: quantidade de cita��es do artigo (poisson m�dia ncit)
    %coluna 07: grau de entrada do artigo - total de cita��es recebidas
    %coluna 08: fitness ponderado por grau (fit*grau)
    %coluna 09: fitness ponderado acumulado
    %coluna 10: m�s em que o artigo foi publicado (controle da edi��o)

cit=zeros(sum(a(:,6)),8);  %inicializa o arquivo com as cita��es
                           %sum(a(:,6)): total de cita��es dos artigos iniciais
                           
seq=0; %vari�vel auxiliar para controlar a sequ�ncia de cita��es


for art=1:size(a,1)         %para cada artigo de a que servir� de SOURCE
    
    c=a(art,6);             %quantidade de cita��es do artigo
    indices=[];
    
    %----------------------------------------------------------------------
    %------------- Cita��es selecionadas apenas com base no fitness--------
    %----------------------------------------------------------------------
    
    f=rand(1)*a(end,5); %valor aleat�rio de fitness acumulado
    
    for j=1:c
        f=rand(1)*a(end,5); %valor aleat�rio de fitness acumulado
        ind=find(a(:,5)>=f,1); %�ndice do elemento de a que corresponde ao valor sorteado de fitness
        while numel(find(indices==ind))~=0 %enquanto o �ndice sorteado j� existir entre os sorteados
            f=rand(1)*a(end,5); %valor aleat�rio de fitness acumulado
            ind=find(a(:,5)>=f,1); %�ndice do elemento de a que corresponde ao valor sorteado de fitness
        end
        indices(j)=ind;
    end
    citados=[a(indices,2) a(indices,3) a(indices,1) a(indices,10)];
    for j=1:c  %para todas as cita��es do artigo SOURCE
        cit(j+seq,1)=a(art,2);       %n�mero do artigo SOURCE
        cit(j+seq,2)=a(art,3);       %ano do artigo SOURCE
        cit(j+seq,3)=a(art,1);       %peri�dico do artigo SOURCE
        cit(j+seq,4)=citados(j,1);   %n�mero do artigo TARGET
        cit(j+seq,5)=citados(j,2);   %ano do artigo TARGET
        cit(j+seq,6)=citados(j,3);   %peri�dico do artigo TARGET
        cit(j+seq,7)=a(art,10);      %edi�ao do peri�dico do artigo SOURCE
        cit(j+seq,8)=citados(j,4);   %edi�ao do peri�dico do artigo TARGET
    end
    seq=seq+c;
end