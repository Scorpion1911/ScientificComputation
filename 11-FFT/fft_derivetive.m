clear all; close all; clc

L=20;%size of domain
%if not periodic we have problems
%function trying to be periodic.
%and we have big error at boundaries

n=512;%point to descritize 2^7

x2=linspace(-L/2,L/2,n+1);
x=x2(1:n);

u=sech(x);
ud=-sech(x).*tanh(x);

k=(2*pi/L)*[0:(n/2-1) (-n/2):-1];
ut=fft(u);

%5th derivitive
u5dt=(((i*k).^5).*ut);
u5d=ifft(u5dt);

plot(x,u,'k',x,ud,'m',x,u5d,'g-')