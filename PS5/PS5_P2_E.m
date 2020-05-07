Ror = 1;
Rr = 100;
Roa = 100;
Ra = 5000;
da = 30;
    
f = @(t,y) [-da*y(1) + (Roa+Ra*(y(1)^2))/(1+y(1)^2+y(2)^2);-y(2) + (Ror+Rr*(y(1)^2))/(1+y(1)^2) ];
tspan = [0, 30];
xinit = [1.0,10.0];
ode45(f, tspan, xinit)
legend('Ca', 'Cr')
xlabel('t')
ylabel('Concentration')