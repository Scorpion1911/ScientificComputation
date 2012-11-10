clear all; close all; clc;
figure('Renderer','zbuffer')
Z = peaks;
mesh(Z); 
% colormap('Gold');
set(gca,'NextPlot','replaceChildren');
load('wt_matrix.mat')
x=linspace(-10,10,64)
[X,Y]=meshgrid(x,x)
mesh(X,Y,reshape(w_t(1,:),64,64))
 for i=1:401
     surf(X,Y,reshape(w_t(i,:),64,64))
     F(i)=getframe;
 end