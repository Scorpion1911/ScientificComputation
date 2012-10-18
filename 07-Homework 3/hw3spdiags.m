clear all; close all; clc
B(1:16,1)=-4;
B(:,2:10)=1
d=[0 -15 -13 -12 -4 -1 1 3 4 12]
A = spdiags(B)