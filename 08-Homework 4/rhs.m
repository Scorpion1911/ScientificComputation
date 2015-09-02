function rhs=rhs(tspan,w,dummy,A,A_s,B,C,nu)
PHI=A_s\w;
% P0=A*nu;
% P1=P0*w;
% P2=B*PHI;
% P3=C*w;
% P4=P2.*P3;
% P5=C*PHI;
% P6=B*w;
% P7=P5.*P6;
% P8=;
rhs=A*nu*w-(B*PHI).* (C*w) + (C*PHI) .* (B*w);

