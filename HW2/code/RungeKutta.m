function xNew=RungeKutta(x_0,delta,A)
k1=[0 0]';
k2=k1;k3=k1;k4=k1;tmp=k1;xNew=k1;

k1(1)=A(1,1)*x_0(1)+A(1,2)*x_0(2);
k1(2)=A(2,1)*x_0(1)+A(2,2)*x_0(2);
tmp(1)=x_0(1)+k1(1)*(delta/2);
tmp(2)=x_0(2)+k1(2)*(delta/2);
k2(1)=A(1,1)*tmp(1)+A(1,2)*tmp(2);
k2(2)=A(2,1)*tmp(1)+A(2,2)*tmp(2);
tmp(1)=x_0(1)+k2(1)*(delta/2);
tmp(2)=x_0(2)+k2(2)*(delta/2);
k3(1)=A(1,1)*tmp(1)+A(1,2)*tmp(2);
k3(2)=A(2,1)*tmp(1)+A(2,2)*tmp(2);
tmp(1)=x_0(1)+k3(1)*(delta);
tmp(2)=x_0(2)+k3(2)*(delta);
k4(1)=A(1,1)*tmp(1)+A(1,2)*tmp(2);
k4(2)=A(2,1)*tmp(1)+A(2,2)*tmp(2);

xNew(1)=x_0(1)+delta*(k1(1)+2*k2(1)+2*k3(1)+k4(1))/6;
xNew(2)=x_0(2)+delta*(k1(2)+2*k2(2)+2*k3(2)+k4(2))/6;
% fprintf('k1=%f %f\n', k1(1),k1(2));
% fprintf('k2=%f %f\n', k2(1),k2(2));
% fprintf('k3=%f %f\n', k3(1),k3(2));
% fprintf('k4=%f %f\n', k4(1),k4(2));
% fprintf('xNew=%f %f\n', xNew(1),xNew(1));
return;