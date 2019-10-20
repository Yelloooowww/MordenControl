clear;clc;
num=8;
for j=1:num
    theta=j*(2*pi/num);
    x1array(1)=real(3*exp(1i*theta)); 
    x2array(1)=imag(3*exp(1i*theta));

    for i=1:10000
        x(1)=x1array(i); x(2)=x2array(i);
        x1dot=x(2)-(4*x(1)*x(1)+x(2)*x(2)-4)*x(1);
        x2dot=-x(1)-(4*x(1)*x(1)+x(2)*x(2)-4)*x(2);
        x1array(i+1)=x(1)+x1dot*0.001;
        x2array(i+1)=x(2)+x2dot*0.001;
    end

    xlabel('x(1)');
    ylabel('x(2)');
    plot(x1array,x2array);
    title('Q1');
    hold on;
end
