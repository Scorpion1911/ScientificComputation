%example of numerical solving Ut=Uxx+Uyy; KRON
clear all; close all; clc
global D2 D N B A
% 2-dimesions X and Y
N=512;
n=N;
% [D,x]=cheb(N-1);
% D2= D^2;
% D(1,:)=zeros(1,N);%BC
% D(end,:)=zeros(1,N);%BC
% D2(1,:)=zeros(1,N);%BC
% D2(end,:)=zeros(1,N);%BC

x = (linspace(0,15,N))';
dx = x(2)-x(1);
tt = 0:0.01:10;
dt =tt(2)-tt(1);


D =300;
v=5
betta = 1;
alpha = 1;

LD = dt * D *  betta / dx^2 ;
LA = dt * v *  alpha / (2 * dx) ;
RD = dt * D *  (1 - betta) / dx^2 ;
RA = dt * v *  (1 - alpha) / (2 * dx); 

% Constructing left matrix LU for solute species(left unknowns):
LUdiags = ones(n,3); % n-1 due to BC at the toLU
LUdiags(:,1) = LUdiags(:,1).*(-LA-LD);
LUdiags(n-2,1) = -2*LD;
LUdiags(:,2) = LUdiags(:,2).*(1+2*LD);
LUdiags(:,3) = LUdiags(:,3).*(LA-LD);
LUnum = [-1 0 1];
LU = full(spdiags(LUdiags,LUnum,n,n));
LU(1,1)=1; LU(1,2)=0;

% Constructing right matrix RK (right knowns):
RKdiags = ones(n,3); % n-1 due to BC at the top
RKdiags(:,1) = RKdiags(:,1) .* (RA+RD);
RKdiags(n-2,1) = 2*RD;
RKdiags(:,2) = RKdiags(:,2).*(1-2*RD);
RKdiags(:,3) = RKdiags(:,3).*(-RA+RD);
RKnum = [-1 0 1];
RK = full(spdiags(RKdiags,RKnum,n,n));
RK(1,1)=1;RK(1,2)=0;

u0 = 0.15*exp(-x);
% v0 = 1 + erf(10*(x-0.7));
% w0 = 0.*x;
 
u = zeros(N,size(tt,2));



for i=1:size(tt,2)
  u1 = LU \ ( RK * u0);
  u0 = u1;
  u(:,i) = u1;
end



% [tt uu] = ode15s('rhscheb',0:.1:100,[u0 v0 w0]);
% [tt uu] = ode45(f,0:.1:365,[u0 v0 w0],[],D)

[X,T]=meshgrid(x,tt);

% u = uu(:,1:N);
% v = uu(:,N+1:2*N);
% w = uu(:,2*N+1:3*N);

% subplot(2,2,1)
mesh(T,X,u');
% subplot(2,2,2)
% mesh(T,X,v);
% subplot(2,2,3)
% mesh(T,X,w);






