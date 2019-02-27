function citper_count=p083sumcitper(citn)
%gera o arquivo "citper" com as totaliza��o das cita��es entre peri�dicos de um ano
%
%par�metros de entrada:
    %citn: lista de cita��es dos artigos deste per�odo

%SA�DA
%formato de "citper_count"
    %coluna 01: ano do artigo publicado (SOURCE)
    %coluna 02: ano do artigo citado (TARGET)
    %coluna 03: c�digo do peri�dico SOURCE
    %coluna 04: c�digo do peri�dico TARGET
    %coluna 05: quantidade de cita��es entre os peri�dicos

%ENTRADA
%formato de "citn"
    %coluna 01: c�digo do artigo SOURCE
    %coluna 02: ano do artigo SOURCE
    %coluna 03: peri�dico do artigo SOURCE
    %coluna 04: c�digo do artigo TARGET
    %coluna 05: ano do artigo TARGET
    %coluna 06: peri�dico do artigo TARGET
    %coluna 07: edi��o do peri�dico do artigo SOURCE 
    %coluna 08: edi��o do peri�dico do artigo TARGET

%monta a lista total de cita��es entre peri�dicos a partir das cita��es entre artigos
%classifica por ano/SOURCE/TARGET
%gera a lista com as combina��es SOURCE/TARGET sem repeti��o
%gera os �ndices na lista das �ltimas linhas repetidas
%citper_total=[citn(:,2) citn(:,3) citn(:,6)]
%citper_sorted=sortrows([citn(:,2) citn(:,3) citn(:,6)], [1 2 3]);
%[citper_unicos,ia,ic]=unique(citper_sorted,'rows','last');

[citper_count,ia,ic]=unique(sortrows([citn(:,2) citn(:,5) citn(:,3) citn(:,6)], [1 2 3 4]),'rows','last');

%inclui a coluna com a contagem de ocorr�ncias de cada linha
%o �ndice "ia" faz uma contagem acumulada com o n�mero do �ndice dentro da lista
%o comando dif(ia) calcula a diferen�a entre um elemento de "ia" e o anterior (a partir do segundo)
citper_count=[citper_count [ia(1); diff(ia)]];