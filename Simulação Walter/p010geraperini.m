function p=p010geraperini(np,f,na_i,na_a)
%gera "p": conjunto inicial de "n" periódicos
%
%parâmetros de entrada:
    %np: quantidade de periócos gerados
    %f: limite do range de fitness
    %na_i: número inicial médio de artigos por periódico
    %na_a: número médio de artigos por ano para cada periódico

%formato de "p"
    %coluna 01: código do periódico (sequencial)
    %coluna 02: média de fitness dos artigos do periódico (uniforme/range 1:f)
    %coluna 03: dp de fitness dos artigos do periódico: função da média de fitness: dp=m/2
    %coluna 04: número inicial de artigos (poisson média na_i)
    %coluna 05: número de artigos por ano (poisson média na_a)
    %coluna 06: fitness médio real TOTAL
    %coluna 07: fitness médio real DOIS ANOS
    %coluna 08: fitness médio real CINCO ANOS
    %coluna 09: grau de entrada TOTAL
    %coluna 10: grau de entrada DOIS ANOS
    %coluna 11: grau de entrada CINCO ANOS
    %coluna 12: número de edições ao ano do periódico (aleatório: 1, 2, 3, 4)

p=zeros(np,11);
for i=1:np
    p(i,1)=i;
    p(i,2)=ceil(rand(1)*f);
    p(i,3)=p(i,2)/2;
    p(i,4)=poissrnd(na_i);
    p(i,5)=poissrnd(na_a);
    p(i,6)=0;
    p(i,7)=0;
    p(i,8)=0;
    p(i,9)=0;
    p(i,10)=0;
    p(i,11)=0;
    p(i,12)=randi([1 4],1,1); 
end