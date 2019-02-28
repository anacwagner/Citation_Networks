function an=p350geraartano(p,ano,ncit,ult,mes)
%gera "an": o conjunto de artigos anuais para cada periódico
%exatamente igual ao p050
%replicado por finalidade de organização: separação do processo estratégico
%
%parâmetros de entrada:
    %p:   lista de arquivos
    %ano: ano da publicação dos artigos gerados
    %ncit: média do número de citações dos artigos
    %ult: número do último artigo gerado no período anterior
    %            maneira mais segura de rodar esta função
    %            faz ult=a(end,2) como parâmetro de entrada

%SAÍDA
%formato de "an": semelhante a "a" lista de artigos
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
    
    %Obs: as colunas 5, 7, 8 e 9 vão ficar com zero neste programa, pois
    %elas são atualizadas posteriormente

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

%seleciona apenas os periódicos publicáveis no mês
%periódicos com 1 edição publicam no mês 12
%periódicos com 2 edições publicam nos meses 6 e 12
%periódicos com 3 edições publicam nos meses 4, 8 e 12
%periódicos com 4 edições publicam nos meses 3, 6, 9 e 12
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

n_artigos=ceil(sum(p(:,5))./sum(p(:,end))); %quantidade total de artigos que serão gerados por ano  
%divide pela quantidade de edições

num_art=0;
an=zeros(n_artigos,9);             %inicializa an
n=size(p,1);                       %quantidade de periódicos
for i=1:n                          %para todos os periódicos de p
    m=p(i,2);                      %média de fitness do periódico i
    v=p(i,3)^2;                    %variância de fitness do periódico i
    mu = log(m^2 / sqrt(v+m^2));   %média da distribuição lognormal
    sigma = sqrt(log(v/m^2 + 1));  %variância da distribuição lognormal
    num_art_p=p(i,5);              %quantidade anual de artigos do periódico (coluna 5)
    for j=num_art+1:num_art+num_art_p
        an(j,1)=i;                 %numero do periódico
        an(j,2)=j+ult;             %número do artigo (sequencial com o último da base
        an(j,3)=ano;               %ano do artigo
        an(j,4)=lognrnd(mu,sigma); %fitness do artigo
        an(j,6)=poissrnd(ncit);    %quantidade de citações
        an(j,10)=mes;              %mês da publicação do artigo
    end%  
    num_art=num_art+num_art_p;
end