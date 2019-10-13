clear;clc;
A=[0 1;-1 9];%ID:104303206 ----> a=1,b=9
B=[0;1];
Q=[1 0;0 1];
R=1;
[K_optimal,P]=lqr(A,B,Q,R);
num=8;theta=pi/4; %different initial condition
datasize=10000;
J(num,datasize)=zeros;%init.

for k=1:2
    if k==1
        K=[103 13];%the ans of Q1
    else
        K=K_optimal;
    end
    A_=A-B*K;%feedback control
    
    for j=1:num %different initial condition
        theta=j*(2*pi/num);
        x1array(1)=real(datasize*exp(1i*theta)); 
        x2array(1)=imag(datasize*exp(1i*theta));

        for i=1:(datasize-1) %simulation
            x(1)=x1array(i); x(2)=x2array(i);
            xNext=RungeKutta(x,0.01,A_);
            x1array(i+1)=xNext(1);
            x2array(i+1)=xNext(2);
            
            tmp=(x*(Q+K'*R*K)*x')*0.01;%J=int_0^inf( x'*Q*x+u*R*u)dt
            J(j,i+1)=J(j,i)+tmp;
        end

        if k==1
            plot(J(j,:),'--');%without optimal
            title('J (without optimal)');
        else
            plot(J(j,:));%optimal
            title('J (optimal)');
        end
        hold on;
    end
    title('J (comparision)');
end