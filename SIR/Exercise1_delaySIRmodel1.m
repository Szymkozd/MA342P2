%% Exercise 1
clc
clear variables
close all

%% Const history
% sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, history, [0, 100]);
% t_SIR = sol.x;
% y_SIR = sol.y;
% population = sum(y_SIR,1);
% figure()
% hold on
% plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
% legend("S", "I", "R")
% xlabel("Time")
% ylabel("Population Size")
% title("constant history")
% ylim([-5 100])

% %% Verification test
alpha = 0.08;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;

history = [S_0; I_0; R_0];
delay = 10;
sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t) expHistory(t, history), [0, 10]);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure()
hold on
% plot solution
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R", 'Location','east')
xlabel("Time")
ylabel("Population Size")
% title("Modified SIR with Non-Constant History")
ylim([-5 S_0+I_0+R_0+5])

% %% application1
alpha = 0.3;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;

history = [S_0; I_0; R_0];
delay = 10;
sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t) expHistory(t, history), [0, 10]);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure()
hold on
% plot solution
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R", 'Location','east')
% title("Modified SIR with Non-Constant History")
xlabel("Time")
ylabel("Population Size")
ylim([-5 S_0+I_0+R_0+5])

% %% application2
alpha = 0.08;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;

history = [S_0; I_0; R_0];
delay = 5;
sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t) expHistory(t, history), [0, 10]);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure()
hold on
% plot solution
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R", 'Location','east')
% title("Modified SIR with Non-Constant History")
xlabel("Time")
ylabel("Population Size")
ylim([-5 S_0+I_0+R_0+5])

%% application3
alpha = 0.08;
beta = 0.8;
S_0 = 70;
I_0 = 2;
R_0 = 28;

history = [S_0; I_0; R_0];
delay = 1;
sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, @(t) expHistory(t, history), [0, 10]);
t_SIR = sol.x;
y_SIR = sol.y;
population = sum(y_SIR,1);
figure()
hold on
% plot solution
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
legend("S", "I", "R", 'Location','east')
% title("Modified SIR with Non-Constant History")
xlabel("Time")
ylabel("Population Size")
ylim([-5 S_0+I_0+R_0+5])

function history = expHistory(t, h)
history(1) = h(1) + h(2) - h(2)*exp(t);
history(2) = h(2)*exp(t);
history(3) = h(3);
history = history';
end

function dydt = SIR(t, y, Z, alpha, beta)
fprintf(t + "\n");
S = y(1);
I = y(2);
R = y(3);

Sdel = Z(1,1);
Idel = Z(2,1);

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