function citper_count=p083sumcitper(citn)
%gera o arquivo "citper" com as totalização das citações entre periódicos de um ano
%
%parâmetros de entrada:
    %citn: lista de citações dos artigos deste período

%SAÍDA
%formato de "citper_count"
    %coluna 01: ano do artigo publicado (SOURCE)
    %coluna 02: ano do artigo citado (TARGET)
    %coluna 03: código do periódico SOURCE
    %coluna 04: código do periódico TARGET
    %coluna 05: quantidade de citações entre os periódicos

%ENTRADA
%formato de "citn"
    %coluna 01: código do artigo SOURCE
    %coluna 02: ano do artigo SOURCE
    %coluna 03: periódico do artigo SOURCE
    %coluna 04: código do artigo TARGET
    %coluna 05: ano do artigo TARGET
    %coluna 06: periódico do artigo TARGET
    %coluna 07: edição do periódico do artigo SOURCE 
    %coluna 08: edição do periódico do artigo TARGET

%monta a lista total de citações entre periódicos a partir das citações entre artigos
%classifica por ano/SOURCE/TARGET
%gera a lista com as combinações SOURCE/TARGET sem repetição
%gera os índices na lista das últimas linhas repetidas
%citper_total=[citn(:,2) citn(:,3) citn(:,6)]
%citper_sorted=sortrows([citn(:,2) citn(:,3) citn(:,6)], [1 2 3]);
%[citper_unicos,ia,ic]=unique(citper_sorted,'rows','last');

[citper_count,ia,ic]=unique(sortrows([citn(:,2) citn(:,5) citn(:,3) citn(:,6)], [1 2 3 4]),'rows','last');

%inclui a coluna com a contagem de ocorrências de cada linha
%o índice "ia" faz uma contagem acumulada com o número do índice dentro da lista
%o comando dif(ia) calcula a diferença entre um elemento de "ia" e o anterior (a partir do segundo)
citper_count=[citper_count [ia(1); diff(ia)]];