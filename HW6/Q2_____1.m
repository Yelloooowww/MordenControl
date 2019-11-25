clear;clc;

totaltime=10;
delta=0.01;
totalstep=totaltime/delta;

m=20;
m_hat(1)=10;
u(1)=1;
for i=1:totalstep
    disturbance=0.02*(-1+rand);%-0.2<d<0.2
    noise=0.02*(-1+rand);%-0.2<d<0.2
    
    yarray(i)=(u(i)/m)+noise;
    
    num=delta*sum(yarray.*u);
    den=delta*sum(yarray.*yarray);
    m_hat(i+1)=(num/den);
    u(i+1)=m_hat(i+1)*(yarray(i))+disturbance;
    
end;


m_error=(m-m_hat(1000));

plot([0:1:totalstep]*delta,m_hat);
title('Off line');
xlabel('time');
ylabel('m_h_a_t');