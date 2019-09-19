x = [cos(pi/7),sin(pi/7)]';
mu = 0.8;
x1arr=[0,0,0,0]';
x2arr=x1arr;    tarr =x1arr;
delt = 0.01;
for i = 1:5300
    xN = myFindNextPos(x,mu,delt);
    x1arr(i)=xN(1);
    x2arr(i)=xN(2);
    tarr(i) =delt*i;
    x = xN;
end
figure(1); plot(x1arr,x2arr,'b');hold on;
    