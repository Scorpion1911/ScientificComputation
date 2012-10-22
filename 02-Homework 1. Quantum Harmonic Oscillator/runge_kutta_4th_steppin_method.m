clear all; close all; clc;
format long
tol=10^(-10);%tolerance
xspan=[-4 4];%finding solution between 2 numbers of xspan

A=1;
ic=[0 A];%initial conditions y(0) y'(A)

En=16;% �� ���������� ���-�� ���� �����...
%Y''+betta*y=0,betta should be positive becouse 
%we should have several answers there PSI=0 (from ic:PSI(-4,+4)=0) 
%thats why sin and cos in answers not exp()
%therefore -(x^2-En)>0 x(max)=+-4 >> 



for jj=1:10% for finding more than 1 solution
dEn=1;    
if En<0 
    break
end    
for j=1:1000

[t,y]=ode45('runge_kutta_4th_steppin_method_rhs',xspan,ic,[],En);

if abs(y(end,1))<tol
    [t y(:,1)];
    
    break
end% 

if y(end,1)*((-1)^(jj+1))>0% last component of 1st column in power of jj+1, 
    %becouse after first solution the function become negative(like sin)
    %will be
En=En-dEn; % ���� ������ �� ���������� ����
else
En=En+dEn;% ���� ����, �� ������������ �������
dEn=dEn/2;%� ������ ���
end
end


    
En
En=En-1;
y;
plot(t,y(:,1)),hold on
end