%RHS of DEs

function rhs=rhs_bvp_nonlinear(x,y,beta)
rhs=[y(2);(beta-100)*y(1)-y(1)^3];% in the begining y1=0 because guessing
%working with domain x, initialy its 10 points
%