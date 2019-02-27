function a=p020geraartini(p,ncit)
%gera "a": o conjunto inicial de artigos para cada peri�dico
%
%par�metros de entrada:
    %p: lista de peri�dicos
    %ncit: m�dia do n�mero de cita��es dos artigos

%SA�DA
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
 
ano=0;
mes=12;
num_art=0;
n_artigos=sum(p(:,4)); %quantidade total de artigos que ser�o gerados
a=zeros(n_artigos,9);  %inicializa a
n=size(p,1);           %quantidade de peri�dicos

for i=1:n
    m=p(i,2);                     %m�dia de fitness do peri�dico i
    v=p(i,3)^2;                   %vari�ncia de fitness do peri�dico i
    mu = log(m^2 / sqrt(v+m^2));  %m�dia da distribui��o lognormal
    sigma = sqrt(log(v/m^2 + 1)); %vari�ncia da distribui��o lognormal
    num_art_p=p(i,4);             %quantidade inicial de artigos do peri�dico
    
    for j=num_art+1:num_art+num_art_p
        a(j,1)=i;                 %numero do peri�dico
        a(j,2)=j;                 %n�mero do artigo (sequencial com o �ltimo da base
        a(j,3)=ano;               %ano do artigo
        a(j,4)=lognrnd(mu,sigma); %fitness do artigo
        a(j,5)=poissrnd(ncit);    %quantidade de cita��es
        a(j,9)=mes;               %m�s da publica��o do artigo
    end
    num_art=num_art+num_art_p;
end

%insere a coluna 9 de valores acumulados de fitness na 5� coluna
a=[a(:,1:4) cumsum(a(:,4)) a(:,5:9)];

% insere a coluna 10 com a edi��o (m�s) do peri�dico em que o artigo foi publicado 
%a=[a ones(n_artigos,1)*mes];