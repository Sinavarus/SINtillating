%Barituziga Banuna
%PRELIM 1 P2 Part C

clc
clear
close all

syms X Z

%Parameter Space
alx = 1.5;
betax = 5.0;
zx = 0.4;
xz = 1.5;
nzx = 2.7;
nxz = 2.7;
sigz = 1.0;

nspace=100; %number of points for each region
%initial input
INT = [0 0];

%Lower section of plot---------------------------------------------
S_Lower = linspace(0,1.2,nspace);
X_Lower = zeros([1 nspace]);

for i = 1:nspace
    
 S = S_Lower(i); %loops through S values
 
 eqn_1 = 0 == (alx+betax*S)/(1+S+(Z/zx)^nzx)-X;    %dx/dt
 eqn_2 = 0 == 1/(1+(X/xz)^nxz)-sigz*Z;             %dz/dt
 
 %SS Sol
 [SolX, SolZ] = vpasolve([eqn_1,eqn_2],[X,Z],INT);

 %Add the next entry
 X_Lower(i) = double(SolX);

 INT = [double(SolX) double(SolZ)];

end

%Higher section of plot--------------------------------------------

%initial input
INT = [10 10];

S_Higher = linspace(2,0.51,nspace);
X_Higher = zeros([1 nspace]);

for i = 1:nspace
    
 S = S_Higher(i);
 eqn_1 = 0 == (alx+betax*S)/(1+S+(Z/zx)^nzx)-X;    %dx/dt
 eqn_2 = 0 == 1/(1+(X/xz)^nxz)-sigz*Z;             %dz/dt
 
 %SS Sol
 [SolX, SolZ] = vpasolve([eqn_1,eqn_2],[X,Z],INT);

 X_Higher(i) = double(SolX);

 INT = [double(SolX) double(SolZ)];
end

figure;
hold on
TITLE = 'X vs. S (P2 C)';
title(TITLE);
%Lower section of plot
plot(S_Lower,X_Lower,'k');
%Adds Higher section to plot
plot(S_Higher,X_Higher,'k');
xlabel('S');
ylabel('X');

ax = gca;
exportgraphics(ax, [TITLE '.png'])
