% Extrai  e salva a matriz de adjacencias das simulacoes
% Rodar na pasta 'Simulacao_Completa', onde tem os ambientes de simulacao
% salvos.

%n = 400;                % Quantidade de periodicos 

% Anos Extraidos
ano_antes_estrat = 10;  % Antes do Comportamento Estrat?gico 
ano_depois_estrat = 20; % Depois do Comportamento Estrat?gico

% (1) Escolha das Propbabilidades do COMPORTAMENTO ESTRATEGICO
per = 2;        % Tres parametros de PERIODICOS (2, 5, 9)
art = 1;        % Tres parametros de ARTIGOS (1, 5, 9)
cit = 1;        % Tres parametros de CITACOES (1, 5, 9)

tipo = ['ESTR_p0' num2str(per) 'a0' num2str(art) 'c0' num2str(cit)];

% (2) EXTRACAO DA VAR_CITPER

    rep = 1;        % Tres parametros de REPETICOES (1, 2, 3)
    
    file = ['amb10_B1_' tipo '_VM167_' num2str(rep)];
    load([file '.mat'] , sprintf('var_pe0%d',per), 'var_citper');
    
% (3) CALCULA A MATRIZ DE ADJACENCIAS 
%DOS ANOS ANTES E DEPOIS DO COMPORTAMENTO ESTRATEGICO 
    
    A = MontaAdjacencias(var_citper, ano_antes_estrat);
    Astr = MontaAdjacencias(var_citper, ano_depois_estrat);
   
% (4) SALVANDO
    
     eval(sprintf('pstr = var_pe0%d;',per))
     file_name = sprintf(['MatrizAdj_' tipo '_rep' num2str(rep)]);
     %save(file_name, 'A0', 'A1', 'A2', sprintf('var_pe0%d',per));
     save(file_name, 'A', 'Astr', 'pstr');
    
clear all; clc;
        
