%lyap. v(x)=0.5*(x1^2+x2^2+x3^2)
clc;clear;
delta=0.00001;
totalTime=1;
totalStep=totalTime/delta;

x1array=[1:totalStep]*0;x2array=x1array;x3array=x1array;
x1_dot=x1array;x2_dot=x1array;x2_dot=x1array;
x1array(1)=0.1;x2array(1)=-0.1*pi;x3array(1)=0.1;%init condition
for i=1:totalStep
    x1=x1array(i);x2=x2array(i);x3=x3array(i);
    v(i)=0.5*(x1^2+x2^2+x3^2);
    u(i)=-(x1*(x2+x1-x3+sin(x1-x3))+x2*(x3+(x1-x3)^2)+x3*(sin(x1-x3))+1)/x3;
    v_dot(i)=x1*(x2+x1-x3+sin(x1-x3))+x2*(x3+(x1-x3)^2)+x3*(sin(x1-x3)+u(i));
%     fprintf('i=%d v=%f v_dot=%f u=%f\n',i,v(i),v_dot(i),u(i));  
    
    
    if abs(u(i))>10000
       u(i)=10000*sign(u(i));
       fprintf('DANGER !!! i=%f\n',i);
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
plot(x3array);legend('x1','x2','x3','location','southeast');
title('Lyap. controller');
figure(2);
plot(x1_dot);hold on;
plot(x2_dot);hold on;
plot(x3_dot);legend('x1dot','x2dot','x3dot','location','southeast');
title('Lyap. controller');
figure(3);
plot(v);title('v');
figure(4);
plot(u);title('u');