clear all;close all; clc
x=[1];y=[2];z=[2];
for k=2:5
    x(k) = (y(k-1) + 5*z(k-1) - 15)/2;
    y(k) = (21 + z(k-1) + 4*x(k-1))/8;
    z(k) = 7 - 4*x(k-1) + y(k-1);
end
x,y,z