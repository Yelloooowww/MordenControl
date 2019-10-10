function xNew=Euler(x,delta,A)
xDot=[0 0]';
xNew=xDot;
xDot(1)=A(1,1)*x(1)+A(1,2)*x(2);
xDot(2)=A(2,1)*x(1)+A(2,2)*x(2);
% fprintf('xDot=%f %f\n', xDot(1),xDot(1));
xNew(1)=x(1)+xDot(1)*delta;
xNew(2)=x(2)+xDot(2)*delta;
% fprintf('xNew=%f %f\n', xNew(1),xNew(1));
return;