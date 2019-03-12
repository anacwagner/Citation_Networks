function R = calcR_BASE(A, Acom, pstr)

    c = ones(400,1)*2;
    c(pstr) = 1;    % Periodicos Estrategicos
    
    % Vetores das Comunidades (Logico)
    g1 = c==1; g1 = g1'; % Grupo Estrategico 
    g2 = c==2; g2 = g2'; % Grupo Normal
    
    for k=1:2; S = {'', 'com'};
        for i=1:2;
            for j=1:2;

            eval(sprintf('cont%d%d%s =sum(sum(A%s(g%d,g%d)));', i, j, char(cellstr(S(k))), char(cellstr(S(k))), j, i))

            end
        end  
    end
  
    % COMUNIDADE: R1>1, R2>1
    R1com = (cont11com*cont12)/(cont11*cont12com);
    R2com =(cont21*cont22com)/(cont22*cont21com);
    
    % Calculo das Razoes
    R = table([R1com; R2com], 'RowNames', {'R1'; 'R2'});
    
end
    