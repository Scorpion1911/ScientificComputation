clear all; close all; clc

%==========================================================
% Example for Vorticity - Stream Function Equation.
% Wt+[Psi,W]=nu*"laplacian"^2*W, where 
% "laplacian^2=(d/dx)^2+(d/dy)^2; 
% [Psi,W] = PSIx * Wy - PSIy * Wx; 
% and the streamfunction satisfies "laplacian"^2*Psi=W
%==========================================================
% Initial Conditions: 
% Assume a Gaussian shaped mound of initial vorticity and
% small diffusion parameter nu=0.001.
%==========================================================
% Boundary Conditions:
% Assume periodic boundary conditions for both vorticity and 
% streamfunction
%==========================================================


%==========================================================
% Algorithm:
% 1. Constracting A=2nd Laplacian, B=d/dx, C=d/dy matrices
% 2. Runge-Kutta of right part of eq for Wt, Wt0 
% calc from eq W(x,y,0)
%==========================================================

% Spatial domain 
m=64;%m points in each direction (64 points)
n=m*m;
% Number of points 
x2 = linspace(-10,10,m+1); 
% The grid 
x = x2(1:m); % Periodic BC, hence consider only m points 
y=x;
[X,Y] = meshgrid(x,y);
%delta of our domain 
delta=x(2)-x(1);% dx=dy=delta


% Part 1. Constracting A, B, C matrices

%Constracting matrix A = our laplacian

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
A=spdiags([e1 e1 e5 e2 -4*e1 e3 e4 e1 e1],[-(n-m) -m -m+1 -1 0 1 m-1 m (n-m)],n,n)/delta^2;
%Testing Matrix A
%det(A)
%cond(A) %10^17 it means totaly singular therefore reeplace A(1,1)=2
%spy(A)
A_s=A;
A_s(1,1)=2/delta^2;
%spy(A);

% Constracting matrix B=d/dx

Bdiags=ones(n,4);
Bdiags(:,2)=Bdiags(:,2)*-1;
Bdiags(:,4)=Bdiags(:,4)*-1;
Bnum=[-(n-m) -m m n-m];
B=full(spdiags(Bdiags,Bnum,n,n))/(2*delta);

%Constracting C=d/dy
% C=zeros(n,n);
Cdiags=ones(n,4);
Cdiags(:,1)=0;
Cdiags(:,2)=Cdiags(:,2)*-1;
Cdiags(:,3)=1;
Cdiags(:,4)=0;
for i=1:n
   if mod(i,m)==0
       Cdiags(i,2)=0;
       Cdiags(i,4)=-1;
   end
   
   if mod(i-1,m)==0;
       Cdiags(i,3)=0;    
   end
   
   if mod(i,m)==1;
       Cdiags(i,1)=1;
   end

   i=i+1;
end
Cnum=[-(m-1) -1 1 m-1];
C=full(spdiags(Cdiags,Cnum,n,n))/(2*delta);

% Part 2. 4th Runge-Kutta of right part of eq for Wt, Wt0 calc from eq
% W(x,y,0)
% Wt = A*nu*w - (B*PSI) .* (C*w) + (C*PSI) .* (B*w);



% Initial condition W(X,Y,0)
W0=exp(-X.^2-Y.^2/20);

%reshape into vector
w0=reshape(W0,n,1);

nu=0.001;

dt=0.5;
time=4;
tspan=0:dt:time;
itereations=time/dt+1;
[t, w_t]   = ode45('rhs',tspan,w0,[],A,A_s,B,C,nu);

for i=1:itereations
     surf(X,Y,reshape(w_t(i,:),m,m))
     F(i)=getframe;
 end


