%lyap.
clc;clear;
delta=0.01;
totalTime=200;
totalStep=totalTime/delta;

x1array=[1:totalStep]*0;x2array=x1array;x3array=x1array;
x1_dot=x1array;x2_dot=x1array;x2_dot=x1array;

x1array(1)=pi-(pi)^2;x2array(1)=-pi;x3array(1)=-pi^2;%init condition
for i=1:totalStep
    x1=x1array(i);x2=x2array(i);x3=x3array(i);
    v(i)=0.5*(x1+x2+x3)^2;
    u(i)=(-(x2+x1+2*sin(x1-x3)+(x1-x3)^2)-1/(x1+x2+x3));
    v_dot(i)=(x1+x2+x3)*(x2+x1+2*(sin(x1-x3))+(x1-x3)^2+u(i));
    fprintf('i=%d v=%f v_dot=%f u=%f\n',i,v(i),v_dot(i),u(i));
    if v(i)<0.001
       u(i)=0;
       fprintf('DANGER1 !!!\n');
    end
    if abs(u(i))>10^10
       u(i)=10^10*sign(u(i));
       fprintf('DANGER2 !!!\n');
    end

    
    
    x1_dot(i)=x2+x1-x3+sin(x1-x3);
    x2_dot(i)=x3+(x1-x3)^2;
    x3_dot(i)=sin(x1-x3)+u(i);
        
    x1array(i+1)=x1+x1_dot(i)*delta;
    x2array(i+1)=x2+x2_dot(i)*delta;
    x3array(i+1)=x3+x3_dot(i)*delta;
end

figure(1);
plot([0:1:totalStep]*delta,x1array);hold on;
plot([0:1:totalStep]*delta,x2array);hold on;
plot([0:1:totalStep]*delta,x3array);legend('x1','x2','x3','location','southeast');
title('Lyap. controller');
figure(2);
plot([0:1:totalStep-1]*delta,x1_dot);hold on;
plot([0:1:totalStep-1]*delta,x2_dot);hold on;
plot([0:1:totalStep-1]*delta,x3_dot);legend('x1dot','x2dot','x3dot','location','southeast');
title('Lyap. controller');