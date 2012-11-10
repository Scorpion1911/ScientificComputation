clear all; close all; clc

% initialize grid size, time, and CFL number Time=4;
Time=1;
L=20;
n=100;
x2=linspace(-L/2,L/2,n+1); 
x=x2(1:n);
dx=x(2)-x(1);
dt=0.04;

CFL=dt/dx^2 
time_steps=Time/dt; 
t=0:dt:Time;

% initial conditions 
u0=exp(-x.^2).'; 
u1=exp(-(x+dt).^2).'; % for Leep frog
usol(:,1)=u0; 
usol(:,2)=u1; %for Leep frog
% break
% sparse matrix for derivative term 
e1=ones(n,1);
A=spdiags([e1 -2*e1 e1],[-1 0 1],n,n); 
A(1,n)=1; A(n,1)=1;
% break
% leap frog (2,2) or euler iteration scheme 
for j=1:length(t)-2 %-2 for LF -1 for Euler
% Euler for Heat Equation
% u1 = u0 + CFL*A*u0 ; % Euler
% u0 = u1;%  Euler
% usol(:,j+1)=u0;

% Leep frog for Heat Equation
 u2 = u0 + 2*CFL*A*u1; % leap frog (2,2)
 u0 = u1; u1 = u2;% leep frog (2,2)
 usol(:,j+2)=u0; 
end

% plot the data 
waterfall(x,t,usol'); 
map=[0 0 0]; 
colormap(map);