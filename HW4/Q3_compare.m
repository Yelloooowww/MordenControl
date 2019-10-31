clear;clc;

delta=0.001;
totalTime=10;
totalStep=totalTime/delta;
x1array=[1:totalStep]*0;x2array=x1array;
z1array=x1array;z2array=x1array;

x1array(1)=2;x2array(1)=-1;%init condition
for i=1:totalStep
    x1=x1array(i);x2=x2array(i);
    u=(-(7.5*x1^5+10.5*x1^2*x2+14*x1*x2)-82*x1-2*(0.5*x1^3+7*x2))/7;
    x1_dot=0.5*x1^3+7*x2;
    x2_dot=2*x1*x2+u;
%     x1_dot=0.5*x1^3+9*x2;
%     x2_dot=1.5*x1*x2+u;
    z1array(i)=x1;
    z2array(i)=x1_dot;
    
    x1array(i+1)=x1+x1_dot*delta;
    x2array(i+1)=x2+x2_dot*delta;
end

plot([0:1:totalStep]*delta,x1array,'r');
hold on;

x1array=[1:totalStep]*0;x2array=x1array;
z1array=x1array;z2array=x1array;
x1array(1)=2;x2array(1)=-1;%init condition
for i=1:totalStep
    x1=x1array(i);x2=x2array(i);
    u=(-(7.5*x1^5+10.5*x1^2*x2+14*x1*x2)-82*x1-2*(0.5*x1^3+7*x2))/7;
%     x1_dot=0.5*x1^3+7*x2;
%     x2_dot=2*x1*x2+u;
    x1_dot=0.5*x1^3+9*x2;
    x2_dot=1.5*x1*x2+u;
    z1array(i)=x1;
    z2array(i)=x1_dot;
    
    x1array(i+1)=x1+x1_dot*delta;
    x2array(i+1)=x2+x2_dot*delta;
end

plot([0:1:totalStep]*delta,x1array,'b');
title('Comparison');
legend('without error','with error');