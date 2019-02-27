function a=p040grauentart(a,cit,ano)
%calcula a coluna 07 de a: grau de entrada do artigo
%calcula a coluna 08 de a: fitness ponderado: fitness x grau de entrada
%calcula a coluna 09 de a: fitness ponderado acumulado
%
%parâmetros de entrada:
    %a:   lista de arquivos
    %cit: lista de citações SOURCE-TARGET
    
%SAÍDA
%formato de "cit"
    %coluna 01: código do artigo SOURCE
    %coluna 02: ano do artigo SOURCE
    %coluna 03: periódico do artigo SOURCE
    %coluna 04: código do artigo TARGET
    %coluna 05: ano do artigo TARGET
    %coluna 06: periódico do artigo TARGET
    %coluna 07: edição do periódico do artigo SOURCE 
    %coluna 08: edição do periódico do artigo TARGET

%ENTRADA/SAÍDA
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
    %coluna 10: edição do periódico em que o artigo foi publicado

%                %apaga as colunas 7, 8 e 9 existentes em a
%                a=a(:,1:6);
%                %coloca a lista em ordem crescente do código do artigo
%                a=sortrows(a, [2]);
%                %Cálculo do Grau de entrada de cada artigo de a:
%                %conta quantas vezes cada artigo de a (coluna 2) apareceu como TARGET (coluna 4) na lista de citações
%                %insere coluna em a
%                a=[a histc(cit(:,4),a(:,2))];
%                %insere coluna em a com fitness ponderado pelo grau: grau de entrada X fitness do artigo
%                a=[a a(:,4).*a(:,7)];
%                %insere coluna em a com o fitness ponderado acumulado
%                a=[a cumsum(a(:,8))];
%

%multiplicador em função da idade do artigo
%   artigos com mais de 5 anos terão multiplicador ZERO
%   artigos com 1 ano terão multiplicador UM
%mult=min(max((5-(ano-(a(:,3)+1)))/5,0),1); 
%atualiza a coluna de fitness com o multiplicador de idade do artigo
%apaga as colunas 5, 7, 8 e 9 existentes em a
%salva a coluna com a informação do mês de publicação
aux_a = a(:,end);
a=[a(:,1:3) a(:,4).*(min(max((5-(ano-(a(:,3)+1)))/5,0),1)) a(:,6)];
%coloca a lista em ordem crescente do código do artigo
a=sortrows(a, [2]);
%insere a coluna com a fitness acumulada
a=[a(:,1:4) cumsum(a(:,4)) a(:,5)];
%Cálculo do Grau de entrada de cada artigo de a:
%conta quantas vezes cada artigo de a (coluna 2) apareceu como TARGET (coluna 4) na lista de citações
%insere coluna em a
a=[a histc(cit(:,4),a(:,2))];
%insere coluna em a com fitness ponderado pelo grau: grau de entrada X fitness do artigo
a=[a a(:,4).*a(:,7)];
%insere coluna em a com o fitness ponderado acumulado
a=[a cumsum(a(:,8))];
%reinsere coluna do mês de publicação
a=[a aux_a];