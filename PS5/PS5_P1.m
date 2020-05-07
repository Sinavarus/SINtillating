    syms Ri Ris Rs Rss Kf Kr Ke Kes Krec Kdeg Vs L RiT
    eqn1 = -Kf*L*Rs+Kr*Rss-Ke*Rs+Krec*Ri+Vs==0;
    eqn2 = Kf*L*Rs-Kr*Rss-Kes*Rss+Krec*Ris==0;
%    eqn3 = Ri+Ris==RiT;
    eqn4 = Kes*Rss-Kdeg*Ris-Krec*Ris==0;
    eqn5 = Ke*Rs-Kdeg*Ri-Krec*Ri==0;
    S = solve([eqn1,eqn2,eqn4,eqn5],[Ri, Rs, Rss, Ris])
    RssSol = S.Rss
    RisSol = S.Ris
    RT = RssSol+RisSol
    RTMax = limit(RT,L,Inf)