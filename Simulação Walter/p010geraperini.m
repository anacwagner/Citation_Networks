function p=p010geraperini(np,f,na_i,na_a)
%gera "p": conjunto inicial de "n" peri�dicos
%
%par�metros de entrada:
    %np: quantidade de peri�cos gerados
    %f: limite do range de fitness
    %na_i: n�mero inicial m�dio de artigos por peri�dico
    %na_a: n�mero m�dio de artigos por ano para cada peri�dico

%formato de "p"
    %coluna 01: c�digo do peri�dico (sequencial)
    %coluna 02: m�dia de fitness dos artigos do peri�dico (uniforme/range 1:f)
    %coluna 03: dp de fitness dos artigos do peri�dico: fun��o da m�dia de fitness: dp=m/2
    %coluna 04: n�mero inicial de artigos (poisson m�dia na_i)
    %coluna 05: n�mero de artigos por ano (poisson m�dia na_a)
    %coluna 06: fitness m�dio real TOTAL
    %coluna 07: fitness m�dio real DOIS ANOS
    %coluna 08: fitness m�dio real CINCO ANOS
    %coluna 09: grau de entrada TOTAL
    %coluna 10: grau de entrada DOIS ANOS
    %coluna 11: grau de entrada CINCO ANOS
    %coluna 12: n�mero de edi��es ao ano do peri�dico (aleat�rio: 1, 2, 3, 4)

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