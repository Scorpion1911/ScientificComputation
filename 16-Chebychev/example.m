%example of numerical solving Ut=Uxx+Uyy; KRON

clear all; close all; clc

% 2-dimesions X and Y
N=30;
[D,x]=cheb(N-1);
D2=D^2;%D - page 103
D2(1,:)=zeros(1,N);%BC
D2(end,:)=zeros(1,N);%BC

y=x;
[X,Y]=meshgrid(x,y);

%init cond
U=exp(-(X.^2+Y.^2)/0.1);
u=reshape(U,N^2,1);
%pcolor(X,Y,U)

%L- 2d Laplacian - matrix of d^2/dx^2 + d^2/y^2 page 107 of lec notes
I=eye(length(D2));
L=kron(I,D2)+kron(D2,I); %2D Laplacian

tspan=0:0.01:0.1
[t,usol]=ode45('hear_rhs_2D_cheb',tspan,u,[],L)

for j=1:length(t)
    uplot=reshape(usol(j,:),N,N);
    pcolor(X,Y,uplot),shading interp
    drawnow
	pause(0.2)
end