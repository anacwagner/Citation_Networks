function [sai_tot, sai_2an, sai_5an,sai_dp_tot, sai_dp_2an, sai_dp_5an]=p900extrai_mdp(var_pif,var_pgrau,var_pe)
%Extrai as informações de grau e fator de impacto dos periódicos "normais" e dos "estratégicos"
%
%Saída: informações TOTAIS, de 2 ANOS e de 5 ANOS
%   arquivos diferentes para MEDIA e DP
%
%Entrada: arquivos com informações de grau e fator de impacto e lista de periódicos estratégicos

%Informações de Média
sai_if_n=var_pif;
sai_gr_n=var_pgrau;
for i=1:size(var_pe,1)
    sai_if_e(i,:)=var_pif(var_pif(:,1)==var_pe(i,1),:);
    sai_if_n=[sai_if_n(1:((find(sai_if_n(:,1)==var_pe(i,1)))-1),:); sai_if_n(((find(sai_if_n(:,1)==var_pe(i,1)))+1):end,:)];
    sai_gr_e(i,:)=var_pgrau(var_pgrau(:,1)==var_pe(i,1),:);
    sai_gr_n=[sai_gr_n(1:((find(sai_gr_n(:,1)==var_pe(i,1)))-1),:); sai_gr_n(((find(sai_gr_n(:,1)==var_pe(i,1)))+1):end,:)];
end
%sai_if=[mean(sai_if_e(:,11:16)) mean(sai_if_e(:,59:64));mean(sai_if_n(:,11:16)) mean(sai_if_n(:,59:64)) ];
%sai_gr=[mean(sai_gr_e(:,11:16)) mean(sai_gr_e(:,59:64));mean(sai_gr_n(:,11:16)) mean(sai_gr_n(:,59:64)) ];

%sai_if_e=mean(sai_if_e(:,2:64));
%sai_if_n=mean(sai_if_n(:,2:64));
%sai_gr_e=mean(sai_gr_e(:,2:64));
%sai_gr_n=mean(sai_gr_n(:,2:64));

sai_if_e=mean(sai_if_e(:,2:end));
sai_if_n=mean(sai_if_n(:,2:end));
sai_gr_e=mean(sai_gr_e(:,2:end));
sai_gr_n=mean(sai_gr_n(:,2:end));

sai_if1=[];
sai_if2=[];
sai_gr1=[];
sai_gr2=[];
%for i=1:3:61 % TOTAL
for i=1:3:size(sai_if_n,2)-2 % TOTAL
    sai_if1=[sai_if1 sai_if_n(:,i)]; %NORMAL
    sai_if2=[sai_if2 sai_if_e(:,i)]; %ESTRAT
    sai_gr1=[sai_gr1 sai_gr_n(:,i)]; %NORMAL
    sai_gr2=[sai_gr2 sai_gr_e(:,i)]; %ESTRAT
end
sai_tot=[sai_gr1  sai_if1;sai_gr2 sai_if2];
sai_if1=[];
sai_if2=[];
sai_gr1=[];
sai_gr2=[];
%for i=2:3:62 % 2 ANOS
for i=2:3:size(sai_if_n,2)-1 % 2 ANOS
    sai_if1=[sai_if1 sai_if_n(:,i)]; %NORMAL
    sai_if2=[sai_if2 sai_if_e(:,i)]; %ESTRAT
    sai_gr1=[sai_gr1 sai_gr_n(:,i)]; %NORMAL
    sai_gr2=[sai_gr2 sai_gr_e(:,i)]; %ESTRAT
end
sai_2an=[sai_gr1  sai_if1;sai_gr2 sai_if2];
sai_if1=[];
sai_if2=[];
sai_gr1=[];
sai_gr2=[];
%for i=3:3:63 % 5 ANOS
for i=3:3:size(sai_if_n,2) % 5 ANOS
    sai_if1=[sai_if1 sai_if_n(:,i)]; %NORMAL
    sai_if2=[sai_if2 sai_if_e(:,i)]; %ESTRAT
    sai_gr1=[sai_gr1 sai_gr_n(:,i)]; %NORMAL
    sai_gr2=[sai_gr2 sai_gr_e(:,i)]; %ESTRAT
end
sai_5an=[sai_gr1  sai_if1;sai_gr2 sai_if2];

%Informações de Desvio Padrão
sai_dp_if_n=var_pif;
sai_dp_gr_n=var_pgrau;
for i=1:size(var_pe,1)
    sai_dp_if_e(i,:)=var_pif(var_pif(:,1)==var_pe(i,1),:);
    sai_dp_if_n=[sai_dp_if_n(1:((find(sai_dp_if_n(:,1)==var_pe(i,1)))-1),:); sai_dp_if_n(((find(sai_dp_if_n(:,1)==var_pe(i,1)))+1):end,:)];
    sai_dp_gr_e(i,:)=var_pgrau(var_pgrau(:,1)==var_pe(i,1),:);
    sai_dp_gr_n=[sai_dp_gr_n(1:((find(sai_dp_gr_n(:,1)==var_pe(i,1)))-1),:); sai_dp_gr_n(((find(sai_dp_gr_n(:,1)==var_pe(i,1)))+1):end,:)];
end
%sai_dp_if=[mean(sai_dp_if_e(:,11:16)) mean(sai_dp_if_e(:,59:64));mean(sai_dp_if_n(:,11:16)) mean(sai_dp_if_n(:,59:64)) ];
%sai_dp_gr=[mean(sai_dp_gr_e(:,11:16)) mean(sai_dp_gr_e(:,59:64));mean(sai_dp_gr_n(:,11:16)) mean(sai_dp_gr_n(:,59:64)) ];

%sai_dp_if_e=mean(sai_dp_if_e(:,2:64));
%sai_dp_if_n=mean(sai_dp_if_n(:,2:64));
%sai_dp_gr_e=mean(sai_dp_gr_e(:,2:64));
%sai_dp_gr_n=mean(sai_dp_gr_n(:,2:64));

sai_dp_if_e=std(sai_dp_if_e(:,2:end));
sai_dp_if_n=std(sai_dp_if_n(:,2:end));
sai_dp_gr_e=std(sai_dp_gr_e(:,2:end));
sai_dp_gr_n=std(sai_dp_gr_n(:,2:end));

sai_dp_if1=[];
sai_dp_if2=[];
sai_dp_gr1=[];
sai_dp_gr2=[];
%for i=1:3:61 % TOTAL
for i=1:3:size(sai_dp_if_n,2)-2 % TOTAL
    sai_dp_if1=[sai_dp_if1 sai_dp_if_n(:,i)]; %NORMAL
    sai_dp_if2=[sai_dp_if2 sai_dp_if_e(:,i)]; %ESTRAT
    sai_dp_gr1=[sai_dp_gr1 sai_dp_gr_n(:,i)]; %NORMAL
    sai_dp_gr2=[sai_dp_gr2 sai_dp_gr_e(:,i)]; %ESTRAT
end
sai_dp_tot=[sai_dp_gr1  sai_dp_if1;sai_dp_gr2 sai_dp_if2];
sai_dp_if1=[];
sai_dp_if2=[];
sai_dp_gr1=[];
sai_dp_gr2=[];
%for i=2:3:62 % 2 ANOS
for i=2:3:size(sai_dp_if_n,2)-1 % 2 ANOS
    sai_dp_if1=[sai_dp_if1 sai_dp_if_n(:,i)]; %NORMAL
    sai_dp_if2=[sai_dp_if2 sai_dp_if_e(:,i)]; %ESTRAT
    sai_dp_gr1=[sai_dp_gr1 sai_dp_gr_n(:,i)]; %NORMAL
    sai_dp_gr2=[sai_dp_gr2 sai_dp_gr_e(:,i)]; %ESTRAT
end
sai_dp_2an=[sai_dp_gr1  sai_dp_if1;sai_dp_gr2 sai_dp_if2];
sai_dp_if1=[];
sai_dp_if2=[];
sai_dp_gr1=[];
sai_dp_gr2=[];
%for i=3:3:63 % 5 ANOS
for i=3:3:size(sai_dp_if_n,2) % 5 ANOS
    sai_dp_if1=[sai_dp_if1 sai_dp_if_n(:,i)]; %NORMAL
    sai_dp_if2=[sai_dp_if2 sai_dp_if_e(:,i)]; %ESTRAT
    sai_dp_gr1=[sai_dp_gr1 sai_dp_gr_n(:,i)]; %NORMAL
    sai_dp_gr2=[sai_dp_gr2 sai_dp_gr_e(:,i)]; %ESTRAT
end
sai_dp_5an=[sai_dp_gr1  sai_dp_if1;sai_dp_gr2 sai_dp_if2];
