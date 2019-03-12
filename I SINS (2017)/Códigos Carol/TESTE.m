% Rodar na pasta 'Simulacao_Completa', onde tem os ambientes de simulacao
% salvos.

clear all; clc;

%n = 400;                % Quantidade de periodicos 

% Anos de Teste
ano_antes_estrat = 10;  % Antes do Comportamento Estrategico 
ano_depois_estrat = 20; % Depois do Comportamento Estrategico

% (1) Escolha dos parametros
per = 2;        % Tres parametros de PERIODICOS (2, 5, 9)
art = 1;        % Tres parametros de ARTIGOS (0*, 1, 5, 9)
cit = 1;        % Tres parametros de CITACOES (0*, 1, 5, 9)

rep = 1;        % Tres parametros de REPETICOES (1, 2, 3)    

op = 'ESTR';    % ESTR - estrategicos / BASE - comunidade

tipo = [op '_p0' num2str(per) 'a0' num2str(art) 'c0' num2str(cit)];

% (2) EXTRACAO DA VAR_CITPER E VAR_PE0%D
    
    file = ['amb10_B1_' tipo '_VM167_' num2str(rep)];
    
    % Simulacoes Walter
    per = 2;
    %load('amb10_B1_BASE__VM169_1W', sprintf('var_pe0%d',per), 'var_citper');
    load('amb10_B1_ESTR_p02a01c01_VM167_1W', sprintf('var_pe0%d',per), 'var_citper');
    
    % Simucoes Carol
    %load([file '.mat'] , sprintf('var_pe0%d',per), 'var_citper');
    
    eval(sprintf('pstr = var_pe0%d;',per))

% (3) CALCULA A MATRIZ DE ADJACENCIAS 
% DOS ANOS ANTES E DEPOIS DO COMPORTAMENTO ESTRATEGICO 
    
    A1 = MontaAdjacencias(var_citper, ano_antes_estrat);
    A2 = MontaAdjacencias(var_citper, ano_depois_estrat);
    
% (4) SALVANDO OS RESULTADOS EXTRAIDOS
    
%      file_name = sprintf(['MatrizAdj_' tipo '_rep' num2str(rep)]);
%      save(file_name, 'A', 'A1');    
    
% (5) CALCULA AS RAZOES

switch op
    
    case 'BASE' % COMUNIDADE
       
        R = calcR_BASE(A1, A2, pstr);
        
    case 'ESTR' % ESTRATEGICO
        
        R = calcR_ESTR(A1, A2, pstr);
end

display(R);