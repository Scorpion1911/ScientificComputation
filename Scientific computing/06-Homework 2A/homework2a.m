clear all; close all; clc
dx=0.1;
N=80;
B=ones(N,3)  ;
for i=0:N-1
    B(i+1,2)=-2-0.1^2* (-4+dx*i)^2;
end
A = full(spdiags(B,[-1 0 1],N,N));  
b=zeros(N,1);% BC at -4 and 4 equals zero from HW1
b(1,1)=3
b(N,1)=3
y=A\b
eig(A)