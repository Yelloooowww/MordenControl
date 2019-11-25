clear;clc;

totaltime=10;
delta=0.001;
totalstep=totaltime/delta;

m=2;
m_hat=[0:1:totalstep-1]*0.000001;
yarray=m_hat;
u=m_hat;
for i=1:totalstep
    disturbance=0.001*(-1+rand);%-0.2<d<0.2
    noise=0.0001*(-1+rand);%-0.2<d<0.2
    
    u(i)=m_hat(i)*(yarray(i)+noise)+disturbance;
    yarray(i+1)=u(i)/m;
    
    num(i)=(u(i)-m_hat(i)*yarray(i))*yarray(i);
    m_hat_dot(i)=num(i)/(sum(yarray.*yarray)*delta);
    m_hat(i+1)=m_hat(i)+m_hat_dot(i)*delta;
    
end


plot(m_hat);
title('On line');
xlabel('time');
ylabel('m_h_a_t');
m_error=(m-m_hat(1000));