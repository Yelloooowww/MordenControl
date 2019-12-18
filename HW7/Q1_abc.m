clear;clc;
totalStep=1000;
a1=0.3;a2=-0.88;b1=0.9;b2=0.6;%system
for k=1:totalStep
    d(k)=0.1*(rand-0.5);
end
%1-a-A%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%just run with unit step input
y1A=[1:totalStep]*0;
u1A=[1:totalStep]*0;
y1A(1)=0;y1A(2)=0;u1A(1)=0;u1A(2)=1;
for k=1:totalStep-2
    u1A(k+2)=1;
    y1A(k+2)=-a1*y1A(k+1)-a2*y1A(k)+b1*u1A(k+1)+b2*u1A(k)+d(k+2);
end 
figure(1);
plot(y1A);hold on;plot(u1A);
xlabel("k");
ylabel("y(k)");
title("1-a-A (已知G(z),u=1)");

%1-a-B%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%just run with the given input
y1B=[1:totalStep]*0;
u1B=[1:totalStep]*0;
y1B(1)=0;y1B(2)=0;
u1B(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
u1B(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
for k=1:totalStep-2
    u1B(k+2)=sin(6*(k+2)/20)+0.5*cos(6*(k+2)/15+3.2)+0.2*sin(2.57*(k+2)/13+1.36);
    y1B(k+2)=-a1*y1B(k+1)-a2*y1B(k)+b1*u1B(k+1)+b2*u1B(k)+d(k+2);
end 
figure(2);
plot(y1B);hold on;plot(u1B);
xlabel("k");
ylabel("y(k)");
title("1-a-B (已知G(z),u如題目指定)");


%1-b-A%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%use the optimal method to find the system parameter whit dataA
%find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=3:length(y1A)+1
    phiA(k-1,1)=y1A(k-1);
    phiA(k-1,2)=y1A(k-2);
    phiA(k-1,3)=u1A(k-1);
    phiA(k-1,4)=u1A(k-2);
end
%find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp1A=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
tmp2A=[0 0 0 0];
for k=3:totalStep
    for i=1:4
        for j=1:4
            tmp1A(i,j)=tmp1A(i,j)+phiA(k-1,j)*phiA(k-1,i);
        end
        tmp2A(i)=tmp2A(i)+y1A(k)*phiA(k-1,i);
    end
end
thetaA=inv(tmp1A)*tmp2A';
a1A=-thetaA(1);
a2A=-thetaA(2);
b1A=thetaA(3);
b2A=thetaA(4);

%1-b-B%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%use the optimal method to find the system parameter whit dataB
%find matrix phi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=3:length(y1B)+1
    phiB(k-1,1)=y1B(k-1);
    phiB(k-1,2)=y1B(k-2);
    phiB(k-1,3)=u1B(k-1);
    phiB(k-1,4)=u1B(k-2);
end
%find matrix theta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp1B=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
tmp2B=[0 0 0 0];
for k=3:totalStep
    for i=1:4
        for j=1:4
            tmp1B(i,j)=tmp1B(i,j)+phiB(k-1,j)*phiB(k-1,i);
        end
        tmp2B(i)=tmp2B(i)+y1B(k)*phiB(k-1,i);
    end
end
thetaB=inv(tmp1B)*tmp2B';
a1B=-thetaB(1);
a2B=-thetaB(2);
b1B=thetaB(3);
b2B=thetaB(4);

%1-b-C%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%compare the ans
fprintf("Ans from A:\n");
fprintf("a1=%f (error=%2f )\n",a1A,(a1A-a1));
fprintf("a2=%f (error=%2f )\n",a2A,(a2A-a2));
fprintf("b1=%f (error=%2f )\n",b1A,(b1A-b1));
fprintf("b2=%f (error=%2f )\n",b2A,(b2A-b2));
fprintf("Ans from B:\n");
fprintf("a1=%f (error=%2f )\n",a1B,(a1B-a1));
fprintf("a2=%f (error=%2f )\n",a2B,(a2B-a2));
fprintf("b1=%f (error=%2f )\n",b1B,(b1B-b1));
fprintf("b2=%f (error=%2f )\n",b2B,(b2B-b2));

%1-c-A%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pole assignment
poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
const=[1 b1A 0;a1A b2A b1A;a2A 0 b2A];
b=[poly(2)-a1A;poly(3)-a2A;poly(4)];
x=inv(const)*b;
alpha1A=x(1);beta0A=x(2);beta1A=x(3);
%1-c-B%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pole assignment
poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
const=[1 b1B 0;a1B b2B b1B;a2B 0 b2B];
b=[poly(2)-a1B;poly(3)-a2B;poly(4)];
x=inv(const)*b;
alpha1B=x(1);beta0B=x(2);beta1B=x(3);
%the correct one (just for comparison)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pole assignment
poly=conv([1,-0.82],conv([1,-0.5+0.5i],[1,-0.5-0.5i]));%characteristic poly.
const=[1 b1 0;a1 b2 b1;a2 0 b2];
b=[poly(2)-a1;poly(3)-a2;poly(4)];
x=inv(const)*b;
Correctalpha1=x(1);Correctbeta0=x(2);Correctbeta1=x(3);


%1-c-C%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%compare the control design from dataA and dataB
fprintf('Controller A:\n');
fprintf('alpha1=%f (error=%f)\n',alpha1A,abs(Correctalpha1-alpha1A));
fprintf('beta0=%f (error=%f)\n',beta0A,abs(Correctbeta0-beta0A));
fprintf('beta1=%f (error=%f)\n',alpha1A,abs(Correctbeta1-alpha1A));
fprintf('Controller B:\n');
fprintf('alpha1=%f (error=%f)\n',alpha1B,abs(Correctalpha1-alpha1B));
fprintf('beta0=%f (error=%f)\n',beta0B,abs(Correctbeta0-beta0B));
fprintf('beta1=%f (error=%f)\n',alpha1B,abs(Correctbeta1-alpha1B));
%controller A
numA=conv([b1,b2],[beta0A,beta1A]);%C(z)*G(z)
denA=conv([1,a1,a2],[1,alpha1A]);%C(z)*G(z)
fb_numA=numA;%equivalent open loop sys.
fb_denA=[0,numA]+denA;%equivalent open loop sys.
%controller B
numB=conv([b1,b2],[beta0B,beta1B]);%C(z)*G(z)
denB=conv([1,a1,a2],[1,alpha1B]);%C(z)*G(z)
fb_numB=numB;%equivalent open loop sys.
fb_denB=[0,numB]+denB;%equivalent open loop sys.
%the correct one (just for comparison)
numCorrect=conv([b1,b2],[Correctbeta0,Correctbeta1]);%C(z)*G(z)
denCorrect=conv([1,a1,a2],[1,Correctalpha1]);%C(z)*G(z)
fb_numCorrect=numCorrect;%equivalent open loop sys.
fb_denCorrect=[0,numCorrect]+denCorrect;%equivalent open loop sys.

%controller A with unit step input
y3A=[1:totalStep]*0;
u3A=[1:totalStep]*0;
y3A(1)=0;y3A(2)=0;y3A(3)=0;
u3A(1)=1;u3A(2)=1;u3A(3)=1;
for k=1:totalStep-3
    u3A(k+3)=1;
    y3A(k+3)=-fb_denA(2)*y3A(k+2)-fb_denA(3)*y3A(k+1)-fb_denA(4)*y3A(k)+fb_numA(1)*u3A(k+2)+fb_numA(2)*u3A(k+1)+fb_numA(3)*u3A(k)+d(k+3);
end 
%controller B with unit step input
y3B=[1:totalStep]*0;
u3B=[1:totalStep]*0;
y3B(1)=0;y3B(2)=0;y3B(3)=0;
u3B(1)=1;u3B(2)=1;u3B(3)=1;
for k=1:totalStep-3
    u3B(k+3)=1;
    y3B(k+3)=-fb_denB(2)*y3B(k+2)-fb_denB(3)*y3B(k+1)-fb_denB(4)*y3B(k)+fb_numB(1)*u3B(k+2)+fb_numB(2)*u3B(k+1)+fb_numB(3)*u3B(k)+d(k+3);
end 
%the correct controller with unit step input
y3Correct=[1:totalStep]*0;
u3Correct=[1:totalStep]*0;
y3Correct(1)=0;y3Correct(2)=0;y3Correct(3)=0;
u3Correct(1)=1;u3Correct(2)=1;u3Correct(3)=1;
for k=1:totalStep-3
    u3Correct(k+3)=1;
    y3Correct(k+3)=-fb_denCorrect(2)*y3Correct(k+2)-fb_denCorrect(3)*y3Correct(k+1)-fb_denCorrect(4)*y3Correct(k)+fb_numCorrect(1)*u3Correct(k+2)+fb_numCorrect(2)*u3Correct(k+1)+fb_numCorrect(3)*u3Correct(k)+d(k+3);
end 
figure(3);
plot(y3A,'r');hold on;plot(y3B,'b');hold on;plot(y3Correct,'g');hold on;plot(u3B);
xlabel("k");
ylabel("y(k)");
legend('controllerA','controllerB','Correct controller','u=step input');
title("1-c-C (比較A,B設計出的控制器,u=1)");

%controller A with given input
y3A=[1:totalStep]*0;
u3A=[1:totalStep]*0;
y3A(1)=0;y3A(2)=0;y3A(3)=0;
u3A(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
u3A(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
u3A(3)=sin(6*3/20)+0.5*cos(6*3/15+3.2)+0.2*sin(2.57*3/13+1.36);
for k=1:totalStep-3
    u3A(k+3)=sin(6*(k+3)/20)+0.5*cos(6*(k+3)/15+3.2)+0.2*sin(2.57*(k+3)/13+1.36);
    y3A(k+3)=-fb_denA(2)*y3A(k+2)-fb_denA(3)*y3A(k+1)-fb_denA(4)*y3A(k)+fb_numA(1)*u3A(k+2)+fb_numA(2)*u3A(k+1)+fb_numA(3)*u3A(k)+d(k+3);
end 

%controller B with given input
y3B=[1:totalStep]*0;
u3B=[1:totalStep]*0;
y3B(1)=0;y3B(2)=0;y3B(3)=0;
u3B(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
u3B(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
u3B(3)=sin(6*3/20)+0.5*cos(6*3/15+3.2)+0.2*sin(2.57*3/13+1.36);
for k=1:totalStep-3
    u3B(k+3)=sin(6*(k+3)/20)+0.5*cos(6*(k+3)/15+3.2)+0.2*sin(2.57*(k+3)/13+1.36);
    y3B(k+3)=-fb_denB(2)*y3B(k+2)-fb_denB(3)*y3B(k+1)-fb_denB(4)*y3B(k)+fb_numB(1)*u3B(k+2)+fb_numB(2)*u3B(k+1)+fb_numB(3)*u3B(k)+d(k+3);
end 
%the correct controller with given input
y3Correct=[1:totalStep]*0;
u3Correct=[1:totalStep]*0;
y3Correct(1)=0;y3Correct(2)=0;y3Correct(3)=0;
u3Correct(1)=sin(6*1/20)+0.5*cos(6*1/15+3.2)+0.2*sin(2.57*1/13+1.36);
u3Correct(2)=sin(6*2/20)+0.5*cos(6*2/15+3.2)+0.2*sin(2.57*2/13+1.36);
u3Correct(3)=sin(6*3/20)+0.5*cos(6*3/15+3.2)+0.2*sin(2.57*3/13+1.36);
for k=1:totalStep-3
    u3Correct(k+3)=sin(6*(k+3)/20)+0.5*cos(6*(k+3)/15+3.2)+0.2*sin(2.57*(k+3)/13+1.36);
    y3Correct(k+3)=-fb_denCorrect(2)*y3Correct(k+2)-fb_denCorrect(3)*y3Correct(k+1)-fb_denCorrect(4)*y3Correct(k)+fb_numCorrect(1)*u3Correct(k+2)+fb_numCorrect(2)*u3Correct(k+1)+fb_numCorrect(3)*u3Correct(k)+d(k+3);
end 
figure(4);
plot(y3A,'r');hold on;plot(y3B,'b');hold on;plot(y3Correct,'g');plot(u3B);
xlabel("k");
ylabel("y(k)");
legend('controllerA','controllerB','Correct controller','u');
title("1-c-C (比較A,B設計出的控制器)");






