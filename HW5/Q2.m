clc;clear;

lambda=0.5;
K=1;
delta=0.001;
totalTime=10;
totalStep=totalTime/delta;
for K=0.6:0.2:1.4
    x1array=[1:totalStep]*0;x2array=x1array;
    x1array(1)=3;x2array(1)=-3;%init condition
    
    for i=1:totalStep
        x1=x1array(i);x2=x2array(i);

        f=x2+lambda*x1;
        u=(-sign(f)*K-x1^3*x2-9*x1*x2^3)/((x1^2+x2^2));

        d=0.1*sin(10*pi*(i*delta));
        x1_dot=x2;
        x2_dot=(1)*x1^3*x2+(9)*x1*x2^3+(x1^2+x2^2)*u+d;

        x1array(i+1)=x1+x1_dot*delta;
        x2array(i+1)=x2+x2_dot*delta;
    end

    plot(x1array,x2array);
    hold on;
end

xlabel('x1');
ylabel('x2');
title('Sliding Mode Controller');
legend({'K=0.6','K=0.8','K=1','K=1.2','K=1.4'});