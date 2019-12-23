%MRAC
clear;clc;
totaltime=100;
delta=0.01;
totalstep=totaltime/delta;

%model
xm1(1)=0;xm2(1)=0;
for k=1:totalstep
%     r(k)=1;
    r(k)=sin(0.5*k*delta)+0.3*cos(2*k*delta+4);
    xm1_dot(k)=xm2(k);
    xm2_dot(k)=-2*xm1(k)-3*xm2(k)+2*r(k);
    xm1(k+1)=xm1(k)+xm1_dot(k)*delta;
    xm2(k+1)=xm2(k)+xm2_dot(k)*delta;
end

%select para.
Q=[1 0;0 1000];
Am=[0 1;-3 -4];bm=2;
b=1;
P=lyap(Am,Q);
gamma0=1;gamma1=0.5;gamma2=4;

theta0(1)=0;theta1(1)=0;theta2(1)=0;
x1(1)=0;x2(1)=0;
for k=1:totalstep
%     r(k)=1;
    r(k)=sin(0.5*k*delta)+0.3*cos(2*k*delta+4);
    u(k)=theta0(k)*r(k)+theta1(k)*x1(k)+theta2(k)*x2(k);
    
    x1_dot(k)=x2(k);
    x2_dot(k)=0.4*x1(k)+1.8*x2(k)+1*u(k);
    x1(k+1)=x1(k)+x1_dot(k)*delta;
    x2(k+1)=x2(k)+x2_dot(k)*delta;
    
    
    e1(k)=xm1(k)-x1(k);
    e2(k)=xm2(k)-x2(k);
    zeta(k)=0.5*(P(1,2)*e1(k)+P(2,2)*e2(k));
    theta0_dot(k)=zeta(k)*r(k)/(b*gamma0);
    theta1_dot(k)=zeta(k)*x1(k)/(b*gamma1);
    theta2_dot(k)=zeta(k)*x2(k)/(b*gamma2);
    
    theta0(k+1)=theta0(k)+theta0_dot(k)*delta;
    theta1(k+1)=theta1(k)+theta1_dot(k)*delta;
    theta2(k+1)=theta2(k)+theta2_dot(k)*delta;
    
end


plot([0:1:totalstep]*delta,x1,'r');hold on;
plot([0:1:totalstep]*delta,x2,'b');hold on;
plot([0:1:totalstep]*delta,xm1,'y');hold on;
plot([0:1:totalstep]*delta,xm2,'g');hold on;
legend('x1','x2','xm1','xm2');
title('MRAC');