%Newton solver f = @(x)x.^3-2*x-5; means f(x)=x^3-2x-5
f=@(x)exp(x)-sin(x)
z=fzero(f,-3)