%% Exercise 1
clc
clear variables
close all

alpha = 0.08;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;

history = [S_0; I_0; R_0];
delay = 10;
% options = ddeset('NormControl', 'on', 'MaxStep', 1); % , 'RelTol', 1e6, 'AbsTol', 1e6

%% Const history
sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t) constHistory(t, history), [0, 50]);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure()
hold on
% plot solution
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R")
title("constant history")
ylim([-100 100])

%% Non const
sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t) expHistory(t, history), [0, 50]);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure()
hold on
% plot solution
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R")
title("non constant history")
ylim([-100 100])

function h = expHistory(t, h)
h(1) = h(1) + h(2) - h(2)*exp(t);
h(2) = h(2)*exp(t);
h(3) = h(3);
h = h';
end

function h = constHistory(t, h)
h(1) = h(1);
h(2) = h(2);
h(3) = h(3);
h = h';
end

function dydt = SIR(t, y, Z, alpha, beta)
fprintf(t + "\n");
S = y(1);
I = y(2);
R = y(3);

Sdel = Z(1,1);
Idel = Z(2,1);
Rdel = Z(3,1);

if(S < 1)
    S = 0;
end
if(I < 1)
    I = 0;
end
if(R < 1)
    R = 0;
end

Ihat = alpha*S*I;
Ihatdel = alpha*Sdel*Idel;

dydt(1) = -(Ihat - Ihatdel);        % susceptible
dydt(2) = Ihat - Ihatdel - beta*I;  % infected
dydt(3) = beta*I;                   % recovered

if(S < 1)
    dydt(1) = 0;
end
if(I < 1)
    dydt(1) = 0;
    dydt(2) = 0;
    dydt(3) = 0;
end
if(R < 1)
    dydt(3) = 0;
end
dydt = dydt';
end