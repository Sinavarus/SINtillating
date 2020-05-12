%Barituziga Banuna
%PRELIM 1 P2 Part E

clc
clear
close all

syms X Y Z

%Parameters
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
 
 
% S below Hopf bifurcation Point
S = 0.04;
 
%Initial
INT = [0 0 0];

%Equations
Eqn_1 = 0 == (alx+betax*S)/(1+S+(Z/zx)^nzx)-X;         %dx/dt
Eqn_2 = 0 == (aly+betay*S)/(1+S+(X/xy)^nxy)-sigy*Y;    %dy/dt
Eqn_3 = 0 == 1/(1+(X/xz)^nxz+(Y/yz)^nyz)-sigz*Z;       %dz/dt

%solve for steady state values
[SolX,SolY,SolZ] = vpasolve([Eqn_1,Eqn_2,Eqn_3],[X,Y,Z],INT);

figure;
hold on
xlabel('t');
ylabel('Z');
tspan=[0,50];

Cell_1=[double(SolX),double(SolY),double(SolZ)];
Cell_2 = 1.25.*Cell_1;
Cell_3 = 0.75.*Cell_1;

%Cells 1-3 plotting
[T,C] = ode45(@ProbE,tspan,Cell_1);
valueCell_1=C(:,3);
plot(T,valueCell_1);

[T,C]=ode45(@ProbE,tspan,Cell_2);
valueCell_2=C(:,3);
plot(T,valueCell_2);

[T,C] = ode45(@ProbE,tspan,Cell_3);
valueCell_3=C(:,3);
plot(T,valueCell_3);

TITLE = 'Below Hopf Bifurcation';
title(TITLE);
legend('Cell 1','Cell 2','Cell 3');

ax = gca;
exportgraphics(ax, [TITLE '.png'])
 
%S above Saddle
S = 50000;
INT = [1 10;0 0.02;0 0.0];

%Equations
Eqn_1 = 0 == (alx+betax*S)/(1+S+(Z/zx)^nzx)-X;         %dx/dt
Eqn_2 = 0 == (aly+betay*S)/(1+S+(X/xy)^nxy)-sigy*Y;    %dy/dt
Eqn_3 = 0 == 1/(1+(X/xz)^nxz+(Y/yz)^nyz)-sigz*Z;       %dz/dt

%solve for steady state values
[SolX,SolY,SolZ] = vpasolve([Eqn_1,Eqn_2,Eqn_3],[X,Y,Z],INT);


figure;
hold on
xlabel('t');
ylabel('Z');

Cell_1 = [double(SolX),double(SolY),double(SolZ)];
Cell_2 = 1.25.*Cell_1;
Cell_3 = 0.75.*Cell_1;

%Cell 1-3 values
[T,C] = ode45(@ProbE,tspan,Cell_1);
valueCell_1 = C(:,3);
plot(T,valueCell_1);

[T,C] = ode45(@ProbE,tspan,Cell_2);
valueCell_2 = C(:,3);
plot(T,valueCell_2);

[T,C] = ode45(@ProbE,tspan,Cell_3);
valueCell_3 = C(:,3);
plot(T,valueCell_3);


TITLE = 'Above Saddle Node Bifurcation';
title(TITLE);
legend('Cell 1','Cell 2','Cell 3');
 
ax = gca;
exportgraphics(ax, [TITLE '.png'])