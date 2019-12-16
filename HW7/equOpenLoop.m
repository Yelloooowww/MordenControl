%try about 2nd pole assign.
%design C(z) and using equivalent open loop transfer func.
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
fprintf("alpha1=%f;beta0=%f;beta1=%f;\n",alpha1,beta0,beta1);

num=conv([b1,b2],[beta0,beta1]);%C(z)*G(z)
den=conv([1,a1,a2],[1,alpha1]);%C(z)*G(z)
fb_num=num;%equivalent open loop sys.
fb_den=[0,num]+den;%equivalent open loop sys.

y=[1:totalStep]*0;
u=[1:totalStep]*0;
r=[1:totalStep]*0;
y(1)=0;y(2)=0;y(3)=0;
u(1)=0;u(2)=1;u(3)=1;
for k=1:totalStep-3
    u(k+3)=1;
    y(k+3)=-fb_den(2)*y(k+2)-fb_den(3)*y(k+1)-fb_den(4)*y(k)+fb_num(1)*u(k+2)+fb_num(2)*u(k+1)+fb_num(3)*u(k)+d(k+3);
end 
figure(1);
plot(y);hold on;plot(u);
legend('y','u=unit step');
title("design C(z) and using equivalent open loop transfer func.");

y=[1:totalStep]*0;
u=[1:totalStep]*0;
r=[1:totalStep]*0;
y(1)=0;y(2)=0;y(3)=0;
u(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
u(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
u(3)=sin(6*3/20)+0.5*cos(6*3/15+3.2)+0.2*sin(2.57*3/13+1.36);
for k=1:totalStep-3
    u(k+3)=sin(6*(k+2)/20)+0.5*cos(6*(k+2)/15+3.2)+0.2*sin(2.57*(k+2)/13+1.36);
    y(k+3)=-fb_den(2)*y(k+2)-fb_den(3)*y(k+1)-fb_den(4)*y(k)+fb_num(1)*u(k+2)+fb_num(2)*u(k+1)+fb_num(3)*u(k)+d(k+3);
end 
figure(2);
plot(y);hold on;plot(u);
legend('y','u=©¶ªi');
title("design C(z) and using equivalent open loop transfer func.");