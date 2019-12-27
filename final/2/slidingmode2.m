%f=(D+lambda)(x1+x2)
clc;clear;

lambda=5;
K=10;
delta=0.01;
totalTime=10;
totalStep=totalTime/delta;
x1array=[1:totalStep]*0;x2array=x1array;x3array=x1array;
x1_dot=x1array;x2_dot=x1array;x2_dot=x1array;
x1array(1)=-1;x2array(1)=-1;x3array(1)=-1;%init condition
for i=1:totalStep
    x1=x1array(i);x2=x2array(i);x3=x3array(i);
    
    f(i)=x1+x2+sin(x1-x3)+(x1-x3)^2+lambda*(x1+x2);
    u(i)=(K*sign(f(i))+(1+lambda)*((x2+x1-x3+sin(x1-x3))+(x3+(x1-x3)^2))+(cos(x1-x3)+2*(x1-x3))*(x2+x1-x3))/(cos(x1-x3)+2*(x1-x3));
    
    fprintf('u=%f f=%f  \n',u(i),f(i));
    if abs( (cos(x1-x3)+2*(x1-x3)) )<0.01
        tmp=u(i);
        u(i)=tmp*0.1;
        fprintf('DANGER!!!!!!reset u->%f \n',u(i));
    end


    
    
    x1_dot(i)=x2+x1-x3+sin(x1-x3);
    x2_dot(i)=x3+(x1-x3)^2;
    x3_dot(i)=sin(x1-x3)+u(i);
        
    x1array(i+1)=x1+x1_dot(i)*delta;
    x2array(i+1)=x2+x2_dot(i)*delta;
    x3array(i+1)=x3+x3_dot(i)*delta;
end

figure(1);
plot(x1array);hold on;
plot(x2array);hold on;
plot(x3array);legend('x1','x2','x3');

figure(2);
plot(u);
title('u');

figure(3);
time=1:totalStep-1;
xt=x1array(time);
yt=x2array(time);
zt=x2array(time);
plot3(xt,yt,zt);
grid on;
figure(4);
plot(f);title('f');
figure(5);
plot(x1_dot);hold on;
plot(x2_dot);hold on;
plot(x3_dot);legend('x1dot','x2dot','x3dot');