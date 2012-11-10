clear all; close all; clc

L=20;%size of domain
%if not periodic we have problems
%function trying to be periodic.
%and we have big error at boundaries
% define the computational domain [-L/2,L/2]

n=32; % define the number of Fourier modes 2^n
x2=linspace(-L/2,L/2,n+1); % define the domain discretization
x=x2(1:n); % consider only the first n points: periodicity ;

u=sech(x);
ud=-sech(x).*tanh(x);

k=(2*pi/L)*[0:(n/2-1) (-n/2):-1]
ut=fft(u);

%1st derivitive
u1dt=((i*k).*ut);
u1d=ifft(u1dt)

ud=-sech(0).*tanh(0)

B=[k u1d]

plot(x,u,'k',x,ud,'m',x,u1d,'g-')
