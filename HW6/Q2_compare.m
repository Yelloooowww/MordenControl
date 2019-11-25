clear;clc;
totaltime=10;
delta=0.01;
totalstep=totaltime/delta;

m=20;
m_hat1(1)=15;
u(1)=1;
%make n,d
for i=1:totalstep
    disturbance(i)=0.1*(-1+rand);
    noise(i)=0.1*sin(25*i)+0.5*cos(100*i+pi);
end

% use m
for i=1:totalstep    
    yarray(i)=(u(i)/m)+noise(i);
    
    num=delta*sum(yarray.*u);
    den=delta*sum(yarray.*yarray);
    m_hat1(i+1)=(num/den);
    u(i+1)=m_hat1(i+1)*(yarray(i))+disturbance(i);
end;

%clear var.
yarray=[0:1:totalstep-1]*0;
u=yarray;
m_hat2(1)=15;
u(1)=1;

%use m_dot
for i=1:totalstep
    yarray(i)=(u(i)/m)+noise(i);
    
    num=(u(i)-m_hat2(i)*yarray(i))*yarray(i);
    den=delta*sum(yarray.*yarray);
    m_hat_dot(i)=(num/den);
    m_hat2(i+1)=m_hat2(i)+m_hat_dot(i)*delta;
    u(i+1)=m_hat2(i+1)*(yarray(i))+disturbance(i);
end;

plot([0:1:totalstep]*delta,m_hat1,'r');
hold on;
plot([0:1:totalstep]*delta,m_hat2,'b');
title('m_h_a_t');