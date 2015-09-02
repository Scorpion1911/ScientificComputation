function [dcdt] = rates(C)
    global D2 D N B A
    u = C(:,1);
    dcdt=zeros(size(C));
    dcdt(:,1)  = 385*A*u-5*B*u;