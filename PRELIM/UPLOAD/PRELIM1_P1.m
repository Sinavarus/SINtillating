clc

Avo = 6.02214076*10^23; % Avogadro's #
t_half = 5; %min half-life of RNA
td = 40; %min doubling time
thetha = log(2)/t_half; %min^-1 degredation rate constant
mu = log(2)/td; %min^-1 dilution
thetha_conv = thetha*(60);% hr^-1 converted degredation rate constant
mu_conv = mu*(60); %hr^-1 dilution
OD = 1*10^8; %cell/mL Optical density equivalent
V = 1.45; %um^3 cell volume
G = 2; %gene copy/cell
Kd = 49.6; %uM
Kd_conv = Kd*(1/1000) %mM
Gconv = G*(1/V)*(1/(1E-15))*(1/Avo)*(10^6) %uM molar gene concentration
Mc = 2.8*10^-13; %gDW/cell
L = 1000; %nt characteristic transcrription length
Ex = 25; %nt/sec elongation rate of transcription
KI = 4*10^-2;% sec^-1 rate of initiatation
Kx = 0.0136; % uM saturation constant for transcription
RxT = 2000; % #RNAP/cell
RxTconv = RxT*(1/Mc)*(1/Avo)*(10^9) %nmol/gDW converted RNAP concentration
KE = Ex/L %sec^-1 elongation rate constant
Ke_conv = KE*(60)*(60) %hr^-1 converted elongation rate constant
tau = KE/KI %time constant for transcription
rx = KE*RxTconv*(Gconv/(tau*Kx+(tau+1)*G)) %kinetic transcription rate
Kai = rx/(mu_conv+thetha_conv) %Gain function

