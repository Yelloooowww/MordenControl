clear;clc;
% A=[-2 0;0 -2];%star
% A=[-2 0;0 -3];%node
% A=[-2 0;0 3];%saddle
% A=[0 2;-2 0];%center
A=[-2 1;-1 -2]%focus

datasize=1000;
x1array(1)=1000;
x2array(1)=1000;
for i=1:(datasize-1)
    x(1)=x1array(i); x(2)=x2array(i);
    xNext=RungeKutta(x,0.01,A);
    x1array(i+1)=xNext(1);
    x2array(i+1)=xNext(2);
end
   


plot(x1array,'r');
hold on;
plot(x2array,'b');
legend('x1','x2');
title({'time series';'A=[-2 1;-1 -2] x_0=[1000 1000]'});