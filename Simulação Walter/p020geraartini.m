function a=p020geraartini(p,ncit)
%gera "a": o conjunto inicial de artigos para cada periódico
%
%parâmetros de entrada:
    %p: lista de periódicos
    %ncit: média do número de citações dos artigos

%SAÍDA
%formato de "a"
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

%ENTRADA
%formato de "p"
    %coluna 01: código do periódico (sequencial)
    %coluna 02: média de fitness dos artigos do periódico (uniforme/range 1:f)
    %coluna 03: dp de fitness dos artigos do periódico: função da média de fitness: dp=m/2
    %coluna 04: número inicial de artigos (poisson média na_i)
    %coluna 05: número de artigos por ano (poisson média na_a)
    %coluna 06: fitness médio real TOTAL
    %coluna 07: fitness médio real DOIS ANOS
    %coluna 08: fitness médio real CINCO ANOS
    %coluna 09: grau de entrada TOTAL
    %coluna 10: grau de entrada DOIS ANOS
    %coluna 11: grau de entrada CINCO ANOS
    %coluna 12: número de edições ao ano do periódico (aleatório: 1, 2, 3, 4)
 
ano=0;
mes=12;
num_art=0;
n_artigos=sum(p(:,4)); %quantidade total de artigos que serão gerados
a=zeros(n_artigos,9);  %inicializa a
n=size(p,1);           %quantidade de periódicos

for i=1:n
    m=p(i,2);                     %média de fitness do periódico i
    v=p(i,3)^2;                   %variância de fitness do periódico i
    mu = log(m^2 / sqrt(v+m^2));  %média da distribuição lognormal
    sigma = sqrt(log(v/m^2 + 1)); %variância da distribuição lognormal
    num_art_p=p(i,4);             %quantidade inicial de artigos do periódico
    
    for j=num_art+1:num_art+num_art_p
        a(j,1)=i;                 %numero do periódico
        a(j,2)=j;                 %número do artigo (sequencial com o último da base
        a(j,3)=ano;               %ano do artigo
        a(j,4)=lognrnd(mu,sigma); %fitness do artigo
        a(j,5)=poissrnd(ncit);    %quantidade de citações
        a(j,9)=mes;               %mês da publicação do artigo
    end
    num_art=num_art+num_art_p;
end

%insere a coluna 9 de valores acumulados de fitness na 5ª coluna
a=[a(:,1:4) cumsum(a(:,4)) a(:,5:9)];
