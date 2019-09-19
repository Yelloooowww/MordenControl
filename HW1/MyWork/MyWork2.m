clear;clc;
% A=[-2 0;0 -2];%star
A=[-2 0;0 -3];%node
% A=[-2 0;0 3];%saddle
% A=[0 2;-2 0];%center
% A=[-2 1;-1 -2]%focus

num=8;theta=0; %total of the different kind of initial condition
datasize=1000;
for j=1:8
    theta=j*(2*pi/num);
    x1array(1)=real(datasize*exp(1i*theta)); 
    x2array(1)=imag(datasize*exp(1i*theta));
    
    for i=1:(datasize-1)
        x(1)=x1array(i); x(2)=x2array(i);
        xNext=FindNext_A(x,0.01,A);
        x1array(i+1)=xNext(1);
        x2array(i+1)=xNext(2);
    end
    
    xlabel('x(1)');
    ylabel('x(2)');
    plot(x1array,x2array);
    hold on;
    
    
    
    
    
    
end

