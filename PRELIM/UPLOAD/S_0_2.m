function dydt = S_0_2(t,u)

    alx = 3.9*10^-2;         %Alphax
    aly = 4.3* 10^-3;        %Alphay
    betax = 6.1;             %Betax
    betay = 5.7;             %Betay
    sigy = 1.05;             %sigma y
    sigz = 1.04;             %sigma x
    zx = 1.3*10^-5;          %zx
    yz = 11*10^-3;           %yz
    xz = 12*10^-2;           %xz
    xy = 7.9*10^-4;          %xy
    nzx = 2.32;              %Nzx
    nxz = 2.0;               %Nxz
    nxy = 2.0;               %Nxy
    nyz = 2.0;               %Nyz

    S = 0.2;                 %S value

    dydt(1) = -u(1)+((alx+betax*S)/(1+S*(u(3)/zx)^nzx));               %dx/dt
    dydt(2) = -sigy*u(2)+((aly+betay*S)/(1+S*(u(1)/xy)^nxy));        %dy/dt
    dydt(3) = -sigz*u(3)+((1)/(1+((u(1)/xz)^nxz)+(u(2)/yz)^nyz));         %dz/dt
    dydt = [dydt(1);dydt(2);dydt(3)];
end