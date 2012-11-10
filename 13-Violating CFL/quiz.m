clear all; close all; clc
% ========Question==========
% For practice work the following equations:
% In the code presented in class, construct a first derivative 
% matrix which has pinned u(0)=u(L)=0 boundary conditions instead 
% of periodic boundary conditions.
% Verify that the Euler scheme for time-stepping the one-way 
% wave equation is independent of the boundary conditions. Take 
% the derivative matrix with u(0)=u(L)=0 boundary conditions instead of 
% periodic boundary conditions and implement this into the Euler 
% stepping scheme to demonstrate that blow-up still happens.
% ==========================


% initialize grid size, time, and CFL number
Time=4;
L=20;
n=200;
x2=linspace(-L/2,L/2,n+1); 
x=x2(1:n);
dx=x(2)-x(1);
dt=0.1;

CFL=dt/dx 
time_steps=Time/dt; 
t=0:dt:Time;

% sparse matrix for derivative term 
e1=ones(n,1);
A=spdiags([-e1 e1],[-1 1],n,n); 
A(1,n)=-1; A(n,1)=1; % if non-periodic so we dont need it

% initial conditions 
u0=exp(-(x).^2).'; 
u1=exp(-(x+dt).^2).'; 
usol(:,1)=u0; 
usol(:,2)=u1;
% break

% break
% leap frog (2,2) or euler iteration scheme 
for j=1:length(t)-2
% u1 = u0 + (CFL/2)*A*u0 ; % Euler
% u0 = u1;%  Euler
% usol(:,j+1)=u0;
 u2 = u0 + CFL*A*u1; % leap frog (2,2)
 u0 = u1; u1 = u2;% leep frog (2,2)
usol(:,j+2)=u0; 
end

% plot the data 
waterfall(x,t,usol'); 
map=[0 0 0]; 
colormap(map);