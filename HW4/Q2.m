clear;clc;

delta=0.001;
totalTime=10;
totalStep=totalTime/delta;
x1array=[1:totalStep]*0;x2array=x1array;x3array=x1array;
z1array=x1array;z2array=x1array;z3array=x1array;

x1array(1)=2;x2array(1)=-1;x3array(1)=1;%init condition
for i=1:totalStep
    x1=x1array(i);x2=x2array(i);x3=x3array(i);
    
    x1_dot=x2+x1^3;
    x2_dot=x3;
    z1=x1;
    z2=x2+x1^3;
    z3=x2_dot+3*x1^2*x1_dot;
    k1=-82;k2=-84;k3=-3;
    arpha=3*(2*x1*x1_dot*(x2+x1^3)+x1^2*(x2_dot+3*x1^2*x1_dot));
    u=-1*arpha+(k1*z1+k2*z2+k3*z3);
    x3_dot=u;
    
    
    z1array(i)=z1;
    z2array(i)=z2;
    z3array(i)=z3;
    x1array(i+1)=x1+x1_dot*delta;
    x2array(i+1)=x2+x2_dot*delta;
    x3array(i+1)=x3+x3_dot*delta;
end

figure(1);
plot([0:1:totalStep]*delta,x1array,'r');
hold on;
plot([0:1:totalStep]*delta,x2array,'b');
hold on;
plot([0:1:totalStep]*delta,x3array,'g');
legend('x1','x2','x3');
title('x1 x2 x3 time series');

figure(2);
plot([0:1:totalStep-1]*delta,z1array,'r');
hold on;
plot([0:1:totalStep-1]*delta,z2array,'b');
hold on;
plot([0:1:totalStep-1]*delta,z3array,'g');
legend('z1','z2','z3');
title('z1 z2 z3 time series');

figure(3);
plot3(x1array,x2array,x3array);
xlabel('x1');ylabel('x2');zlabel('x3');
title('x1 x2 x3 phase portrait');
grid on;

figure(4);
plot3(z1array,z2array,z3array);
xlabel('z1');ylabel('z2');zlabel('z3');
title('z1 z2 z3 phase portrait');
grid on;

figure(5);
plot([0:1:totalStep]*delta,x1array,'r');
title('Output y=x1');