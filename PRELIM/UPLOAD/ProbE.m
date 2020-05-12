function [dydt] = ProbE(T,C)


alx = 3.9*10^(-2); 
aly = 4.3*10^(-3);
betax = 6.1; 
betay = 5.7;
zx = 1.3*10^(-5); 
xy = 7.9*10^(-4);
xz = 12.0*10^(-2);
yz = 11.0*10^(-3);
sigy = 1.05;
sigz = 1.04;
nzx = 2.32;
nxy = 2;
nxz = 2;
nyz = 2;

S = 100;

dydt(1)= (alx+betax*S)/(1+S+(C(3)/zx)^nzx)-C(1);
dydt(2)= (aly+betay*S)/(1+S+(C(1)/xy)^nxy)-sigy*C(2);
dydt(3)= 1/(1+(C(1)/xz)^nxz+(C(2)/yz)^nyz)-sigz*C(3);
dydt = [dydt(1);dydt(2);dydt(3)];
end