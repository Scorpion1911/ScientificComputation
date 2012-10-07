

clear all; close all; clc;

%default tolerance in matlab is 10^-6

%guessing
beta=99;%guess
init=bvpinit(linspace(-1,1,50),@bc_init, beta)%guessing for 10 point 
%between BC  solution is 
% function bc_init
%but program will make it not 0.2=dx, 
%Matlab not trust you! will pick dx by itself


sol=bvp4c(@rhs_bvp_nonlinear,@bc_bvp_nonlinear,init);%rhs,BC, 
%init- is guess for solution
x=linspace(-1,1,100); %linear space of x, devide x onto 100 points
BS=deval(sol,x);%vector, deval calculate it for you for given x
plot(x,BS(1,:))