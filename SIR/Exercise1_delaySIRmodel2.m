clc
clear variables
close all

options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);

% %%Fig1
% alpha = 0.08;
% beta = 0.8;
% S_0 = 70;
% I_0 = 2;
% R_0 = 28;
% history = [S_0; I_0; R_0];
% tau = 10;
% delay=0:0.01:tau;
% 
% sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, history, [0, 10], options);
% t_SIR = sol.x;
% y_SIR = sol.y;
% population = sum(y_SIR,1);
% figure(1)
% hold on
% plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
% legend("S", "I", "R", 'Location','east')
% ylim([-5 105])
% xlabel("Time")
% ylabel("Population Size")
% 
% %%Fig2
% alpha = 0.3;
% beta = 0.8;
% S_0 = 70;
% I_0 = 2;
% R_0 = 28;
% history = [S_0; I_0; R_0];
% tau = 10;
% delay=0:0.01:tau;
% 
% sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, history, [0, 10], options);
% t_SIR = sol.x;
% y_SIR = sol.y;
% population = sum(y_SIR,1);
% figure(2)
% hold on
% plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
% legend("S", "I", "R", 'Location','east')
% ylim([-5 105])
% xlabel("Time")
% ylabel("Population Size")
% 
% %%Fig3
% alpha = 0.08;
% beta = 0.8;
% S_0 = 70;
% I_0 = 2;
% R_0 = 28;
% history = [S_0; I_0; R_0];
% tau = 5;
% delay=0:0.01:tau;
% 
% sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, history, [0, 10], options);
% t_SIR = sol.x;
% y_SIR = sol.y;
% population = sum(y_SIR,1);
% figure(3)
% hold on
% plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
% legend("S", "I", "R", 'Location','east')
% ylim([-5 105])
% xlabel("Time")
% ylabel("Population Size")
% 
% %%Fig4
% alpha = 0.08;
% beta = 0.8;
% S_0 = 70;
% I_0 = 2;
% R_0 = 28;
% history = [S_0; I_0; R_0];
% tau = 1;
% delay=0:0.01:tau;
% 
% sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, history, [0, 10], options);
% t_SIR = sol.x;
% y_SIR = sol.y;
% population = sum(y_SIR,1);
% figure(4)
% hold on
% plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
% legend("S", "I", "R", 'Location','east')
% ylim([-5 105])
% xlabel("Time")
% ylabel("Population Size")

%%Fig5
alpha = 0.08;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;
history = [S_0; I_0; R_0];
tau = 10;
delay=0:0.01:tau;

sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t)expHistory(t,history), [0, 10], options);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure(5)
hold on
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R", 'Location','east')
ylim([-5 105])
xlabel("Time")
ylabel("Population Size")

%%Fig6
alpha = 0.3;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;
history = [S_0; I_0; R_0];
tau = 10;
delay=0:0.01:tau;

sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t)expHistory(t,history), [0, 10], options);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure(6)
hold on
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R", 'Location','east')
ylim([-5 105])
xlabel("Time")
ylabel("Population Size")

%%Fig7
alpha = 0.08;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;
history = [S_0; I_0; R_0];
tau = 5;
delay=0:0.01:tau;

sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t)expHistory(t,history), [0, 10], options);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure(7)
hold on
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R", 'Location','east')
ylim([-5 105])
xlabel("Time")
ylabel("Population Size")

%%Fig8
alpha = 0.08;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;
history = [S_0; I_0; R_0];
tau = 1;
delay=0:0.01:tau;

sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t)expHistory(t,history), [0, 10], options);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure(8)
hold on
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R", 'Location','east')
ylim([-5 105])
xlabel("Time")
ylabel("Population Size")

function dydt = SIR(t, y, Z, alpha, beta)
fprintf(t + "\n");
S = y(1);
I = y(2);
R = y(3);

Sdel = Z(1,:);
Idel = Z(2,:);

Ihat = alpha.*Sdel.*Idel;
integral = sum(Ihat)/length(Ihat);

dydt(1) = -alpha*S*integral;        % susceptible
dydt(2) = alpha*S*integral - beta*I;  % infected
dydt(3) = beta*I;                   % recovered

dydt = dydt';
end

function history = expHistory(t, h)
history(1) = h(1) + h(2) - h(2)*exp(t);
history(2) = h(2)*exp(t);
history(3) = h(3);
history = history';
end
