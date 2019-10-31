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
%     x1_dot=0.5*x1^3+7*x2;
%     x2_dot=2*x1*x2+u;
    x1_dot=0.5*x1^3+9*x2;
    x2_dot=1.5*x1*x2+u;
    z1array(i)=x1;
    z2array(i)=x1_dot;
    
    x1array(i+1)=x1+x1_dot*delta;
    x2array(i+1)=x2+x2_dot*delta;
end

figure(1);
plot([0:1:totalStep]*delta,x1array,'r');
hold on;
plot([0:1:totalStep]*delta,x2array,'b');
legend('x1','x2');
title('x1 x2 time response (With error)');

figure(2);
plot([0:1:totalStep-1]*delta,z1array,'r');
hold on;
plot([0:1:totalStep-1]*delta,z2array,'b');
legend('z1','z2');
title('z1 z2 time response (With error)');

figure(3);
plot(x1array,x2array,'r');
title('x1 x2 phase portrait (With error)');
xlabel('x1');ylabel('x2');

figure(4);
plot(z1array,z2array,'b');
title('z1 z2 phase portrait (With error)');
xlabel('z1');ylabel('z2');

figure(5);
plot([0:1:totalStep]*delta,x1array,'r');
title('Output y=x1 (With error)');