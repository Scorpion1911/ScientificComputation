function h = le(f,g)
% LE (<=) for chebfuns.
%
% H = F <= G, where F and/or G are chebfuns, constructs a logical chebfun H
% which is true (i.e. takes the value 1) where F <= G, and false (0) 
% elsewhere.

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

% Quasimatrices?
nf = numel(f); ng = numel(g);
if nf > 1 || ng > 1
    if nf == 1
        h = g;
        for k=1:ng
            h(k) = le(f,g(k));
        end;
    elseif ng == 1
        h = f;
        for k=1:nf
            h(k) = le(f(k),g);
        end;
    elseif nf == ng
        h = f;
        for k=1:nf
            h(k) = le(f(k),g(k));
        end;
    else
        error('CHEBFUN:le:quasi','Quasi-matrix dimensions must agree');
    end

% Nope, no quasimatrices.
else

    h = heaviside(g-f);
    h.imps(h.imps == .5) = 1;
    for k = 1:h.nfuns
        if h.funs(k).vals == .5, h.funs(k).vals = 1; end
    end    
    h = merge(h);
    
end
