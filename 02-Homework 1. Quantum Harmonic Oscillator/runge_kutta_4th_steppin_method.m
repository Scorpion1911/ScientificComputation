clear all; close all; clc;
format long
tol=10^(-10);%tolerance
xspan=[-4 4];%finding solution between 2 numbers of xspan

A=1;
ic=[0 A];%initial conditions

En=10;%betta



for jj=1:6% for finding more than 1 solution
dEn=1;    
    
for j=1:1000

[t,y]=ode45('runge_kutta_4th_steppin_method_rhs',xspan,ic,[],En);

if abs(y(end,1))<tol
    [t y(:,1)];
    
    break
end%     
if y(end,1)*((-1)^(jj+1))>0% last component of 1st column in power of jj+1, 
    %becouse after first solution the function become negative(like sin)
    %will be
En=En-dEn; % если больше то спускаемся ниже
else
En=En+dEn;% усли ниже, то промахнулись возврат
dEn=dEn/2;%и меняем шаг
end
end

En
En=En-1;
y;
plot(t,y(:,1)),hold on
end