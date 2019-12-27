%3stage
%stage2:f=(D+lambda)(x2)
clc;clear;
lambda=1;
K=10;
delta=0.01;
totalTime=10;
totalStep=totalTime/delta;
x1array=[1:totalStep]*0;x2array=x1array;x3array=x1array;
x1_dot=x1array;x2_dot=x1array;x2_dot=x1array;
x1array(1)=-2;x2array(1)=-2;x3array(1)=-2;%init condition

nowstep=1;
%x1->>>0
for i=nowstep:totalStep
    x1=x1array(i);x2=x2array(i);x3=x3array(i);
    fprintf('STAGE1 i=%f x1=%f,x2=%f,x2=%f \n',i,x1,x2,x3);
    
    f(i)=x2+x1-x3+sin(x1-x3)+lambda*x1;
    if abs(x1)<0.001 %x1->>>0
        fprintf('i=%f BREAK  (x1=0)\n',i);
        break;
    end
    u(i)=(1/(1+cos(x1-x3)))*(K*sign(f(i))+((x3+(x1-x3)^2)+(x2+x1-x3)-sin(x1-x3)+cos(x1-x3)*(x2+x1-x3)+lambda*(x2+x1-x3+sin(x1-x3))));

    
    x1_dot(i)=x2+x1-x3+sin(x1-x3);
    x2_dot(i)=x3+(x1-x3)^2;
    x3_dot(i)=sin(x1-x3)+u(i);
        
    x1array(i+1)=x1+x1_dot(i)*delta;
    x2array(i+1)=x2+x2_dot(i)*delta;
    x3array(i+1)=x3+x3_dot(i)*delta;
end

nowstep=i;
%x2->>>0
for i=nowstep:totalStep
    x1=x1array(i);x2=x2array(i);x3=x3array(i);
    fprintf('STAGE2 i=%f x1=%f,x2=%f,x3=%f \n',i,x1,x2,x3);
    
    f(i)=x3+(x1-x3)^2+lambda*x2;
    if abs(x2)<0.001 %x2->>>0
        fprintf('i=%f BREAK (x2=0)\n',i);
        break;
    end
    u1=(1/(1+cos(x1-x3)))*(K*sign(f(i))+((x3+(x1-x3)^2)+(x2+x1-x3)-sin(x1-x3)+cos(x1-x3)*(x2+x1-x3)+lambda*(x2+x1-x3+sin(x1-x3))));
    u2=(K*sign(f(i))+sin(x1-x3)+(x1-x3)*(x2+x1-x3)+lambda*(x3+(x1-x3)^2))/(-1+2*(x1-x3));
    u(i)=u1+u2;
    x1_dot(i)=x2+x1-x3+sin(x1-x3);
    x2_dot(i)=x3+(x1-x3)^2;
    x3_dot(i)=sin(x1-x3)+u(i);
        
    x1array(i+1)=x1+x1_dot(i)*delta;
    x2array(i+1)=x2+x2_dot(i)*delta;
    x3array(i+1)=x3+x3_dot(i)*delta;
end


% nowstep=i;
% %x3->>>0
% for i=nowstep:totalStep
%     x1=x1array(i);x2=x2array(i);x3=x3array(i);
%     fprintf('STAGE3 i=%f x1=%f,x2=%f,x2=%f \n',i,x1,x2,x3);
%     u(i)=-(sin(x1-x3)+lambda*x3);
% 
%     x1_dot(i)=x2+x1-x3+sin(x1-x3);
%     x2_dot(i)=x3+(x1-x3)^2;
%     x3_dot(i)=sin(x1-x3)+u(i);
%         
%     x1array(i+1)=x1+x1_dot(i)*delta;
%     x2array(i+1)=x2+x2_dot(i)*delta;
%     x3array(i+1)=x3+x3_dot(i)*delta;
% end


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
