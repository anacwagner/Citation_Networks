function c2 = vectorC2(c,a,x)

[c]=vectorC(c,a);
k=length(c);
r=rand(1,k);
p=(1:1:k)/k;
v=(1-x)*r+x*p;
[~,ind]=sort(v);
c2=c(ind);
end




