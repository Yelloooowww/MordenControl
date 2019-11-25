clear;clc;
Data=textread('hw6Data.txt','%f');
y=zeros(1,length(Data)/2);
u=zeros(1,length(Data)/2);
k=1;
for i=1:length(Data)
    if mod(i,2)==0
        fprintf('odd %f \n',i);
        u(k)=Data(i);
        k=k+1;
    else
        fprintf('even %f \n',i);
        y(k)=Data(i);
    end
end