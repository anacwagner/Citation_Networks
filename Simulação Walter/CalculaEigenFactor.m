eigenfactors10 = zeros(400, 3);
S={'var_citper_b1' 'var_citper_b2' 'var_citper_b3'};
for k=1:3
    disp(k)
    lista = eval(S{k});

    A = MontaAdjacencias(lista, 10);

    H = diag(1./sum(A))*A;
    G = H*0.85+(ones(400,400)/400)*0.15;
    [V, D] = eig(G);
    eigenfactors10(:,k) = V(:,1)/sum(V(:,1));  
end
eigenfactors20 = zeros(400, 3);
S={'var_citper_b1' 'var_citper_b2' 'var_citper_b3'};
for k=1:3
    disp(k)
    lista = eval(S{k});

    A = MontaAdjacencias(lista, 20);

    H = diag(1./sum(A))*A;
    G = H*0.85+(ones(400,400)/400)*0.15;
    [V, D] = eig(G);
    eigenfactors20(:,k) = V(:,1)/sum(V(:,1));  
end
eigenfactors30 = zeros(400, 3);
S={'var_citper_b1' 'var_citper_b2' 'var_citper_b3'};
for k=1:3
    disp(k)
    lista = eval(S{k});

    A = MontaAdjacencias(lista, 30);

    H = diag(1./sum(A))*A;
    G = H*0.85+(ones(400,400)/400)*0.15;
    [V, D] = eig(G);
    eigenfactors30(:,k) = V(:,1)/sum(V(:,1));  
end