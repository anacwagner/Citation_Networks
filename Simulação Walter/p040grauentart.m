function a=p040grauentart(a,cit,ano)
%calcula a coluna 07 de a: grau de entrada do artigo
%calcula a coluna 08 de a: fitness ponderado: fitness x grau de entrada
%calcula a coluna 09 de a: fitness ponderado acumulado
%
%par�metros de entrada:
    %a:   lista de arquivos
    %cit: lista de cita��es SOURCE-TARGET
    
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

%ENTRADA/SA�DA
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
    %coluna 10: edi��o do peri�dico em que o artigo foi publicado

%                %apaga as colunas 7, 8 e 9 existentes em a
%                a=a(:,1:6);
%                %coloca a lista em ordem crescente do c�digo do artigo
%                a=sortrows(a, [2]);
%                %C�lculo do Grau de entrada de cada artigo de a:
%                %conta quantas vezes cada artigo de a (coluna 2) apareceu como TARGET (coluna 4) na lista de cita��es
%                %insere coluna em a
%                a=[a histc(cit(:,4),a(:,2))];
%                %insere coluna em a com fitness ponderado pelo grau: grau de entrada X fitness do artigo
%                a=[a a(:,4).*a(:,7)];
%                %insere coluna em a com o fitness ponderado acumulado
%                a=[a cumsum(a(:,8))];
%

%multiplicador em fun��o da idade do artigo
%   artigos com mais de 5 anos ter�o multiplicador ZERO
%   artigos com 1 ano ter�o multiplicador UM
%mult=min(max((5-(ano-(a(:,3)+1)))/5,0),1); 
%atualiza a coluna de fitness com o multiplicador de idade do artigo
%apaga as colunas 5, 7, 8 e 9 existentes em a
%salva a coluna com a informa��o do m�s de publica��o
aux_a = a(:,end);
a=[a(:,1:3) a(:,4).*(min(max((5-(ano-(a(:,3)+1)))/5,0),1)) a(:,6)];
%coloca a lista em ordem crescente do c�digo do artigo
a=sortrows(a, [2]);
%insere a coluna com a fitness acumulada
a=[a(:,1:4) cumsum(a(:,4)) a(:,5)];
%C�lculo do Grau de entrada de cada artigo de a:
%conta quantas vezes cada artigo de a (coluna 2) apareceu como TARGET (coluna 4) na lista de cita��es
%insere coluna em a
a=[a histc(cit(:,4),a(:,2))];
%insere coluna em a com fitness ponderado pelo grau: grau de entrada X fitness do artigo
a=[a a(:,4).*a(:,7)];
%insere coluna em a com o fitness ponderado acumulado
a=[a cumsum(a(:,8))];
%reinsere coluna do m�s de publica��o
a=[a aux_a];