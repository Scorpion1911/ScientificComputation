clear all; close all; clc

L=20; % define the computational domain [-L/2,L/2]
n=128; % define the number of Fourier modes 2^n
x2=linspace(-L/2,L/2,n+1); % define the domain discretization
x=x2(1:n); % consider only the first n points: periodicity
u=exp(-x.*x); % function to take a derivative of 
ut=fftshift(abs(fft(u)));
max(ut)

plot(x,ut)