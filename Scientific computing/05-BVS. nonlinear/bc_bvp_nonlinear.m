%BC 

function bc=bc_bvp_nonlinear(yl,yr,beta)%also you can specify middle poins
bc=[yl(1); yl(2)-1; yr(1)];
