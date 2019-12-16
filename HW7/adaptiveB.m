%online adaptive control
%(unit step input)
clear;clc;
totalStep=1000;step1=100;step2=900;
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
r(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
r(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
r(3)=sin(6*3/20)+0.5*cos(6*3/15+3.2)+0.2*sin(2.57*3/13+1.36);
u(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
u(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
u(3)=sin(6*3/20)+0.5*cos(6*3/15+3.2)+0.2*sin(2.57*3/13+1.36);
for k=1:step1
    r(k+2)=sin(6*(k+2)/20)+0.5*cos(6*(k+2)/15+3.2)+0.2*sin(2.57*(k+2)/13+1.36);
    u(k+2)=r(k+2);
    y(k+2)=-a1*y(k+1)-a2*y(k)+b1*u(k+1)+b2*u(k)+d(k+2);
    
end 

%first time to find the system parameter
%find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=3:step1
    phiB(k-1,1)=y(k-1);
    phiB(k-1,2)=y(k-2);
    phiB(k-1,3)=u(k-1);
    phiB(k-1,4)=u(k-2);
end
%find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp1B=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
tmp2B=[0 0 0 0];
for k=3:step1
    for i=1:4
        for j=1:4
            tmp1B(i,j)=tmp1B(i,j)+phiB(k-1,j)*phiB(k-1,i);
        end
        tmp2B(i)=tmp2B(i)+y(k)*phiB(k-1,i);
    end
end
thetaB=inv(tmp1B)*tmp2B';
a1B=-thetaB(1);
a2B=-thetaB(2);
b1B=thetaB(3);
b2B=thetaB(4);
fprintf("a1=%f (error=%2f )\n",a1B,(a1B-a1));
fprintf("a2=%f (error=%2f )\n",a2B,(a2B-a2));
fprintf("b1=%f (error=%2f )\n",b1B,(b1B-b1));
fprintf("b2=%f (error=%2f )\n",b2B,(b2B-b2));

%design C(z) with optimal parameter (pole assignment)
poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
const=[1 b1B 0;a1B b2B b1B;a2B 0 b2B];
b=[poly(2)-a1B;poly(3)-a2B;poly(4)];
x=inv(const)*b;
alpha1B=x(1);beta0B=x(2);beta1B=x(3);%C(z) with optimal parameter
fprintf("alpha1=%f (err=%f) \n",alpha1B,abs(Correctalpha1-alpha1B));
fprintf("beta0=%f (err=%f) \n",beta1B,abs(Correctbeta0-beta0B));
fprintf("beta1=%f (err=%f) \n",beta1B,abs(Correctbeta1-beta1B));


%k=step1+1~step2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%online adaptive 
%close loop control & redesign C(z)
for k=step1+1:step2
    fprintf("Now Step:k=%d !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n",k);
    r(k+1)=sin(6*(k+1)/20)+0.5*cos(6*(k+1)/15+3.2)+0.2*sin(2.57*(k+1)/13+1.36);
    e(k+1)=r(k+1)-y(k+1);
    u(k+1)=(-alpha1B*u(k)+beta0B*e(k+1)+beta1B*e(k));
    y(k+2)=-a1*y(k+1)-a2*y(k)+b1*u(k+1)+b2*u(k)+d(k+2);
    
    
    
    %redesign C(z)
    %find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=3:k
        phiB(i-1,1)=y(i-1);
        phiB(i-1,2)=y(i-2);
        phiB(i-1,3)=u(i-1);
        phiB(i-1,4)=u(i-2);
    end
    %find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tmp1B=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
    tmp2B=[0 0 0 0];
    for m=3:k
        for i=1:4
            for j=1:4
                tmp1B(i,j)=tmp1B(i,j)+phiB(m-1,j)*phiB(m-1,i);
            end
            tmp2B(i)=tmp2B(i)+y(m)*phiB(m-1,i);
        end
    end
    thetaB=inv(tmp1B)*tmp2B';
    a1B=-thetaB(1);
    a2B=-thetaB(2);
    b1B=thetaB(3);
    b2B=thetaB(4);
    fprintf("a1=%f (error=%2f )\n",a1B,(a1B-a1));
    fprintf("a2=%f (error=%2f )\n",a2B,(a2B-a2));
    fprintf("b1=%f (error=%2f )\n",b1B,(b1B-b1));
    fprintf("b2=%f (error=%2f )\n",b2B,(b2B-b2));

    %design C(z)  (pole assignment)
    poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
    const=[1 b1B 0;a1B b2B b1B;a2B 0 b2B];
    b=[poly(2)-a1B;poly(3)-a2B;poly(4)];
    x=inv(const)*b;
    alpha1B=x(1);beta0B=x(2);beta1B=x(3);%C(z) with optimal parameter
    fprintf("alpha1=%f (err=%f) \n",alpha1B,abs(Correctalpha1-alpha1B));
    fprintf("beta0=%f (err=%f) \n",beta1B,abs(Correctbeta0-beta0B));
    fprintf("beta1=%f (err=%f) \n",beta1B,abs(Correctbeta1-beta1B));
end 

%k=step2+1~end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%close loop control only
for k=step2+1:totalStep-2
    r(k+1)=sin(6*(k+1)/20)+0.5*cos(6*(k+1)/15+3.2)+0.2*sin(2.57*(k+1)/13+1.36);
    e(k+1)=r(k+1)-y(k+1);
    u(k+1)=(-alpha1B*u(k)+beta0B*e(k+1)+beta1B*e(k));
    y(k+2)=-a1*y(k+1)-a2*y(k)+b1*u(k+1)+b2*u(k)+d(k+2);
end

plot(y,'r');hold on;plot(r,'g');
xlabel("k");
legend('y','r=©¶ªi');
title("online adaptive control");