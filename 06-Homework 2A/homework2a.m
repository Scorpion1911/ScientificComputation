clear all; close all; clc
% dx=0.1;
% N=80;
% B=-ones(N,3)  ;
% for i=0:N-1
%     B(i+1,2)=2+0.1^2* (-4+dx*i)^2;
% end
% A = full(spdiags(B,[-1 0 1],N,N));  
% b=zeros(N,1);% BC at -4 and 4 equals zero from HW1
% b(1,1)=3
% b(N,1)=3
% y=A\b
% eig(A)

clear all; close all; clc

dx = 0.1;           % given, step size in the domain
x  = [-4:dx:4]';    % given, the domain vector
N  = length(x);     % length of the domain vector

x  = x(2:N-1);      % don't need the first & last points
N  = N-2;           % adjust the length of the domain vector

d0 = (2/dx^2)+(x.^2);      % calculate the main diagonal (corrections follow)
d1 = (-1/dx^2).*ones(N,1); % calculate the first super/sub-diagonal

A = spdiags([ d1 d0 d1 ], [-1 0 +1], N, N);

A(1,1)   = (2/(3*dx^2))+x(1)^2;        % fix the upper left  corner value
A(N,N)   = (2/(3*dx^2))+x(N)^2;        % fix the lower right corner value

A(1,2)   = (2/3)*A(1,2);               % fix the upper diagonal value in the first row
A(N,N-1) = (2/3)*A(N,N-1);             % fix the lower diagonal value in the last row

A = full(A);          % eig doesn't like sparse matrices
eigA = sort(eig(A));  % sort helps
eigA(1:5)             % *** THESE ARE THE EIGENVALUES WE'RE LOOKING FOR ***

A(1:5,1:5)            % look at the upper left corner
A(N-4:N,N-4:N)        % look at the lower right corner