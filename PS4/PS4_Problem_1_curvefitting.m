%Barituziga Banuna
%CHEME 7770 PS4 Problem 1

K = 0.1; %10
K1 = K;
K2 = K;
K3 = K;
K4 = K;

KD = [0.00001:0.0001:10]; %This is 1/Kd

theta = (1./(1+(KD.^-1)));

figure(13)% use
plot(KD,theta);

a1 = (1-5.*theta);
b1 = (5.*theta-K2*5.*theta-K1-1);
c1 = (5.*theta*K2);

x = (-b1+sqrt((b1.^2)-4.*a1.*c1))./(2.*a1);
x1 = (-b1-sqrt((b1.^2)-4.*a1.*c1))./(2.*a1); %use

figure(1)
plot(KD,x);
figure(2)
plot(KD,x1); %use


a2 = (1-10*x);
b2 = (10*x-K4*10*x-K3-1);
c2 = 10*x*K4;

y = (-b2+sqrt(b2.^2-4.*a2.*c2))./(2.*a2);
y1 = (-b2-sqrt(b2.^2-4.*a2.*c2))./(2.*a2);

figure(3)
plot(KD,y);
figure(4)
plot(KD,y1);

a2 = (1-10*x1);
b2 = (10*x1-K4*10*x1-K3-1);
c2 = 10*x1*K4;

y2 = (-b2+sqrt(b2.^2-4.*a2.*c2))./(2.*a2); 
y3 = (-b2-sqrt(b2.^2-4.*a2.*c2))./(2.*a2); %use

figure(5)
plot(KD,y2);
figure(6)
plot(KD,y3); %use
%_____________________________________________________________________


K = 10;
K1 = K;
K2 = K;
K3 = K;
K4 = K;

KD = [0.00001:0.0001:10]; %This is 1/Kd

theta = (1./(1+(KD.^-1)));

a1 = (1-5.*theta);
b1 = (5.*theta-K2*5.*theta-K1-1);
c1 = (5.*theta*K2);

Xx = (-b1+sqrt((b1.^2)-4.*a1.*c1))./(2.*a1);
Xx1 = (-b1-sqrt((b1.^2)-4.*a1.*c1))./(2.*a1); %use

figure(7)
plot(KD,Xx);
figure(8)
plot(KD,Xx1); %use


a2 = (1-10*Xx);
b2 = (10*Xx-K4*10*Xx-K3-1);
c2 = 10*Xx*K4;

Yy = (-b2+sqrt(b2.^2-4.*a2.*c2))./(2.*a2);
Yy1 = (-b2-sqrt(b2.^2-4.*a2.*c2))./(2.*a2);

figure(9)
plot(KD,Yy);
figure(10)
plot(KD,Yy1);

a2 = (1-10*Xx1);
b2 = (10*Xx1-K4*10*Xx1-K3-1);
c2 = 10*Xx1*K4;

Yy2 = (-b2+sqrt(b2.^2-4.*a2.*c2))./(2.*a2); 
Yy3 = (-b2-sqrt(b2.^2-4.*a2.*c2))./(2.*a2); %use

figure(11)
plot(KD,Yy2);
figure(12)
plot(KD,Yy3); %use





