k=2000;
a=0.4;
c=vectorC(k,a);
c=VectorC(k,a);
c=vectorC(k,a);
P=[0.1 0.1;0.1 0.1]
A=testevetor(c,P,true);
g1=c==1;
g2=c==2;
cont11=sum(sum(A(g1,g1)));
cont12=sum(sum(A(g2,g1)));
cont21=sum(sum(A(g1,g2)));
cont22=sum(sum(A(g2,g2)));
Pcom=[0.12 0.087;0.087 0.1088]
Acom=testevetor(c,Pcom,true);
cont11com=sum(sum(Acom(g1,g1)));
cont12com=sum(sum(Acom(g2,g1)));
cont21com=sum(sum(Acom(g1,g2)));
cont22com=sum(sum(Acom(g2,g2)));
Pstr=[0.12 0.1;0.087 0.1]
Astr=testevetor(c,Pstr,true);
cont11str=sum(sum(Astr(g1,g1)));
cont12str=sum(sum(Astr(g2,g1)));
cont21str=sum(sum(Astr(g1,g2)));
cont22str=sum(sum(Astr(g2,g2)));
Rcom=(cont11*cont12com)/(cont11com*cont12)
1/Rcom
R2com=(cont21*cont22com)/(cont22*cont21com)
Rstr=(cont11*cont12str)/(cont11str*cont12)
1/Rstr
R2str=(cont21*cont22str)/(cont22*cont21str)