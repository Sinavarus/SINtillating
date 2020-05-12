%Barituziga Banuna
%PRELIM 1 P2 Part D
clc
clear

tspan = [0,100];
u0 = [0,0,0];

%-----------------------------------------------------
%S = 0.02
[t,u]=ode45(@S_0_2,tspan,u0);
figure;
plot(t,[u(:,1),u(:,2),u(:,3)]);
xlabel('t');ylabel('Concentration');
TITLE = 'Concentration vs. time S = 0.02';
title(TITLE);
legend('X','Y','Z')

ax = gca;
exportgraphics(ax, [TITLE '.png'])


%Induvidual Graphs
[t,u]=ode45(@S_0_2,tspan,u0);
figure;
plot(t,u(:,1));
xlabel('t');ylabel('X');
TITLE = 'X vs. time S = 0.02';
title(TITLE);
legend('X')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

[t,u]=ode45(@S_0_2,tspan,u0);
figure;
plot(t,u(:,2));
xlabel('t');ylabel('Y');
TITLE = 'Y vs. time S = 0.02';
title(TITLE);
legend('Y')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

[t,u]=ode45(@S_0_2,tspan,u0);
figure;
plot(t,u(:,3));
xlabel('t');ylabel('Z');
TITLE = 'Z vs. time S = 0.02';
title(TITLE);
legend('Z')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

%-------------------------------------------------------
%S = 10.0
[t,u]=ode45(@S_10,tspan,u0);
figure;
plot(t,[u(:,1),u(:,2),u(:,3)]);
xlabel('t');ylabel('Concentration');
TITLE = 'Concentration vs. time S = 10.0';
title(TITLE);
legend('X','Y','Z')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

%Induvidual Graphs
[t,u]=ode45(@S_10,tspan,u0);
figure;
plot(t,u(:,1));
xlabel('t');ylabel('X');
TITLE = 'X vs. time S = 10.0';
title(TITLE);
legend('X')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

[t,u]=ode45(@S_10,tspan,u0);
figure;
plot(t,u(:,2));
xlabel('t');ylabel('Y');
TITLE = 'Y vs. time S = 10.0';
title(TITLE);
legend('Y')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

[t,u]=ode45(@S_10,tspan,u0);
figure;
plot(t,u(:,3));
xlabel('t');ylabel('Z');
TITLE = 'Z vs. time S = 10.0';
title(TITLE);
legend('Z')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

%----------------------------------------------------------
%S = 100000.0
[t,u]=ode45(@S_100000,tspan,u0);
figure;
plot(t,[u(:,1),u(:,2),u(:,3)]);
xlabel('t');ylabel('Concentration');
TITLE = 'Concentration vs. time S = 100000';
title(TITLE);
legend('X','Y','Z')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

%Induvidual Graphs
[t,u]=ode45(@S_100000,tspan,u0);
figure;
plot(t,u(:,1));
xlabel('t');ylabel('X');
TITLE = 'X vs. time S = 100000';
title(TITLE);
legend('X')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

[t,u]=ode45(@S_100000,tspan,u0);
figure;
plot(t,u(:,2));
xlabel('t');ylabel('Y');
TITLE = 'Y vs. time S = 100000';
title(TITLE);
legend('Y')

ax = gca;
exportgraphics(ax, [TITLE '.png'])

[t,u]=ode45(@S_100000,tspan,u0);
figure;
plot(t,u(:,3));
xlabel('t');ylabel('Z');
TITLE = 'Z vs. time S = 100000';
title(TITLE);
legend('Z')
