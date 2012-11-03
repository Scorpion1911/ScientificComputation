clear all; close all; clc;

tol=10^(-6);%tolerance
xspan=[-1 1];%finding solution between 2 numbers of xspan

A=1;
ic=[0 A];%initial conditions y(0) y'(A)

beta=91;%betta



for jj=1:5% for finding more than 1 solution
dbeta=1;    
    
for j=1:1000

[t,y]=ode45('runge_kutta_4th_steppin_method_rhs',xspan,ic,[],beta);

if abs(y(end,1))<tol
    break
end%     
if y(end,1)*((-1)^(jj+1))>0% last component of 1st column in power of jj+1, 
    %becouse after first solution the function become negative(like sin)
    %will be
beta=beta-dbeta; % если больше то спускаемся ниже
else
beta=beta+dbeta;% усли ниже, то промахнулись возврат
dbeta=dbeta/2;%и меняем шаг
end
end
beta
beta=beta-1;
y(end,1)
plot(t,y(:,1)),hold on
end