clear all; close all; clc
%initial conditions
x=-10:0.0001:10;
% y=-10:0.1:10;
x = linspace(min(x),max(x),65);
y = linspace(min(x),max(x),65);
[X,Y] = meshgrid(x,y);
z=exp(-X.^2-Y.^2/20);
surf(X,Y,z)
