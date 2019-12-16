%close loop control
%result same as using equivalent open loop transfer func.
clear;clc;
totalStep=1000;
a1=0.3;a2=-0.88;b1=0.9;b2=0.6;%system
for k=1:totalStep
    d(k)=0.01*(rand-0.5);
end

poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%pole assignment
A=[1 b1 0;a1 b2 b1;a2 0 b2];
b=[poly(2)-a1;poly(3)-a2;poly(4)];
x=inv(A)*b;
alpha1=x(1);beta0=x(2);beta1=x(3);

y=[1:totalStep]*0;
u=[1:totalStep]*0;
r=[1:totalStep]*0;
e=[1:totalStep]*0;
r(1)=0;
r(2)=1;
r(3)=1;
for k=1:totalStep-2
    r(k+1)=1;
    e(k+1)=r(k+1)-y(k+1);
    u(k+1)=(-alpha1*u(k)+beta0*e(k+1)+beta1*e(k));
    y(k+2)=-a1*y(k+1)-a2*y(k)+b1*u(k+1)+b2*u(k)+d(k+2);
end 
figure(1)
plot(y,'b');hold on;plot(u,'g');hold on;plot(r,'y');plot(e,'r');
xlabel("k");
legend('y','u','r','e');
title("喔喔喔我做出負回授了 (r=unit step)");

y=[1:totalStep]*0;
u=[1:totalStep]*0;
r=[1:totalStep]*0;
e=[1:totalStep]*0;
r(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
r(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
r(3)=sin(6*3/20)+0.5*cos(6*3/15+3.2)+0.2*sin(2.57*3/13+1.36);
for k=1:totalStep-2
    r(k+1)=sin(6*(k+1)/20)+0.5*cos(6*(k+1)/15+3.2)+0.2*sin(2.57*(k+1)/13+1.36);
    e(k+1)=r(k+1)-y(k+1);
    u(k+1)=(-alpha1*u(k)+beta0*e(k+1)+beta1*e(k));
    y(k+2)=-a1*y(k+1)-a2*y(k)+b1*u(k+1)+b2*u(k)+d(k+2);
end 
figure(2)
plot(y,'b');hold on;plot(u,'g');hold on;plot(r,'y');plot(e,'r');
xlabel("k");
legend('y','u','r','e');
title("喔喔喔我做出負回授了 (r=弦波)");