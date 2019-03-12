function z = vectorC(k,a)
c=1:1:k;

% a% of the nodes are strategic
for i=1:1:k
if i<=a*k
    c(i)=1;
else
    c(i)=2;
end
z=c;
end

    