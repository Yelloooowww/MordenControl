clear;clc;
%read data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data=textread('hw6Data.txt','%f');
y=zeros(1,length(Data)/2);u=zeros(1,length(Data)/2);k=1;
for i=1:length(Data)
    if mod(i,2)==0
        y(k)=Data(i);
        k=k+1;
    else
        u(k)=Data(i);
    end
end
%find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=3:length(y)+1
    phi(k-1,1)=y(k-1);
    phi(k-1,2)=y(k-2);
    phi(k-1,3)=u(k-1);
    phi(k-1,4)=u(k-2);
end
%find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmpA=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
tmpB=[0 0 0 0];
for k=3:151
    for i=1:4
        for j=1:4
            tmpA(i,j)=tmpA(i,j)+phi(k-1,j)*phi(k-1,i);
        end
        tmpB(i)=tmpB(i)+y(k)*phi(k-1,i);
    end
end
theta=inv(tmpA)*tmpB';
a1=-theta(1);
a2=-theta(2);
b1=theta(3);
b2=theta(4);
fprintf('a1=%f a2=%f b1=%f b2=%f \n',a1,a2,b1,b2);
%check the answer%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yy(1)=y(1);yy(2)=y(2);
for k=3:151
    yy(k)=-a1*yy(k-1)-a2*yy(k-2)+b1*u(k-1)+b2*u(k-2);
end
plot(y,'r');
hold on;
plot(yy,'g');
legend('from data','simulation');
title('check the answer');