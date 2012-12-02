function rhs=rhs(tspan,w,dummy,A,A_s,B,C,nu)
PSI=A_s\w;
rhs=A*nu*w-(B*PSI).*(C*w)+(C*PSI).*(B*w);

