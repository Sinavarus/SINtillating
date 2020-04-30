%Barituziga Banuna
%CHEME 7770 PS4 Problem 1

K = 0.1; %10
K1 = K;
K2 = K;
K3 = K;
K4 = K;

KD = 0.1; %This is 1/Kd INITIAL

theta_1 = (1./(1+(KD.^-1)));

a1 = (1-5.*theta_1);
b1 = (5.*theta_1-K2*5.*theta_1-K1-1);
c1 = (5.*theta_1*K2);

x1_1 = (-b1-sqrt((b1.^2)-4.*a1.*c1))./(2.*a1); %use

a2 = (1-10*x1_1);
b2 = (10*x1_1-K4*10*x1_1-K3-1);
c2 = 10*x1_1*K4;

y3_1 = (-b2-sqrt(b2.^2-4.*a2.*c2))./(2.*a2); %use

KD = 0.15;  %This is 1/Kd FINAL

theta_2 = (1./(1+(KD.^-1)));

a1 = (1-5.*theta_1);
b1 = (5.*theta_1-K2*5.*theta_1-K1-1);
c1 = (5.*theta_1*K2);

x1_2 = (-b1-sqrt((b1.^2)-4.*a1.*c1))./(2.*a1); %use

a2 = (1-10*x1_1);
b2 = (10*x1_1-K4*10*x1_1-K3-1);
c2 = 10*x1_1*K4;

y3_2 = (-b2-sqrt(b2.^2-4.*a2.*c2))./(2.*a2); %use

per_theta = 100*(theta_2-theta_1)/(theta_1)
per_x1 = 100*(x1_2-x1_1)/(x1_1)
per_y3 = 100*(y3_2-y3_1)/(y3_1)
%_____________________________________________________________________

K = 10;
K1 = K;
K2 = K;
K3 = K;
K4 = K;

KD = 0.1; %This is 1/Kd

theta_1 = (1./(1+(KD.^-1)));

a1 = (1-5.*theta_1);
b1 = (5.*theta_1-K2*5.*theta_1-K1-1);
c1 = (5.*theta_1*K2);

x1_1 = (-b1-sqrt((b1.^2)-4.*a1.*c1))./(2.*a1); %use

a2 = (1-10*x1_1);
b2 = (10*x1_1-K4*10*x1_1-K3-1);
c2 = 10*x1_1*K4;

y3_1 = (-b2-sqrt(b2.^2-4.*a2.*c2))./(2.*a2); %use

Per_theta = 100*(theta_2-theta_1)/(theta_1)
Per_x1 = 100*(x1_2-x1_1)/(x1_1)
Per_y3 = 100*(y3_2-y3_1)/(y3_1)

