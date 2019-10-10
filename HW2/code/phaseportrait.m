clear;clc;
A_=[0 1;(-1-103) (9-13)]%HW2 Q1

num=8;theta=0; %total of the different kind of initial condition
datasize=1000;
for j=1:num
    theta=j*(2*pi/num);
    x1array(1)=real(datasize*exp(1i*theta)); 
    x2array(1)=imag(datasize*exp(1i*theta));
    
    for i=1:(datasize-1)
        x(1)=x1array(i); x(2)=x2array(i);
        xNext=RungeKutta(x,0.01,A_);
        x1array(i+1)=xNext(1);
        x2array(i+1)=xNext(2);
    end
    
    xlabel('x(1)');
    ylabel('x(2)');
    title('HW2 Q1');
    plot(x1array,x2array);
    hold on;
end