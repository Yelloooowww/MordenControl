%adaptive
clear;clc;
totalStep=1000;
step1=5;
step2=900;
a1=0.3;a2=-0.88;b1=0.9;b2=0.6;%system
for k=1:totalStep
    d(k)=0.01*(rand-0.5);
end


yB=[1:totalStep]*0;
uB=[1:totalStep]*0;
yB(1)=0;yB(2)=0;
uB(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
uB(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
%step 1~step1 (free)
for k=1:step1
    uB(k+2)=sin(6*(k+2)/20)+0.5*cos(6*(k+2)/15+3.2)+0.2*sin(2.57*(k+2)/13+1.36);
    yB(k+2)=-a1*yB(k+1)-a2*yB(k)+b1*uB(k+1)+b2*uB(k)+d(k+2);
end 
fprintf("STEP¡@¢°¡@¢Ò¢Ý¢Ü¢Ó¡@k=%f\n",k);
%find a1,a2,b1,b2
%find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=3:k+2
    phiB(i-1,1)=yB(i-1);
    phiB(i-1,2)=yB(i-2);
    phiB(i-1,3)=uB(i-1);
    phiB(i-1,4)=uB(i-2);
end
%find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp1B=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
tmp2B=[0 0 0 0];
for n=3:k+2
    for i=1:4
        for j=1:4
            tmp1B(i,j)=tmp1B(i,j)+phiB(n-1,j)*phiB(n-1,i);
        end
        tmp2B(i)=tmp2B(i)+yB(n)*phiB(n-1,i);
    end
end
thetaB=inv(tmp1B)*tmp2B';
a1B=-thetaB(1);
a2B=-thetaB(2);
b1B=thetaB(3);
b2B=thetaB(4);
fprintf("Ans from B: k=%d\n",k);
fprintf("a1=%f (error=%2f )\n",a1B,(a1B-a1));
fprintf("a2=%f (error=%2f )\n",a2B,(a2B-a2));
fprintf("b1=%f (error=%2f )\n",b1B,(b1B-b1));
fprintf("b2=%f (error=%2f )\n",b2B,(b2B-b2));
%pole assignment
poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
const=[1 b1B 0;a1B b2B b1B;a2B 0 b2B];
b=[poly(2)-a1B;poly(3)-a2B;poly(4)];
x=inv(const)*b;
alpha1B=x(1);beta0B=x(2);beta1B=x(3);
%controller 
numB=conv([b1,b2],[beta0B,beta1B]);%C(z)*G(z)
denB=conv([1,a1,a2],[1,alpha1B]);%C(z)*G(z)
fb_numB=numB;%equivalent open loop sys.
fb_denB=[0,numB]+denB;%equivalent open loop sys.

uB(k+3)=sin(6*(k+3)/20)+0.5*cos(6*(k+3)/15+3.2)+0.2*sin(2.57*(k+3)/13+1.36);
yB(k+3)=-fb_denB(2)*yB(k+2)-fb_denB(3)*yB(k+1)-fb_denB(4)*yB(k)+fb_numB(1)*uB(k+2)+fb_numB(2)*uB(k+1)+fb_numB(3)*uB(k)+d(k+3);
fprintf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

%step1+1 ~ step2 (get data)
for k=step1:step2
    %find a1,a2,b1,b2
    %find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=3:k+3
        phiB(i-1,1)=yB(i-1);
        phiB(i-1,2)=yB(i-2);
        phiB(i-1,3)=uB(i-1);
        phiB(i-1,4)=uB(i-2);
    end
    %find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tmp1B=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
    tmp2B=[0 0 0 0];
    for n=3:k+3
        for i=1:4
            for j=1:4
                tmp1B(i,j)=tmp1B(i,j)+phiB(n-1,j)*phiB(n-1,i);
            end
            tmp2B(i)=tmp2B(i)+yB(n)*phiB(n-1,i);
        end
    end
    thetaB=inv(tmp1B)*tmp2B';
    if abs(-thetaB(1)-a1B)>1
        a1B=-thetaB(1);
        a2B=-thetaB(2);
        b1B=thetaB(3);
        b2B=thetaB(4);
        fprintf("Ans from B: k=%d\n",k);
        fprintf("a1=%f (error=%2f )\n",a1B,(a1B-a1));
        fprintf("a2=%f (error=%2f )\n",a2B,(a2B-a2));
        fprintf("b1=%f (error=%2f )\n",b1B,(b1B-b1));
        fprintf("b2=%f (error=%2f )\n",b2B,(b2B-b2));

        %pole assignment
        poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
        const=[1 b1B 0;a1B b2B b1B;a2B 0 b2B];
        b=[poly(2)-a1B;poly(3)-a2B;poly(4)];
        x=inv(const)*b;
        alpha1B=x(1);beta0B=x(2);beta1B=x(3);
        %controller 
        numB=conv([b1,b2],[beta0B,beta1B]);%C(z)*G(z)
        denB=conv([1,a1,a2],[1,alpha1B]);%C(z)*G(z)
        fb_numB=numB;%equivalent open loop sys.
        fb_denB=[0,numB]+denB;%equivalent open loop sys.
    end
    %run~~~
    uB(k+3)=sin(6*(k+3)/20)+0.5*cos(6*(k+3)/15+3.2)+0.2*sin(2.57*(k+3)/13+1.36);
    yB(k+3)=-fb_denB(2)*yB(k+2)-fb_denB(3)*yB(k+1)-fb_denB(4)*yB(k)+fb_numB(1)*uB(k+2)+fb_numB(2)*uB(k+1)+fb_numB(3)*uB(k)+d(k+3);
end

%step2+1~end 
for k=step2+1:totalStep-3
    uB(k+3)=sin(6*(k+3)/20)+0.5*cos(6*(k+3)/15+3.2)+0.2*sin(2.57*(k+3)/13+1.36);
    yB(k+3)=-fb_denB(2)*yB(k+2)-fb_denB(3)*yB(k+1)-fb_denB(4)*yB(k)+fb_numB(1)*uB(k+2)+fb_numB(2)*uB(k+1)+fb_numB(3)*uB(k)+d(k+3);
end 
figure(1);
plot(yB);
figure(2);
plot(uB);