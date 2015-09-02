clear all; close all; clc

n=10;
delta=1;

Bdiags=ones(n,4);
Bdiags(:,2)=Bdiags(:,2)*-1;
Bdiags(:,4)=Bdiags(:,4)*-1;
Bnum=[-(n-m) -m m n-m];
B=full(spdiags(Bdiags,Bnum,n,n))/(2*delta);\
spy(B)