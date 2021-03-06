clear all; close all; clc
% %initial conditions
% x=-10:0.5:10;
% % y=-10:0.1:10;
% x = linspace(min(x),max(x),65);
% y = linspace(min(x),max(x),65);
% [X,Y] = meshgrid(x,y);
% z=exp(-X.^2-Y.^2/20);
%surf(X,Y,z)


% Algorythm^:
% 1. A=2nd Laplacian, B=d/dx, C=d/dy matrices
% 2. shooting Runge-Kutta of right part of eq for Wt, Wt0 calc from eq
% W(x,y,0)
% 3. Done

%delta of our net
delta=20/64;

% 1. Constracting A, B, C matrices
% Laplasian^2
A=zeros(4096,4096);
Adiags=ones(4096,9);
Adiags(:,5)=Adiags(:,5)*-4;
Adiags(:,3)=0;
Adiags(:,7)=0;
for i=1:4096
   if mod(i,64)==0
       Adiags(i,4)=0;
       Adiags(i,7)=1;
   end
   
   if mod(i,64)==1
       Adiags(i,3)=1;
       Adiags(i,6)=0;
   end

   i=i+1;
end
Anum=[-4032 -64 -63 -1 0 1 63 64 4032];
A=full(spdiags(Adiags,Anum,4096,4096))/delta^2;


% in accordance with assignment A(1,1)=2
A_s=A;
A_s(1,1)=2/delta^2;
%spy(A);

% B=d/dx
B=zeros(4096,4096);
Bdiags=ones(4096,4);
Bdiags(:,2)=Bdiags(:,2)*-1;
Bdiags(:,4)=Bdiags(:,4)*-1;
Bnum=[-4032 -64 64 4032];
B=full(spdiags(Bdiags,Bnum,4096,4096))/(2*delta);
% spy(B);

%C=d/dy
C=zeros(4096,4096);
Cdiags=ones(4096,4);
Cdiags(:,1)=0;
Cdiags(:,2)=Cdiags(:,2)*-1;
Cdiags(:,3)=1;
Cdiags(:,4)=0;

for i=1:4096
   if mod(i,64)==0
       Cdiags(i,2)=0;
       Cdiags(i,4)=-1;
   end
   
   if mod(i-1,64)==0;
       Cdiags(i,3)=0;    
   end
   
   if mod(i,64)==1;
       Cdiags(i,1)=1;
   end

   i=i+1;
end
Cnum=[-63 -1 1 63];
C=full(spdiags(Cdiags,Cnum,4096,4096))/(2*delta);

% 2. shooting Runge-Kutta of right part of eq for Wt, Wt0 calc from eq
% W(x,y,0)

% part a: finding w and phi

% Spatial domain 
n = 64; 
% Number of points 
x2 = linspace(-10,10,n+1); 
% The grid 
x = x2(1:n); 
% Periodic BC, hence consider only n points 
y=x;
[X,Y] = meshgrid(x,y);

% Finding W(X,Y,0)
W0=exp(-X.^2-Y.^2/20);
%reshape into vector
w0=reshape(W0,4096,1);
%Finding PHI(X,Y,0) we can make it inside RHS
%  PHI=A\w
% surf(X,Y,PHI0)

% part b
 nu=0.001;
%  condest(A_s)
%  TEST
%  w1=0.001*A*w
%  a4=(B*PHI)
%  a2=(C*w)
%  a5=a4.*a2
%  a1=(C*PHI)
%  a3=(B*w)
% % 
% a6=a1.*a3
% w1-a5+a6
 tspan=0:0.1:40;
 [t, w_t]   = ode45('rhs',tspan,w0,[],A,A_s,B,C,nu)

