function [Q1,Q2] = modularity(c,a,A)
%total of links
m=sumabs(A);
n=length(c);
%%
%degree k of each node
B=zeros(n,n);
d1=sum(A,2);
d2=sum(A);
for i=1:1:n
    for j=1:1:n
    %k(i)=d1(i);
    %k(j)=d2(j);
    B(i,j)=(A(i,j)-d1(i)*d2(j)/(m));
    end
end
%%
%calculation of vectors s1(strategic) and s2(non-strategic)

%[c]=vectorC(c,a);
s1=1:1:n;
s2=1:1:n;
for i=1:1:n
    if c(i)==1
    s1(i)=c(i);
    else
        s1(i)=0;
    end
    if s1(i)==1;
        s2(i)=0;
    else
        s2(i)=1;
    end
end
%%
    %calculation of `modularities` Q1 and Q2
    Q1=(s1*B*s1')/(m);
    Q2=(s1*B*s2')/(m);
    
end