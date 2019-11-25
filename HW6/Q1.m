clc;clear;

delta=0.01;
totalTime=10;
totalStep=totalTime/delta;

x1array=[1:totalStep]*0;x2array=x1array;x3array=x1array;
x1array(1)=-10;x2array(1)=-10;x3array(1)=-10;%init condition
alpha=0.9;
K=10;lambda=1;
for i=1:totalStep
    x1=x1array(i);x2=x2array(i);x3=x3array(i);
    
    f=x3+2*lambda*x2+lambda^2*x1;
    
    u=-sign(f)*K-(alpha*(x1^2*sin(x2)+x2^2*sin(x3))+(x1+x3^2)*cos(x3)+2*lambda*x3+lambda^2*x2);
    
    d(i)=0.2*sin(i)+0.1*cos(5*i+pi);
    x1_dot=x2;
    x2_dot=x3;
    x3_dot=alpha*(x1^2*sin(x2)+x2^2*sin(x3))+(x1+x3^2)*cos(x3)+u+d(i);
    
    x1array(i+1)=x1+x1_dot*delta;
    x2array(i+1)=x2+x2_dot*delta;
    x3array(i+1)=x3+x3_dot*delta;
end

plot3(x1array,x2array,x3array);
grid on;

xlabel('x1');
ylabel('x2');
zlabel('x3');
title('Sliding Mode Controller');