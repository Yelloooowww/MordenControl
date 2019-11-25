clear;clc;
a1= -2.0388;
a2= -(-0.9808);
b1=0.7070;
b2=0.2356;

Data=textread('hw6Data.txt','%f');
y=zeros(1,length(Data)/2);
u=zeros(1,length(Data)/2);
k=1;
for i=1:length(Data)
    if mod(i,2)==0
        u(k)=Data(i);
        k=k+1;
    else
        y(k)=Data(i);
    end
end

yy(1)=y(1);
yy(2)=y(2);
for k=3:151
    yy(k)=-a1*yy(k-1)-a2*yy(k-2)+b1*u(k-1)+b2*u(k-2);
end

plot(u,'g');
hold on;
plot(y,'r');