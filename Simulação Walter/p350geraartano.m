function an=p350geraartano(p,ano,ncit,ult,mes)
%gera "an": o conjunto de artigos anuais para cada peri�dico
%exatamente igual ao p050
%replicado por finalidade de organiza��o: separa��o do processo estrat�gico
%
%par�metros de entrada:
    %p:   lista de arquivos
    %ano: ano da publica��o dos artigos gerados
    %ncit: m�dia do n�mero de cita��es dos artigos
    %ult: n�mero do �ltimo artigo gerado no per�odo anterior
    %            maneira mais segura de rodar esta fun��o
    %            faz ult=a(end,2) como par�metro de entrada

%SA�DA
%formato de "an": semelhante a "a" lista de artigos
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
    
    %Obs: as colunas 5, 7, 8 e 9 v�o ficar com zero neste programa, pois
    %elas s�o atualizadas posteriormente

%ENTRADA
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

%seleciona apenas os peri�dicos public�veis no m�s
%peri�dicos com 1 edi��o publicam no m�s 12
%peri�dicos com 2 edi��es publicam nos meses 6 e 12
%peri�dicos com 3 edi��es publicam nos meses 4, 8 e 12
%peri�dicos com 4 edi��es publicam nos meses 3, 6, 9 e 12
switch mes
    case 3
        p = p(p(:,12)== 4,:);
    case 4
        p = p(p(:,12)== 3,:);
    case 6
        p = p(p(:,12)== 2 | p(:,12)== 4,:);
    case 8
        p = p(p(:,12)== 3,:);
    case 9
        p = p(p(:,12)== 4,:);
end

n_artigos=ceil(sum(p(:,5))./sum(p(:,end))); %quantidade total de artigos que ser�o gerados por ano  
%divide pela quantidade de edi��es

num_art=0;
an=zeros(n_artigos,9);             %inicializa an
n=size(p,1);                       %quantidade de peri�dicos
for i=1:n                          %para todos os peri�dicos de p
    m=p(i,2);                      %m�dia de fitness do peri�dico i
    v=p(i,3)^2;                    %vari�ncia de fitness do peri�dico i
    mu = log(m^2 / sqrt(v+m^2));   %m�dia da distribui��o lognormal
    sigma = sqrt(log(v/m^2 + 1));  %vari�ncia da distribui��o lognormal
    num_art_p=p(i,5);              %quantidade anual de artigos do peri�dico (coluna 5)
    for j=num_art+1:num_art+num_art_p
        an(j,1)=i;                 %numero do peri�dico
        an(j,2)=j+ult;             %n�mero do artigo (sequencial com o �ltimo da base
        an(j,3)=ano;               %ano do artigo
        an(j,4)=lognrnd(mu,sigma); %fitness do artigo
        an(j,6)=poissrnd(ncit);    %quantidade de cita��es
        an(j,10)=mes;              %m�s da publica��o do artigo
    end%  
    num_art=num_art+num_art_p;
end