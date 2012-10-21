function rhs=runge_kutta_4th_steppin_method_rhs(x,ic,dummy,En)
y1=ic(1);
y2=ic(2);
x;
rhs=[y2;(x^2-En)*y1];