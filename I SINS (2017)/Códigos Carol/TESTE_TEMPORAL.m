% Rodar na pasta 'Simulacao_Completa', onde tem os ambientes de simulacao
% salvos.

clear all; clc;

razoes = [];

%n = 400;                % Quantidade de periodicos 

ano_antes_estrat = 10;  % Antes do Comportamento Estrategico 

% (1) Escolha dos parametros
per = 2;        % Tres parametros de PERIODICOS (2, 5, 9)
art = 1;        % Tres parametros de ARTIGOS (0*, 1, 5, 9)
cit = 1;        % Tres parametros de CITACOES (0*, 1, 5, 9)

rep = 1;        % Tres parametros de REPETICOES (1, 2, 3)    

op = 'BASE';    % ESTR - estrategicos / BASE - comunidade

tipo = [op '_p0' num2str(per) 'a0' num2str(art) 'c0' num2str(cit)];

% (2) EXTRACAO DA VAR_CITPER E VAR_PE0%D

    file = ['amb10_B1_' tipo '_VM167_' num2str(rep)];

    % Simulacoes Walter
    per = 2;
    load('amb10_B1_BASE__VM169_1W', sprintf('var_pe0%d',per), 'var_citper');
    %load('amb10_B1_ESTR_p02a01c01_VM167_1W', sprintf('var_pe0%d',per), 'var_citper');

    % Simucoes Carol
    %load([file '.mat'] , sprintf('var_pe0%d',per), 'var_citper');

    eval(sprintf('pstr = var_pe0%d;',per))

for ano_depois_estrat = 1:30; % Depois do Comportamento Estrategico
    
    % (3) CALCULA A MATRIZ DE ADJACENCIAS 
    % DOS ANOS ANTES E DEPOIS DO COMPORTAMENTO ESTRATEGICO 

        A1 = MontaAdjacencias(var_citper, ano_antes_estrat);
        A2 = MontaAdjacencias(var_citper, ano_depois_estrat);

    % (4) CALCULA AS RAZOES

    switch op

        case 'BASE' % COMUNIDADE
            R = calcR_BASE(A1, A2, pstr);
            razoes(ano_depois_estrat,1:2) = R.Var1';

        case 'ESTR' % ESTRATEGICO
            R = calcR_ESTR(A1, A2, pstr);
            razoes(ano_depois_estrat,1:2) = R.Var1';
    end
end

%% PLOTA A ANALISE TEMPORAL DOS R
figure(1);
if op == 'ESTR'
    title(['Values of R_1 and R_2 for ' sprintf('0.%d', per) '% of strategic nodes']);
else
    title(['Values of R_1 and R_2 without strategic nodes']);
end

hold on;

plot(razoes(:,1), '-', 'LineWidth', 1.5, 'color', 'Blue', 'DisplayName', 'R_1');
plot(razoes(:,2), '-', 'LineWidth', 1.5, 'color', 'Red', 'DisplayName', 'R_2');
legend('Show', 'Location','EastOutside');

plot(1:30,ones(30,1), '--', 'LineWidth', 1.5, 'color', 'black');

Anos = {'Year 10','Year 20','Year 30'};
xlim([1, 31]);
ylim([0.5 2.6]);
ax = gca;
ax.XTick = [10 20 30];
ax.XTickLabels = Anos;
grid on;