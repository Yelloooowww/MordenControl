%MRAC
clear;clc;
totaltime=1500;
delta=0.01;
totalstep=totaltime/delta;
%select para.
% Q=[0.00001 0 0;0 0.00001 0;0 0 100000];
Q=[0.0001 0 0;0 1 0;0 0 1000];
pole=conv([1 13],conv([1 12],[1 11]));
Am=[0 1 0;0 0 1;-pole(4) -pole(3) -pole(2)];bm=1;%model
A=[0 1 0;0 0 1;-12 -4 -3];b=1;%real sys.
P=lyap(Am,Q);
gamma0=1;gamma1=1;gamma2=1;gamma3=1;

%model
xm1(1)=0;xm2(1)=0;xm3(1)=0;
for k=1:totalstep
    r(k)=1;
%     r(k)=sin(0.5*k*delta)+0.3*cos(2*k*delta+4);
    xm1_dot(k)=xm2(k);
    xm2_dot(k)=xm3(k);
    xm3_dot(k)=Am(3,1)*xm1(k)+Am(3,2)*xm2(k)+Am(3,3)*xm3(k)+bm*r(k);
    xm1(k+1)=xm1(k)+xm1_dot(k)*delta;
    xm2(k+1)=xm2(k)+xm2_dot(k)*delta;
    xm3(k+1)=xm3(k)+xm3_dot(k)*delta;
end

%real sys.
theta0(1)=0;theta1(1)=0;theta2(1)=0;theta3(1)=0;
x1(1)=0;x2(1)=0;x3(1)=0;
tmp=0;
for k=1:totalstep
    
    if k<=500
        u(k)=theta0(k)*r(k)+theta1(k)*x1(k)+theta2(k)*x2(k)+theta3(k)*x3(k);
    end    
    %off line
    if k>500
        if mod(k,30000)<500
            u(k)=theta0(k)*r(k)+theta1(k)*x1(k)+theta2(k)*x2(k)+theta3(k)*x3(k);
        else
            u(k)=u(k-1);
        end
    end
    
    x1_dot(k)=x2(k);
    x2_dot(k)=x3(k);
    x3_dot(k)=A(3,1)*x1(k)+A(3,2)*x2(k)+A(3,3)*x3(k)+1*u(k);
    x1(k+1)=x1(k)+x1_dot(k)*delta;
    x2(k+1)=x2(k)+x2_dot(k)*delta;
    x3(k+1)=x3(k)+x3_dot(k)*delta;
    
    
    e1(k)=xm1(k)-x1(k);
    e2(k)=xm2(k)-x2(k);
    e3(k)=xm3(k)-x3(k);
    zeta(k)=0.5*(P(1,3)*e1(k)+P(2,3)*e2(k)+P(3,3)*e3(k));
    theta0_dot(k)=zeta(k)*r(k)/(b*gamma0);
    theta1_dot(k)=zeta(k)*x1(k)/(b*gamma1);
    theta2_dot(k)=zeta(k)*x2(k)/(b*gamma2);
    theta3_dot(k)=zeta(k)*x3(k)/(b*gamma3);
    
    theta0(k+1)=theta0(k)+theta0_dot(k)*delta;
    theta1(k+1)=theta1(k)+theta1_dot(k)*delta;
    theta2(k+1)=theta2(k)+theta2_dot(k)*delta;
    theta3(k+1)=theta3(k)+theta3_dot(k)*delta;
    
end

figure(1);
plot([0:1:totalstep]*delta,x1,'r');hold on;
plot([0:1:totalstep]*delta,xm1,'c');hold on;
legend('x1','xm1');
title('MRAC_s_t_e_p _i_n_p_u_t (OFF line)');