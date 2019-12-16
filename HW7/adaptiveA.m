%online adaptive control
%(unit step input)
clear;clc;
totalStep=1000;step1=50;step2=900;
a1=0.3;a2=-0.88;b1=0.9;b2=0.6;%system
Correctalpha1=4.435315;%C(z) design from the real sys.
Correctbeta0=-7.283683;
Correctbeta1=5.821795;
for k=1:totalStep
    d(k)=0.01*(rand-0.5);
end

y=[1:totalStep]*0;
u=[1:totalStep]*0;
r=[1:totalStep]*0;
e=[1:totalStep]*0;

%k=1~step1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%just run with unit step input
r(1)=0;r(2)=1;r(3)=1;%unit stpe input
u(1)=0;u(2)=1;u(3)=1;
for k=1:step1
    r(k+2)=1;%unit stpe input
    u(k+2)=r(k+2);
    y(k+2)=-a1*y(k+1)-a2*y(k)+b1*u(k+1)+b2*u(k)+d(k+2);
    
end 

%first time to find the system parameter
%find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=3:step1
    phiA(k-1,1)=y(k-1);
    phiA(k-1,2)=y(k-2);
    phiA(k-1,3)=u(k-1);
    phiA(k-1,4)=u(k-2);
end
%find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp1A=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
tmp2A=[0 0 0 0];
for k=3:step1
    for i=1:4
        for j=1:4
            tmp1A(i,j)=tmp1A(i,j)+phiA(k-1,j)*phiA(k-1,i);
        end
        tmp2A(i)=tmp2A(i)+y(k)*phiA(k-1,i);
    end
end
thetaA=inv(tmp1A)*tmp2A';
a1A=-thetaA(1);
a2A=-thetaA(2);
b1A=thetaA(3);
b2A=thetaA(4);
fprintf("a1=%f (error=%2f )\n",a1A,(a1A-a1));
fprintf("a2=%f (error=%2f )\n",a2A,(a2A-a2));
fprintf("b1=%f (error=%2f )\n",b1A,(b1A-b1));
fprintf("b2=%f (error=%2f )\n",b2A,(b2A-b2));

%design C(z) with optimal parameter (pole assignment)
poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
const=[1 b1A 0;a1A b2A b1A;a2A 0 b2A];
b=[poly(2)-a1A;poly(3)-a2A;poly(4)];
x=inv(const)*b;
alpha1A=x(1);beta0A=x(2);beta1A=x(3);%C(z) with optimal parameter
fprintf("alpha1=%f (err=%f) \n",alpha1A,abs(Correctalpha1-alpha1A));
fprintf("beta0=%f (err=%f) \n",beta1A,abs(Correctbeta0-beta0A));
fprintf("beta1=%f (err=%f) \n",beta1A,abs(Correctbeta1-beta1A));


%k=step1+1~step2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%online adaptive 
%close loop control & redesign C(z)
for k=step1+1:step2
    fprintf("Now Step:k=%d !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n",k);
    r(k+1)=1;
    e(k+1)=r(k+1)-y(k+1);
    u(k+1)=(-alpha1A*u(k)+beta0A*e(k+1)+beta1A*e(k));
    y(k+2)=-a1*y(k+1)-a2*y(k)+b1*u(k+1)+b2*u(k)+d(k+2);
    
    
    
    %redesign C(z)
    %find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=3:k
        phiA(i-1,1)=y(i-1);
        phiA(i-1,2)=y(i-2);
        phiA(i-1,3)=u(i-1);
        phiA(i-1,4)=u(i-2);
    end
    %find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tmp1A=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
    tmp2A=[0 0 0 0];
    for m=3:k
        for i=1:4
            for j=1:4
                tmp1A(i,j)=tmp1A(i,j)+phiA(m-1,j)*phiA(m-1,i);
            end
            tmp2A(i)=tmp2A(i)+y(m)*phiA(m-1,i);
        end
    end
    thetaA=inv(tmp1A)*tmp2A';
    a1A=-thetaA(1);
    a2A=-thetaA(2);
    b1A=thetaA(3);
    b2A=thetaA(4);
    fprintf("a1=%f (error=%2f )\n",a1A,(a1A-a1));
    fprintf("a2=%f (error=%2f )\n",a2A,(a2A-a2));
    fprintf("b1=%f (error=%2f )\n",b1A,(b1A-b1));
    fprintf("b2=%f (error=%2f )\n",b2A,(b2A-b2));

    %design C(z)  (pole assignment)
    poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
    const=[1 b1A 0;a1A b2A b1A;a2A 0 b2A];
    b=[poly(2)-a1A;poly(3)-a2A;poly(4)];
    x=inv(const)*b;
    alpha1A=x(1);beta0A=x(2);beta1A=x(3);%C(z) with optimal parameter
    fprintf("alpha1=%f (err=%f) \n",alpha1A,abs(Correctalpha1-alpha1A));
    fprintf("beta0=%f (err=%f) \n",beta1A,abs(Correctbeta0-beta0A));
    fprintf("beta1=%f (err=%f) \n",beta1A,abs(Correctbeta1-beta1A));
end 

%k=step2+1~end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%close loop control only
for k=step2+1:totalStep-2
    r(k+1)=1;
    e(k+1)=r(k+1)-y(k+1);
    u(k+1)=(-alpha1A*u(k)+beta0A*e(k+1)+beta1A*e(k));
    y(k+2)=-a1*y(k+1)-a2*y(k)+b1*u(k+1)+b2*u(k)+d(k+2);
end

plot(y,'r');hold on;plot(r,'g');
xlabel("k");
legend('y','r=unit step');
title("online adaptive control");