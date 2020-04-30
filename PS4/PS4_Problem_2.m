%Barituziga Banuna
%CHEME 7770 PS4 Problem 2

VM1 = 5;
VM2 = 5;
VM3 = 1;
VM4 = 1;

Ks1 = 5;
Ks2 = 5;
Ks3 = 5;
Ks4 = 5;

KI1 = 1;
KI2 = 1;

Stot = 100;

Z = zeros(3*length(linspace(0.01,1000,100))^2,3);
syms A

count = 1;

    for x = [linspace(0.01,10,100),linspace(10,1000,10)]
        for y = [linspace(0.01,10,100),linspace(10,1000,10)]

            z = vpasolve(100 - ((175*A/(35-4*A+35*x+A*x))) - ((175*A/(35-4*A+35*y+A*y))) - A, A);
            
            for n = 1:length(z)
                Z(count,:) = [x,y,z(n)];
                count = count+1;
            end 
        end
    end
 
figure
scatter3(Z(:,1),Z(:,2),Z(:,3),'.')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
zlim([0 inf])
title('A vs I1 and I2')
xlabel('I1')
ylabel('I2')


