clear;clc;
totaltime=100;
delta=0.01;
totalstep=totaltime/delta;

pole1=[1 0];pole2=[1 0.1-2i];pole3=[1 0.1+2i];
char_poly=conv(pole1,conv(pole2,pole3));%(s+p1)*(s+p2)*(s+p3)=0
A=[0 1 0;0 0 1;-char_poly(4) -char_poly(3) -char_poly(2)];%x_dot=A*x

IC=[1,1,1;-1,-1,-1];%initial condition
for i=1:2
    x1=[1:totalstep]*0;x2=x1;x3=x1;
    x1_dot=x1;x2_dot=x1;x3_dot=x1;
    x1(1)=IC(i,1);
    x2(1)=IC(i,2);
    x3(1)=IC(i,3);
    fprintf('init. condidtion:(%d,%d,%d)\n',x1(1),x2(1),x3(1));
    for k=1:totalstep
        x1_dot(k)=x2(k);
        x2_dot(k)=x3(k);
        x3_dot(k)=A(3,1)*x1(k)+A(3,2)*x2(k)+A(3,3)*x3(k);
        x1(k+1)=x1(k)+x1_dot(k)*delta;
        x2(k+1)=x2(k)+x2_dot(k)*delta;
        x3(k+1)=x3(k)+x3_dot(k)*delta;
    end

    if mod(i,2)==1
        figure(1);
        plot([0:1:totalstep]*delta,x1,'r');hold on;
        plot([0:1:totalstep]*delta,x2,'b');hold on;
        plot([0:1:totalstep]*delta,x3,'g');hold on;
        legend('x1','x2','x3');
        str1=num2str(pole1(2));str2=num2str(pole2(2));str3=num2str(pole3(2));
        str=['s=-(' str1 '),-(' str2 '),-(' str3 ')'];
        title(str);
    end

    figure(2);
    time=1:totalstep-1;
    xt=x1(time);yt=x2(time);zt=x2(time);
    plot3(xt,yt,zt);hold on;
    text(0,0,0,'(0,0,0)');text(1,1,1,'(1,1,1)');text(-1,-1,-1,'(-1,-1,-1)');
    grid on;
end

title(str);
fprintf(str);