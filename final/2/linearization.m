%linearization
clc;clear;
delta=0.00001;
totalTime=5;
totalStep=totalTime/delta;

pole1=[1 8];pole2=[1 6];pole3=[1 7];
char_poly=conv(pole1,conv(pole2,pole3));%(s+p1)*(s+p2)*(s+p3)=0

x1array=[1:totalStep]*0;x2array=x1array;x3array=x1array;
u=x1array;u_dot=x1array;u_dot_dot=x1array;
z1=x1array;z2=x1array;z3=x1array;
x1_dot=x1array;x2_dot=x1array;x2_dot=x1array;
x1array(1)=0;x2array(1)=-pi;x3array(1)=5;%init condition
x1array(2)=0;x2array(2)=-pi;x3array(2)=5;%init condition
x1array(3)=0;x2array(3)=-pi;x3array(3)=5;%init condition
for i=3:totalStep
    x1=x1array(i);x2=x2array(i);x3=x3array(i);
    x1_dot(i)=x2+x1-x3+sin(x1-x3);
    x2_dot(i)=x3+(x1-x3)^2;
    x3_dot(i)=sin(x1-x3)+u(i-2);
    
    z1(i)=x1-x3;
    z2(i)=x1_dot(i)-x3_dot(i);
    z3(i)=x3+z1(i)^2+z2(i)-u_dot(i-1);
    
    tmp=-char_poly(4)*z1(i)-char_poly(3)*z2(i)-char_poly(2)*z3(i);
    u_dot_dot(i)=sin(x1-x3)+u(i-2)+2*z1(i)*z2(i)+z3(i)-tmp;
    
    x1array(i+1)=x1+x1_dot(i)*delta;
    x2array(i+1)=x2+x2_dot(i)*delta;
    x3array(i+1)=x3+x3_dot(i)*delta;
    u_dot(i)=u_dot(i-1)+u_dot_dot(i)*delta;
    u(i-1)=u(i-2)+u_dot(i-1)*delta;
end

figure(1);
plot(x1array);hold on;
plot(x2array);hold on;
plot(x3array);legend('x1','x2','x3','location','southeast');
title('linearization');
figure(2);
plot(z1);hold on;
plot(z2);hold on;
plot(z3);hold on;legend('z1','z2','z3','location','southeast');
title('linearization');
figure(3);
plot(x1array-x3array);hold on;legend('x1-x3','location','southeast');
title('linearization');

figure(4);
time=1:totalStep-2;
xt=z1(time);yt=z2(time);zt=z3(time);
plot3(xt,yt,zt);hold on;
grid on;title('z1 z2 z3 phase portrait');
