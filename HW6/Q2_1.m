clear;clc;

totaltime=10;
delta=0.01;
totalstep=totaltime/delta;

m=200;
m_hat=[0:1:totalstep-1]*0.000000000000001;
yarray=m_hat;
u=m_hat;
for i=1:totalstep
    disturbance=(-1+rand);%-0.2<d<0.2
    noise=(-1+rand);%-0.2<d<0.2
    
    num=delta*sum(yarray.*u);
    den=delta*sum(yarray.*yarray);
    m_hat(i)=num/den;
    u(i)=m_hat(i)*(yarray(i)+noise)+disturbance;
    
    yarray(i+1)=u(i)/m;
end;


m_error=(m-m_hat(1000));

plot([0:1:totalstep-1]*delta,m_hat);
title('Off line');
xlabel('time');
ylabel('m_h_a_t');