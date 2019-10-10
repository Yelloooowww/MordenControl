clear;clc;
Q=[-81/17 501/17];
R=[1 268/17];
B=[1 -4];
A=[1 -2 9];
Tnum=conv(Q,B);
Tden=conv(R,A)+[0 conv(Q,B)];