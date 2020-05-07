using LinearAlgebra
a = 10
n = 2



J = [-1 (-2*10*2)/((1+2^2)^2);(-2*10*2)/((1+2^2)^2) -1]
Eigenvalue = eigvals(J)
print(Eigenvalue)