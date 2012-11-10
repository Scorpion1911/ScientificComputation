clear all; close all; clc

L=20;%size of domain
n=128;%point to descritize 2^7

x2=linspace(-L/2,L/2,n+1);
x=x2(1:n);

u=exp(-x.^2);
ut=fftshift(abs(fft(u)));

plot(x,ut)
