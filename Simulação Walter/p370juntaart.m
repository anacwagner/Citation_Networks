function [a,cit]=p370juntaart(a,an,cit,citn)
%anexa as listas de artigos e cita��es gerados no per�odo
%�s listas de artigos e cita��es acumuladas
%atualiza a coluna 5 com o valor de fitness acumulado

%
%TEM QUE ACERTAR PARA RECEBER OS ARTIGOS NORMAIS E OS ESTRAT�GICOS
%

%par�metros de entrada:
    %a: lista de artigos existentes at� o per�odo passado
    %an: lista de artigos publicados neste per�odo
    %cit: lista de cita��es existentes
    %citn: lista de cita��es dos artigos deste per�odo
    
%SA�DA/ENTRADA
%formato de "cit" e "citn"
    %coluna 01: c�digo do artigo SOURCE
    %coluna 02: ano do artigo SOURCE
    %coluna 03: peri�dico do artigo SOURCE
    %coluna 04: c�digo do artigo TARGET
    %coluna 05: ano do artigo TARGET
    %coluna 06: peri�dico do artigo TARGET
    %coluna 07: edi��o do peri�dico do artigo SOURCE 
    %coluna 08: edi��o do peri�dico do artigo TARGET

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
    
a=[a;an];
afim=[a(:,6:8)];
aed=[a(:,10)]; % salva a coluna com a edi��o dos peri�dicos
%substitui a coluna de valores acumulados de fitness (col 5) com os valores atuais
a=[a(:,1:4) cumsum(a(:,4)) afim];
a=[a cumsum(a(:,8)) aed];
cit=[cit;citn];