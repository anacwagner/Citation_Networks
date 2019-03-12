P=[0.3 0.1;0.1 0.1];
for a=0:0.1:1
    c=vectorC(c,a);
    A=testevetor(c,P,true);
    i = 1;
    x_plot = 0:0.1:1;
    Q1 = zeros(1,11);
    Q2 = zeros(1,11);
    for x=0:0.1:1
        c2=vectorC2(c,a,x);
        Q1(i)=modularity(c2,a,A);
        Q2(i)=modularity(c2,a,A); 
        %d(i)=Q1(i)-Q2(i);
        i = i + 1;
    end
    f1 = figure;
    plot(x_plot,Q1,'r',x_plot,Q2,'b');
    xlabel('Similarity between vectors c and c2 (x%)')
    ylabel('Q1,Q2')
    title('Values of Q1 and Q2 for a% of strategic nodes')
    legend('Q1','Q2')
    %saveas(f1, fullfile('C:\Users\Felipe\Documents\1Mestrado\FGV-Rachit', ['figure' num2str(a) '.png']));
    %close(f1);
end


