clear all; close all; clc;

%loading matrix of calculated date of tspan=0:0.1:40
% time stepping 0.1 for 0-40 sec of time
load('wt_matrix.mat');

m=64;
x=linspace(-10,10,m)
[X,Y]=meshgrid(x,x)
mesh(X,Y,reshape(w_t(1,:),m,m))
 for i=1:401
     surf(X,Y,reshape(w_t(i,:),m,m))
     F(i)=getframe;
 end