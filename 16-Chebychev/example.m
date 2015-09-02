%example of numerical solving Ut=Uxx+Uyy; KRON

% clear all; close all; clc
global D2 D N
% 2-dimesions X and Y
N=90;
[D,x]=cheb(N-1);
D2= D^2;
% D(1,:)=zeros(1,N);%BC
% D(end,:)=zeros(1,N);%BC
% D2(1,:)=zeros(1,N);%BC
% D2(end,:)=zeros(1,N);%BC



u0 = 1 - erf(10*(x+0.7));
v0 = 1 + erf(10*(x-0.7));
w0 = 0.*x;
 








[tt uu] = ode15s('rhscheb',0:.1:100,[u0 v0 w0]);
% [tt uu] = ode45(f,0:.1:365,[u0 v0 w0],[],D)

[X,T]=meshgrid(x,tt);

u = uu(:,1:N);
v = uu(:,N+1:2*N);
w = uu(:,2*N+1:3*N);

subplot(2,2,1)
mesh(T,X,u);
subplot(2,2,2)
mesh(T,X,v);
subplot(2,2,3)
mesh(T,X,w);

% y=x;
% [X,Y]=meshgrid(x,y);

% %init cond
% U=exp(-(X.^2+Y.^2)/0.1);
% u=reshape(U,N^2,1);
% %pcolor(X,Y,U)

% %L- 2d Laplacian - matrix of d^2/dx^2 + d^2/y^2 page 107 of lec notes
% I=eye(length(D2));
% L=kron(I,D2)+kron(I,D); %2D Laplacian

% tspan=0:0.01:0.1;
% [t,usol]=ode45('hear_rhs_2D_cheb',tspan,u,[],L);

% for j=1:length(t)
%     uplot=reshape(usol(j,:),N,N);
%     pcolor(X,Y,uplot),shading interp
%     drawnow
% 	pause(0.2)
% end
