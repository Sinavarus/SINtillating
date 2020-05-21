%Barituziga Banuna
%CHEME 7770 FINAL PROJECT - Viscoelastic Behavior

%This code is a modification of code provided by the Odde Lab
%Special Thanks to the Odde Lab and Bengaser from which the core of the
%code was written

%Reduplicate the Chan Motor-Clutch model with event stepping
%Use for simulating multiple runs on several stiffnesses
%Fixed average velocity calculation
% 0 - disengaged clutch
% 1 - engaged clutch

%---------------------------------------------------------------------
clear
clc
close all

tic %TIME the script

nm=50; %number of myosin motors
Fm=-2; %motor stall force in pN
vu=-120; %unloaded motor velocity in nm/s
nc=50; %number of molecular clutches
kon=0.3; %On rate constant in 1/s
koff=0.1; %Off rate constant in 1/s
Fb=-2; %Bond rupture force in pN
Kc=0.8; %Clutch spring constant in pN/nm
gain=0; %gain of feedback loop

%n = 10
viscosity = logspace(-2,2,10); %define viscosity pNs/nm

events=1e5; %number of events to simulate
stiffness=logspace(-2,2,10); %define stiffness vector
retro=zeros(1,length(stiffness)); %initialize retro flow vector
failfreq=zeros(1,length(stiffness)); %initialize failure frequency vector
avnumcon=zeros(1,length(stiffness)); %initialize average number of engaged clutches vector
avcough=zeros(1,length(stiffness)); %initialize average koff vector
avtime=zeros(1,length(stiffness)); %initialize average timestep vector
avtrac=zeros(1,length(stiffness)); %initialize average traction force vector
avsubpos=zeros(1,length(stiffness)); %initialize average substrate position vector
avFc=zeros(1,length(stiffness)); %initialize average clutch force vector
binds=zeros(1,length(stiffness)); %initialize number of binding events
failures=zeros(1,length(stiffness)); %initialize number of failure events
cyct=zeros(1,length(stiffness)); %initialize cycle time
velcv=zeros(1,length(stiffness)); %initialize velocity cv
rebcyc=zeros(1,length(stiffness)); %initialize rebinds per cycle

%XC = zeros(length(stiffness),events+1,nc); %initialize clutch position 3D matrix
%FC = zeros(length(stiffness),events+1,nc); %initialize clutch Force 3D matrix
%XSUB = zeros(length(stiffness),events+1); %initialize substrate position 3D matrix

STIFF = zeros(length(stiffness),length(viscosity));
RETRO = zeros(length(stiffness),length(viscosity));
AVTRAC = zeros(length(stiffness),length(viscosity));
LEGENDS = zeros(1,length(viscosity));

%---------------------------------------------------------------------
for nn = 1:length(viscosity)
for jj=1:length(stiffness)
    
    n = viscosity(nn); %Substrate viscocity
    Ksub=stiffness(jj); %Substrate spring constant in pN/nm
    
    %initialize vectors for plots
    cstate=zeros(1,nc); %clutch state vector
    cunbind=zeros(1,nc); %clutch unbind state vector
    crebind=zeros(1,nc); %clutch rebind state vector
    xc=zeros(1,nc); %clutch position vector
    
    t=zeros(1,events+1); %time vector
    subpos=zeros(1,events+1); %substrate position vector
    numcon=zeros(1,events+1); %number of engaged clutches vector
    numcoff=zeros(1,events+1); %number of disengaged clutches vector
    vel=zeros(1,events+1); %velocity vector
    timestep=zeros(1,events+1); %vector of dt's
    cough=zeros(1,events+1); %koff vector
    Ft=zeros(1,events+1); %traction force vector
    totFc=zeros(1,events+1); %mean engaged clutch tension
    
    % Set inital state
    i=1;
    ceng=find(cstate==1); %find indices of engaged clutches
    
    cdisen=find(cstate==0); %find indices of disengaged clutches
    vf=vu; %claculate actin filament velocity
    xc(ceng)=xc(ceng)+vf*0.005; %claculate positions of engaged clutches(dt=0.005)
    xsub=(Kc*sum(xc(ceng))/(Ksub+length(ceng)*Kc)); %calculate substrate posisiton
    %vf=vu*(1-((Ksub*xsub)/(nm*Fm))); %claculate actin filament velocity
    %xc(ceng)=xc(ceng)+vf*0.005; %claculate positions of engaged clutches (dt=0.005)
    xc(cdisen)=xsub; %calculate posisiton of disengaged clutches
    Fc=Kc*(xc-xsub); %calculate force on each clutch
    t(i)=0;
    subpos(i)=xsub;
    numcon(i)=length(ceng);
    numcoff(i)=length(cdisen);
    vel(i)=-vf;
    timestep(i)=0;
    
    Ftrac=Ksub*xsub; %claculate traction force
    
    %Event stepping
    while i<=events
        i=i+1;
        
        %calculate clutch binding times
        if isempty(cdisen)
            tbind=inf;
        else
            tbind=-log(rand(1,length(cdisen)))/kon;
            
        end
    
        %calculate clutch unbinding times
        if isempty(ceng)
            tunbind=inf;
            cough(i)=koff;
            totFc(i)=0;
        else
            
            tunbind=-log(rand(1,length(ceng)))./(koff*exp(Fc(ceng)./(Fb+gain*Fc(ceng))));
            cough(i)=mean(koff*exp(Fc(ceng)./(Fb+gain*Fc(ceng))));
            totFc(i)=mean(Fc(ceng));
        end
        
        %find minimum time and execute that event
        [dtbind indbind]=min(tbind);
        [dtunbind indunbind]=min(tunbind);
        if dtbind<dtunbind %free clutch bind to actin
            cstate(cdisen(indbind))=1;
            dt=dtbind;
            binds(jj)=binds(jj)+1;
            if cunbind(cdisen(indbind))==1 %if clutch has already unbound during the cycle
                crebind(cdisen(indbind))=crebind(cdisen(indbind))+1;
            end
        else %engaged clutch disengages from actin
            cstate(ceng(indunbind))=0;
            dt=dtunbind;
            cunbind(ceng(indunbind))=1;
        end
        
        xsubo = xsub;
        ceng=find(cstate==1); %find indices of engaged clutches
        cdisen=find(cstate==0); %find indices of disengaged clutches
        Ftrac=Ksub*xsub+n*(xsub-xsubo)/dt; %claculate traction force
        vf=vu*(1-((Ksub*xsub+n*(xsub-xsubo)/dt)/(nm*Fm))); %claculate actin filament velocity
        %vf=vu;
        xc(ceng)=xc(ceng)+vf*dt; %claculate positions of engaged clutches
        
        %xsub=(Kc*sum(xc(ceng)))/(Ksub+length(ceng)); %calculate substrate posisiton
        
        %xsub=(Kc*sum(xc(ceng)))/(Ksub+length(ceng)*Kc+n/dt); % test
        xsub=(Kc*sum(xc(ceng))+n*xsubo/dt)/(Ksub+length(ceng)*Kc+n/dt);
        %%calculate substrate posisiton  

        
        %Ftrac=Ksub*xsub; %claculate traction force - old
        %vf=vu*(1-((Ksub*xsub)/(nm*Fm))); %claculate actin filament - old
        %xc(ceng)=xc(ceng)+vf*dt; %claculate positions of engaged clutches - old
        xc(cdisen)=xsub; %calculate posisiton of disengaged clutches
        Fc=Kc*(xc-xsub); %calculate force on each clutch
                
        if xsub==0 %reset unbind vector at failure event
            cunbind=zeros(1,nc);
        end
        
        t(i)=t(i-1)+dt;
        subpos(i)=xsub;
        numcon(i)=length(ceng);
        numcoff(i)=length(cdisen);
        vel(i)=-vf;
        timestep(i)=dt;
        Ft(i)=Ftrac;
        
        
        %XC(jj,i,:) = xc; %Outputs the position of the clutches, hopefully in a 3D array
        %XSUB(jj,i) = xsub; %Outputs the position of the substrate
        %FC(jj,i,:) = Fc; %Outputs the Forces on the clutches, hopefully in a 3D array
    
    end


    cyctime=diff(t(subpos==0)); %cycle time
    
    retro(jj)=sum((vel.*timestep)/t(events+1)); %weighted average retrograde flowrate
    failfreq(jj)=(length(numcon(numcon==0))-1)/(t(events+1)); %failures/s
    avnumcon(jj)=sum((numcon.*timestep)/t(events+1)); %average number of engaged clutches
    avcough(jj)=sum((cough.*timestep)/t(events+1)); %average koff
    avtime(jj)=mean(timestep); %average timestep
    avtrac(jj)=sum((Ft.*timestep)/t(events+1)); %average traction force
    avsubpos(jj)=sum((subpos.*timestep)/t(events+1)); %average substrate position
    avFc(jj)=sum((totFc.*timestep)/t(events+1)); %average force
    failures(jj)=(length(numcon(numcon==0))-1);
    cyct(jj)=mean(cyctime); %mean cycle time
    velcv(jj)=((sum(timestep.*((vel-retro(jj)).^2)/t(events+1)))^0.5)/retro(jj); %weighted actin flow coeffieicent of variation
    rebcyc(jj)=sum(crebind)./failures(jj);
    
    %PLOT THE FIGURES------------------------------------------
    
    %%{
    figure;
    plot(t,subpos);
    xlabel('time (s)');
    TITLE = sprintf('Stiffness Set Number %d Viscocity Set Number %d',jj,nn);
    ylabel('Substrate Position Xsub (nm)');
    title(TITLE);
    
    ax = gca;
    exportgraphics(ax,[TITLE '.png'])
    %%}

    
    %%{
    if jj == 1
        XSUB1 = subpos;
        TIME1 = t;
    elseif jj == length(stiffness)
        XSUB2 = subpos;
        TIME2 = t;
        
        figure;
        hold on
        plot(TIME1, XSUB1)
        plot(TIME2, XSUB2)
        xlabel('time (s)')
        ylabel('Substrate Position Xsub (nm)');
        LEGEND1 = sprintf('%d (pN/nm)',stiffness(1));
        LEGEND2 = sprintf('%d (pN/nm)',stiffness(jj));
        legend(LEGEND1,LEGEND2)
        %if max(TIME1) > max(TIME2)
        %    xlim([0 max(TIME2)])
        %end
        xlim([0 1000]);
        TITLE = sprintf('Stiff Set Number 1 and %d Visco Set %d',jj,nn);
        title(TITLE);

        ax = gca;
        exportgraphics(ax,[TITLE '.png'])

    end
    %%}

end
%PLOT THE FIGURES----------------------------------------


leg = sprintf('%d (pNs/nm)',viscosity(nn));
legs = string(leg);
STIFF(nn,:) = stiffness;
RETRO(nn,:) = retro;
AVTRAC(nn,:) = avtrac;
%LEGENDS(nn) = legs;


%%{
figure;
hold on
subplot(1,2,1)
semilogx(stiffness,retro)
xlabel('Substrate stiffness (pN/nm)')
ylabel('Mean retrograde flow (nm/s)')
TITLE = sprintf('Stiff vs Retro 1 Visco Set Number %d',nn);
title(TITLE);

ax = gca;
exportgraphics(ax,[TITLE '.png'])

subplot(1,2,2)
semilogx(stiffness,-avtrac)
xlabel('Substrate stiffness (pN/nm)')
ylabel('Mean traction force (pN)')
TITLE = sprintf('Stiff vs Tract 1 Visco Set Number %d',nn);
title(TITLE);

ax = gca;
exportgraphics(ax,[TITLE '.png'])


figure;
hold on
axes('NextPlot', 'add')
yyaxis left
plot(stiffness,-avtrac)%,stiffness, retro)
ylabel('Mean traction force (pN)')
yyaxis right
plot(stiffness, retro)
ylabel('Mean retrograde flow (nm/s)')
xlabel('Substrate stiffness (pN/nm)')
TITLE = sprintf('Stiff vs Tract and Retro 2 Visco Set Number %d',nn);
title(TITLE);
set(gca, 'XScale', 'log');

ax = gca;
exportgraphics(ax,[TITLE '.png'])

%%}

%%{
figure;
hold on
subplot(1,2,1)
semilogx(viscosity,retro)
xlabel('Substrate viscosity (pNs/nm)')
ylabel('Mean retrograde flow (nm/s)')

subplot(1,2,2)
semilogx(viscosity,-avtrac)
xlabel('Substrate viscosity (pNs/nm)')
ylabel('Mean traction force (pN)')
TITLE = sprintf('Visco vs Tract and Retro 1 Visco Set Number %d',nn);
title(TITLE);

ax = gca;
exportgraphics(ax,[TITLE '.png'])
%%}

%EXPORT THE SIMULATION DATA--------------------------------------------
%{
for h = 1:length(stiffness)
    for n = 1:nc
        g = sprintf('XC_%d_%d.txt',h,n);
        fileID = fopen(g,'w');
        fprintf(fileID,'%f ',XC(h,:,n));
        fclose(fileID);
    end
end

for y = 1:length(stiffness)
    for m = 1:nc
        g = sprintf('FC_%d_%d.txt',y,m);
        fileID = fopen(g,'w');
        fprintf(fileID,'%f ',FC(y,:,m));
        fclose(fileID);
    end
end

for j = 1:length(stiffness)
    k = sprintf('XSUB_%d.txt',j);
    fileID = fopen(k,'w');
    fprintf(fileID,'%f ',XSUB(j,:));
    fclose(fileID);
end
%}

end

%Plot all in one
figure;
hold on
for v = 1:length(viscosity)
    
    semilogx(STIFF(v,:),RETRO(v,:));
end
xlabel('Substrate stiffness (pN/nm)')
ylabel('Mean retrograde flow (nm/s)')
TITLE = 'Stiffness vs Retrograde Flow wi Various Viscosities (pNs/nm)';
TTL = 'Stiffness vs Retrograde Flow wi Various Viscosities';
legend(string(viscosity));
title(TITLE);
set(gca, 'XScale', 'log');
    
ax = gca;
exportgraphics(ax,[TTL '.png'])

figure;
hold on
for v = 1:length(viscosity)
    
    semilogx(STIFF(v,:),-AVTRAC(v,:));
end
xlabel('Substrate stiffness (pN/nm)')
ylabel('Mean traction force (pN)')
TITLE = 'Stiffness vs Traction Force wi Various Viscosities (pNs/nm)';
TTL = 'Stiffness vs Traction Force wi Various Viscosities';
legend(string(viscosity));
title(TITLE);
set(gca, 'XScale', 'log');
    
ax = gca;
exportgraphics(ax,[TTL '.png'])


toc %TIME the script