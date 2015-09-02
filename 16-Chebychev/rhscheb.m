function rhs=hear_rhs_2D_cheb(t,x)
global D2 D N
x = reshape(x,[N,3]);
u = x(:,1);
v = x(:,2);
w = x(:,3);
rhs=[  300*D2*u-5*D*u;  ...
       300*D2*v-5*D*v; ...
       300*D2*w-5*D*w]; 