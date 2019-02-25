function [pg,pa,pf,pif]=p015geraindper(p)
%gera os arquivos para guardar os indicadores dos periódicos
%pg:  grau de entrada
%pa:  quantidade de artigos
%pf:  fitness médio dos artigos publicados
%pif: fator de impacto dos periódicos
%Formato de "pg": para cada periódico, são gerados blocos de informações por ano
    %coluna 01: código do periódico
    %coluna (ano*3)+2: Grau de entrada TOTAL até o ano
    %coluna (ano*3)+3: Grau de entrada DOIS ANOS 
            %quantas citações o periódico recebeu de artigos publicados nos DOIS últimos anos
    %coluna (ano*3)+4: Grau de entrada CINCO ANOS
            %quantas citações o periódico recebeu de artigos publicados nos CINCO últimos anos

%Formato de "pa": para cada periódico, são gerados blocos de informações por ano
    %coluna 01: código do periódico
    %coluna (ano)+2: quantidade de artigos publicados no ano

%Formato de "pf": para cada periódico, são gerados blocos de informações por ano
    %coluna 01: código do periódico
    %coluna (ano)+2: fitness médio dos artigos publicados no ano

%Formato de "pif": para cada periódico, são gerados blocos de infornMmações por ano
    %coluna 01: código do periódico
    %coluna (ano*3)+2: FI total até o ano: quantidade total de citações até o ano dividido pelo total de artigos até o ano
    %coluna (ano*3)+3: FI-2 no ano: quantidade de citações recebidas de artigos dos dois últimos anos dividido pela quantidade de artigos publicados no ano 
    %coluna (ano*3)+4: FI-5 no ano: quantidade de citações recebidas de artigos dos cinco últimos anos dividido pela quantidade de artigos publicados no ano
    
%inicializa os arquivos apenas com o código do periódico
pg=p(:,1);  %informações de grau de entrada dos periódicos
pa=p(:,1);  %informações de número de artigos
pf=p(:,1);  %informações de fitness dos artigos publicados
pif=p(:,1); %informações de fator de impacto dos periódicos