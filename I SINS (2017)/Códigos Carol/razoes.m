k = 2000; a = 0.4;
c = vectorC(k,a);

% Matriz de Probabilidades
P = [0.1 0.1; 0.1 0.1];             % Aleatorio
Pcom = [0.12 0.087; 0.087 0.1088];  % Comunidade
Pstr = [0.12 0.1; 0.087 0.1];       % Estrategico

% Vetores das Comunidades (Logico)
g1 = c==1;  % Grupo Estrategico 
g2 = c==2;  % Grupo Normal

% Matriz de Adjacencias
for k=1:3; S = {'', 'com', 'str'};
    eval(sprintf('A%s = testevetor(c,P%s,true);', char(cellstr(S(k))), char(cellstr(S(k)))))
    
    for i=1:2;
        for j=1:2;
        
        eval(sprintf('cont%d%d%s =sum(sum(A%s(g%d,g%d)));', i, j, char(cellstr(S(k))), char(cellstr(S(k))), j, i))
        
        end
    end  
end

% COMUNIDADE: R1>1, R2>1
R1com = (cont11com*cont12)/(cont11*cont12com);
R2com =(cont21*cont22com)/(cont22*cont21com);
% ESTRATEGICO: R1>1, R2~1
R1str = (cont11str*cont12)/(cont11*cont12str);
R2str=(cont21*cont22str)/(cont22*cont21str);
% Calculo das Razoes
R = table([R1com; R2com], [R1str; R2str], 'VariableNames',{'Comunidade'; 'Estrategico'}, 'RowNames', {'R1'; 'R2'});
display(R);
