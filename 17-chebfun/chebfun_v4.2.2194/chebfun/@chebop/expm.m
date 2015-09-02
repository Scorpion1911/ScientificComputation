function E = expm(A)
% EXPM   Exponential of a linear chebop.
% E = EXPM(A) returns a linear chebop representing the exponential operator
% generated by A. The chebop A should have boundary conditions appropriate
% for its definition, or else usage of E may be nonconvergent or
% unexpected. If A is nonlinear, an error is returned.
%
% Note that operations on chebops clear out boundary conditions, so you
% must reassign them before calling EXPM. Homogeneous (zero) boundary
% values are used, even if they are specified otherwise.
%
% EXAMPLE: Heat equation
% x = chebfun('x');
% A = chebop(@(u) diff(u,2));
% bc = 'dirichlet';
% f = exp(-20*(x+0.3).^2);
% clf, plot(f,'r'), hold on, c = [0.8 0 0];
% for t = [0.001 0.01 0.1 0.5 1]
%    E = expm(t*A & bc);
%    plot(E*f,'color',c),  c = 0.5*c;
% end
%
% For repeated use, it is better to create a linop explicitly using the
% chebop/linop method, and then exponentiate this.
%
% See also linop/expm, chebop/linop,

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

% Linearize and check whether the chebop is linear
try
    L = linop(A);
catch ME
    if strcmp(ME.identifier,'CHEBOP:linop:nonlinear')
        error('CHEBOP:expm',['Chebop appears to be nonlinear. Currently, expm is only' ...
            '\nsupported for linear chebops.']);
    else
        rethrow(ME)
    end
end

E = expm(L);