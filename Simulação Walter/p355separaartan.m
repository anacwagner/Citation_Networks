function [an_norm,an_estrat]=p355separaartan(an,estrat,prob_a_estrat)
%separa os artigos publicados no ano em "estratégicos" ou "normais"
an_norm=[];
an_estrat=[];
for i=1:size(an,1)
    if find(estrat(:,1)==an(i,1)) %se o periódico está na lista de estratégicos
        if rand(1)<prob_a_estrat      %com uma probabilidade prob_a_estrat
            an_estrat=[an_estrat;an(i,:)];  %ele é colocado na lista de "estratégicos"
        else
            an_norm=[an_norm;an(i,:)];      %ou na lista de artigos normais
        end
    else                          %caso contrário,
        an_norm=[an_norm;an(i,:)];          %o artigo é colocado na lista de artigos normais
    end
end