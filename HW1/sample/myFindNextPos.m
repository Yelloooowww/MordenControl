function xNew = myFindNextPos(x,mu,delt)   
xDot= zeros(size(x));
xNew = xDot;
xDot(1) =  x(2);
xDot(2) = -mu*(x(1)*x(1)-1)*x(2) - x(1); 
xNew(1) = x(1) + xDot(1)*delt;
xNew(2) = x(2) + xDot(2)*delt;
return;