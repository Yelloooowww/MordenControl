clear;clc;
num=8;
v=zeros(10000,3);
for n=1:2 %x(0) inside or outside of the limit cycle
    for j=1:num % 8 kinds of x(0)
        theta=j*(2*pi/num);
        x1array(1)=real(n*exp(1i*theta)); 
        x2array(1)=imag(n*exp(1i*theta));

        for i=1:10000-1
            x(1)=x1array(i); x(2)=x2array(i);
            v(i)=0.5*(x(1)*x(1)+x(2)*x(2));%v(x1,x2)=0.5(x1^2+x2^2)
            x1dot=x(2)-(4*x(1)*x(1)+x(2)*x(2)-4)*x(1);
            x2dot=-x(1)-(4*x(1)*x(1)+x(2)*x(2)-4)*x(2);
            x1array(i+1)=x(1)+x1dot*0.001;
            x2array(i+1)=x(2)+x2dot*0.001;
        end

        xlabel('x(1)');
        ylabel('x(2)');
        zlabel('v(x)');
        time=1:10000-1;
        xt=x1array(time);
        yt=x2array(time);
        zt=v(time);
        plot3(xt,yt,zt);
        grid on;
        title('Q1');
        hold on;
    end
end