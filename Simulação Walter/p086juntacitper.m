function citper=p086juntacitper(citper,citpern)
%anexa a listas citações entre periódicos geradas no período
%à lista de citações entre periódicos acumuladas
%
%parâmetros de entrada:
    %citper: lista de citações entre periódicos existentes
    %citpern: lista de citações entre periódicos deste período

%SAÍDA/ENTRADA
%formato de "citper" e "citpern"
    %coluna 01: ano do artigo publicado (SOURCE)
    %coluna 02: ano do artigo citado (TARGET)
    %coluna 03: código do periódico SOURCE
    %coluna 04: código do periódico TARGET
    %coluna 05: quantidade de citações entre os periódicos

citper=[citper;citpern];