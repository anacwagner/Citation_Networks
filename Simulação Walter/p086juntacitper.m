function citper=p086juntacitper(citper,citpern)
%anexa a listas cita��es entre peri�dicos geradas no per�odo
%� lista de cita��es entre peri�dicos acumuladas
%
%par�metros de entrada:
    %citper: lista de cita��es entre peri�dicos existentes
    %citpern: lista de cita��es entre peri�dicos deste per�odo

%SA�DA/ENTRADA
%formato de "citper" e "citpern"
    %coluna 01: ano do artigo publicado (SOURCE)
    %coluna 02: ano do artigo citado (TARGET)
    %coluna 03: c�digo do peri�dico SOURCE
    %coluna 04: c�digo do peri�dico TARGET
    %coluna 05: quantidade de cita��es entre os peri�dicos

citper=[citper;citpern];