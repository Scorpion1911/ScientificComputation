clear all; close all; clc

% initialize grid size, time, and CFL number Time=4;
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

% initial conditions 
u0=exp(-x.^2).'; 
u1=exp(-(x+dt).^2).'; 
usol(:,1)=u0; 
usol(:,2)=u1;
% break
% sparse matrix for derivative term 
e1=ones(n,1);
A=spdiags([-e1 e1],[-1 1],n,n); 
A(1,n)=-1; A(n,1)=1;
% break
% leap frog (2,2) or euler iteration scheme 
for j=1:length(t)-1
%u1 = u0 + (CFL/2)*A*u0 ; % Euler
%u0 = u1;%  Euler
 u2 = u0 + CFL*A*u1; % leap frog (2,2)
 u0 = u1; u1 = u2;% leep frog (2,2)
usol(:,j+1)=u0; 
end

% plot the data 
waterfall(x,t,usol'); 
map=[0 0 0]; 
colormap(map);