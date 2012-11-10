clear all; close all; clc

m=5;%5 points in each direction (25 points)
n=m*m;

e1=ones(n,1);
e0=zeros(n,1);

e2=e1;
e4=e0;
for j=1:m
    e2(m*j)=0;
    e4(m*j)=1;
end

%shifting e2 and e5
e3(2:n,1)=e2(1:n-1,1); e3(1,1)=e2(n,1);
e5(2:n,1)=e4(1:n-1,1); e5(1,1)=e4(n,1);

A=spdiags([e1 e1 e5 e2 -4*e1 e3 e4 e1 e1],[-(n-m) -m -m+1 -1 0 1 m-1 m (n-m)],n,n);

det(A)
cond(A) %10^17 it mean totaly singular
spy(A)