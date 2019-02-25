function [pg,pa,pf,pif]=p015geraindper(p)
%gera os arquivos para guardar os indicadores dos peri�dicos
%pg:  grau de entrada
%pa:  quantidade de artigos
%pf:  fitness m�dio dos artigos publicados
%pif: fator de impacto dos peri�dicos
%Formato de "pg": para cada peri�dico, s�o gerados blocos de informa��es por ano
    %coluna 01: c�digo do peri�dico
    %coluna (ano*3)+2: Grau de entrada TOTAL at� o ano
    %coluna (ano*3)+3: Grau de entrada DOIS ANOS 
            %quantas cita��es o peri�dico recebeu de artigos publicados nos DOIS �ltimos anos
    %coluna (ano*3)+4: Grau de entrada CINCO ANOS
            %quantas cita��es o peri�dico recebeu de artigos publicados nos CINCO �ltimos anos

%Formato de "pa": para cada peri�dico, s�o gerados blocos de informa��es por ano
    %coluna 01: c�digo do peri�dico
    %coluna (ano)+2: quantidade de artigos publicados no ano

%Formato de "pf": para cada peri�dico, s�o gerados blocos de informa��es por ano
    %coluna 01: c�digo do peri�dico
    %coluna (ano)+2: fitness m�dio dos artigos publicados no ano

%Formato de "pif": para cada peri�dico, s�o gerados blocos de infornMma��es por ano
    %coluna 01: c�digo do peri�dico
    %coluna (ano*3)+2: FI total at� o ano: quantidade total de cita��es at� o ano dividido pelo total de artigos at� o ano
    %coluna (ano*3)+3: FI-2 no ano: quantidade de cita��es recebidas de artigos dos dois �ltimos anos dividido pela quantidade de artigos publicados no ano 
    %coluna (ano*3)+4: FI-5 no ano: quantidade de cita��es recebidas de artigos dos cinco �ltimos anos dividido pela quantidade de artigos publicados no ano
    
%inicializa os arquivos apenas com o c�digo do peri�dico
pg=p(:,1);  %informa��es de grau de entrada dos peri�dicos
pa=p(:,1);  %informa��es de n�mero de artigos
pf=p(:,1);  %informa��es de fitness dos artigos publicados
pif=p(:,1); %informa��es de fator de impacto dos peri�dicos