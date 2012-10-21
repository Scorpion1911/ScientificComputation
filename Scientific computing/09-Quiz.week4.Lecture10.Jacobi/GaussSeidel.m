clear all;close all; clc
x=[1];y=[2];z=[2];
for k=2:5
    x(k)=(7 + y(k-1)- z(k-1)) /4;
    y(k)=(21 + 4*x(k) + z(k-1))/8;
    z(k)=(15 + 2*x(k) - y(k))/5;
end
x,y,z