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
A=zeros(64,64);
Adiags=ones(64,10);
Adiags(:,6)=Adiags(:,6)*-4;
Anum=[-63 -61 -60 -4 -1 0 1 3 4 60];
A=full(spdiags(Adiags,Anum,64,64))/delta^2;

% in accordance with assignment A(1,1)=-4
A_s=A;
A_s(1,1)=-4;
%spy(A);

% B=d/dx
B=zeros(64,64);
Bdiags=ones(64,4);
Bdiags(:,2)=Bdiags(:,2)*-1;
Bdiags(:,4)=Bdiags(:,4)*-1;
Bnum=[-60 -4 4 60];
B=full(spdiags(Bdiags,Bnum,64,64))/(2*delta);
% spy(B);

%C=d/dy
C=zeros(64,64);
Cdiags=ones(64,4);
Cdiags(:,1)=0;
Cdiags(:,2)=Cdiags(:,2)*-1;
Cdiags(:,3)=1;
Cdiags(:,4)=0;

for i=1:64
   if mod(i,4)==0
       Cdiags(i,2)=0;
       Cdiags(i,4)=-1;
   end
   
   if mod(i-1,4)==0
       Cdiags(i,3)=0;    
   end
   
   if mod(i,4)==1
       Cdiags(i,1)=1;
   end

   i=i+1;
end
Cnum=[-3 -1 1 3];
C=full(spdiags(Cdiags,Cnum,64,64))/(2*delta);

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
w=reshape(W0,64^2,1);
%Finding PHI(X,Y,0) we can make it inside RHS
 PHI0=A_s\W0
% surf(X,Y,PHI0)

% part b
 nu=0.001;
 tspan=0:0.5:4;
 [t, w_t]   = ode45('rhs',tspan,W0,[],A,A_s,B,C,nu);

