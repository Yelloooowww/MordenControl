function xNew = myFindNextPos2(x,mu,delt)   
xDot= [0,0]';  %zeros(size(x));
xNew = xDot; 
%xDot(1) =  -x(1) + 4*x(2); 
%xDot(2) =  -x(1)- x(2)*x(2)*x(2);
xDot(1) =  -0.5*x(1)  ; 
xDot(2) =  0.01*x(2);
xNew(1) = x(1) + xDot(1)*delt;
xNew(2) = x(2) + xDot(2)*delt;
return;