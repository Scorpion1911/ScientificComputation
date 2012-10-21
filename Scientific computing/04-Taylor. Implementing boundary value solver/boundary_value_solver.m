%example y''+3y'+6y=5
%BC: x [1,3]
%y(1)=3
%y(3)+2y'(3)=5
% 1. need transform to 1st order DE
% y1=y   ----->y1'=y'
% y2=y'  ----->y2'=y''
%
%
% Our equations
%y1'=y2
%y2'=5-3y2-6y1

%our BC
%y1-3=0
%y1+2y2-5=0

clear all; close all; clc;

%default tolerance in matlab is 10^-6

init=bvpinit(linspace(1,3,10),[0 0]);%guessing for 10 point solution is 
%y1=0 and y2=0 (it is not BC)
%but program will make it not 0.2=dx, 
%Matlab not trust you! will pick dx by itself


sol=bvp4c(@rhs_bvp,@bc_bvp,init);%rhs,BC, init- is guess for solution
x=linspace(1,3,100); %linear space of x, devide x onto 100 points
BS=deval(sol,x);%vector, deval calculate it for you for given x
plot(x,BS(1,:))