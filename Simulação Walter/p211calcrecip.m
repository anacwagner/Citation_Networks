function [recip_sum]=p211calcrecip(p, pe, citper,anos)
%calcula o índice de reciprocidade entre os periódicos
%
%parâmetros de entrada:
    %p: lista de periódicos
    %pe: lista de periódicos estratégicos
    %citper: lista de citações entre periódicos existentes
    %anos: lista com os valores dos anos de análise:
    %   ano(1): ano imediatamente antes do início do comportamento estratégico
    %   ano(2): último ano de comportamento estratégico
    %   ano(3): último ano da simulação

%parâmetros de SAÍDA:
%formato de "recip_sum"
    %coluna 01: código do periódico SOURCE
    %coluna 02: campo lógico que indica se o periódico é estratégico ou não
    %coluna 03: primeiro ano considerado (informado no parâmetro de entrada)
    %coluna 04: quantidade de citações feitas pelo source (grau de entrada)
    %coluna 05: quantidade de citações recíprocas recebidas pelo source
    %coluna 06: índice de reciprocidade no primeiro ano
    %coluna 07: segundo ano considerado (informado no parâmetro de entrada)
    %coluna 08: quantidade de citações feitas pelo source (grau de entrada)
    %coluna 09: quantidade de citações recíprocas recebidas pelo source
    %coluna 09: índice de reciprocidade no segundo ano
    %coluna 11: segundo ano considerado (informado no parâmetro de entrada)
    %coluna 12: quantidade de citações feitas pelo source (grau de entrada)
    %coluna 13: quantidade de citações recíprocas recebidas pelo source
    %coluna 14: índice de reciprocidade no segundo ano
    
%AUXILIAR
%formato de "recip"
    %coluna 01: ano da ligação entre os periódicos
    %coluna 02: código do periódico SOURCE
    %coluna 03: código do periódico TARGET
    %coluna 04: quantidade de citações feitas pelo SOURCE ao TARGET
    %coluna 05: quantidade de citações correspondidas (é o mínimo entre as citações SORCE-TARGET e TARGET-SOURCE

%ENTRADA
%formato de "citper"
    %coluna 01: ano do artigo publicado (SOURCE)
    %coluna 02: ano do artigo citado (TARGET)
    %coluna 03: código do periódico SOURCE
    %coluna 04: código do periódico TARGET
    %coluna 05: quantidade de citações entre os periódicos

nper=size(p,1);
%Matrizes auxiliares citper1 e citper2 contam as citações entre periódicos
%Matrizes quadradas onde i=source e j=target
citper1=citper((citper(:,1)==anos(1)),:);   %citações no primeiro ano
citper2=citper((citper(:,1)==anos(2)),:);   %citações no segundo ano
citper3=citper((citper(:,1)==anos(3)),:);   %citações no terceiro ano
recip1=zeros(500,500);                      %matriz de citações no primeiro ano
recip2=zeros(500,500);                      %matriz de citações no segundo ano
recip3=zeros(500,500);                      %matriz de citações no terceiro ano
recip=zeros((nper^2-nper)*3,5);

for k=1:size(citper1,1)                     %para as citações no primeiro ano
    recip1(citper1(k,3),citper1(k,4))=recip1(citper1(k,3),citper1(k,4))+citper1(k,5);
end
for k=1:size(citper2,1)                     %para as citações no segundo ano
    recip2(citper2(k,3),citper2(k,4))=recip2(citper2(k,3),citper2(k,4))+citper2(k,5);
end
for k=1:size(citper3,1)                     %para as citações no segundo ano
    recip3(citper3(k,3),citper3(k,4))=recip3(citper3(k,3),citper3(k,4))+citper3(k,5);
end


%Monta a matriz com a soma de citações entre cada source e cada target
ind=1;
% i: source; j: target
for i=1:(nper-1)
    for j=i+1:nper
            recip(ind,:)=[anos(1) i j recip1(i,j) min(recip1(i,j),recip1(j,i))];
            recip(ind+1,:)=[anos(1) j i recip1(j,i) min(recip1(i,j),recip1(j,i))];
            recip(ind+2,:)=[anos(2) i j recip2(i,j) min(recip2(i,j),recip2(j,i))];
            recip(ind+3,:)=[anos(2) j i recip2(j,i) min(recip2(i,j),recip2(j,i))];
            recip(ind+4,:)=[anos(3) i j recip3(i,j) min(recip3(i,j),recip3(j,i))];
            recip(ind+5,:)=[anos(3) j i recip3(j,i) min(recip3(i,j),recip3(j,i))];
            ind=ind+5;
    end
end
recip=sortrows(recip, [1 2 3]);

%Monta a matriz de contagem de citações feitas e recebidas reciprocamente por cada periódico
recip_sum=zeros(nper,14);
for i=1:nper
    recip_sum(i,1)=p(i,1);
    recip_sum(i,3)=anos(1);
    recip_sum(i,4)=sum((recip(:,1)==anos(1)).*(recip(:,2)==i).*(recip(:,4)));
    recip_sum(i,5)=sum((recip(:,1)==anos(1)).*(recip(:,2)==i).*(recip(:,5)));
    if recip_sum(i,4)~=0
        recip_sum(i,6)=recip_sum(i,5)/recip_sum(i,4);
    else
        recip_sum(i,6)=0;
    end
    recip_sum(i,7)=anos(2);
    recip_sum(i,8)=sum((recip(:,1)==anos(2)).*(recip(:,2)==i).*(recip(:,4)));
    recip_sum(i,9)=sum((recip(:,1)==anos(2)).*(recip(:,2)==i).*(recip(:,5)));
    if recip_sum(i,8)~=0
        recip_sum(i,10)=recip_sum(i,9)/recip_sum(i,8);
    else
        recip_sum(i,10)=0;
    end
    recip_sum(i,11)=anos(3);
    recip_sum(i,12)=sum((recip(:,1)==anos(3)).*(recip(:,2)==i).*(recip(:,4)));
    recip_sum(i,13)=sum((recip(:,1)==anos(3)).*(recip(:,2)==i).*(recip(:,5)));
    if recip_sum(i,12)~=0
        recip_sum(i,14)=recip_sum(i,13)/recip_sum(i,12);
    else
        recip_sum(i,14)=0;
    end
    recip_sum(i,2)= numel(find(pe==recip_sum(i,1)));
end

















