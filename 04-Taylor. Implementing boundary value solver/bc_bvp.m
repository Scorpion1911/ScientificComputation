%example y''+3y'+6y=5
%BC: x [1,3]
%y(1)=3
%y(3)+2y'(3)=5
% 1. need transform to 1st order DE
% y1=y   ----->y1'=y'
% y2=y'  ----->y2'=y''
%
%
% Our equations
%y1'=y2
%y2'=5-3y2-6y1

%our BC
%y1-3=0
%y1+2y2-5=0

%BC 

function bc=bc_bvp(yl,yr)%also you can specify middle poins
bc=[yl(1)-3;yr(1)+2*yr(2)-5];
