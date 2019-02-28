function [a,cit]=p370juntaart(a,an,cit,citn)
%anexa as listas de artigos e citações gerados no período
%às listas de artigos e citações acumuladas
%atualiza a coluna 5 com o valor de fitness acumulado

%
%TEM QUE ACERTAR PARA RECEBER OS ARTIGOS NORMAIS E OS ESTRATÉGICOS
%

%parâmetros de entrada:
    %a: lista de artigos existentes até o período passado
    %an: lista de artigos publicados neste período
    %cit: lista de citações existentes
    %citn: lista de citações dos artigos deste período
    
%SAÍDA/ENTRADA
%formato de "cit" e "citn"
    %coluna 01: código do artigo SOURCE
    %coluna 02: ano do artigo SOURCE
    %coluna 03: periódico do artigo SOURCE
    %coluna 04: código do artigo TARGET
    %coluna 05: ano do artigo TARGET
    %coluna 06: periódico do artigo TARGET
    %coluna 07: edição do periódico do artigo SOURCE 
    %coluna 08: edição do periódico do artigo TARGET

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
    
a=[a;an];
afim=[a(:,6:8)];
aed=[a(:,10)]; % salva a coluna com a edição dos periódicos
%substitui a coluna de valores acumulados de fitness (col 5) com os valores atuais
a=[a(:,1:4) cumsum(a(:,4)) afim];
a=[a cumsum(a(:,8)) aed];
cit=[cit;citn];