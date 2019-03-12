function R = calcR_ESTR(A, Astr, pstr)

    c = ones(400,1)*2;
    c(pstr) = 1;    % Periodicos Estrategicos
    
    % Vetores das Comunidades (Logico)
    g1 = c==1; g1 = g1'; % Grupo Estrategico 
    g2 = c==2; g2 = g2'; % Grupo Normal
    
    for k=1:2; S = {'', 'str'};
        for i=1:2;
            for j=1:2;

            eval(sprintf('cont%d%d%s =sum(sum(A%s(g%d,g%d)));', i, j, char(cellstr(S(k))), char(cellstr(S(k))), j, i))

            end
        end  
    end
  
    % ESTRATEGICO: R1>1, R2~1
    R1str = (cont11str*cont12)/(cont11*cont12str);
    R2str = (cont21*cont22str)/(cont22*cont21str);
    
    % Calculo das Razoes
    R = table([R1str; R2str], 'RowNames', {'R1'; 'R2'});
    
end
    