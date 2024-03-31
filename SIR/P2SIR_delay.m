%% Solving SIR with delay
clc
clear variables
close all

tau = 10;
alpha = 0.3095;
beta = 0.2;
rho = 1174.17;
epsilon = 0.0063;
delta = 3.9139e-5;

u = 0.01;
S_0 = 30e6;
I_0 = 30;
R_0 = 28;
history = [S_0; I_0; R_0];
delay = 10;
% options = 

% SIR model with vaccination delay
sol = ddesd(@(t, y, Z) dSIR(t, y, Z, alpha, beta, rho, epsilon, delta, u), delay, history, [0, 200]);
t_dSIR = sol.x;
y_dSIR = sol.y;
figure(1);
plot(t_dSIR,y_dSIR(1,:),'g--',t_dSIR,y_dSIR(3,:),'r--');
xlabel("Time (t)")
ylabel("Population")
title("SIR Model with Vaccination delays");
figure(2);
plot(t_dSIR,y_dSIR(2,:),'k--');

u = 0.02;

% SIR model with vaccination delay
sol = ddesd(@(t, y, Z) dSIR(t, y, Z, alpha, beta, rho, epsilon, delta, u), [delay;0;0], history, [0, 200]);
t_dSIR = sol.x;
y_dSIR = sol.y;
figure(1);
hold on
plot(t_dSIR,y_dSIR(1,:),'g-',t_dSIR,y_dSIR(3,:),'r-');
figure(2);
hold on
plot(t_dSIR,y_dSIR(2,:),'k-');
title("SIR Model with Vaccination delays");
xlabel("Time (t)")
ylabel("Population")

function dydt = dSIR(t, y, Z, alpha, beta, rho, epsilon, delta, u)
S = y(1);
I = y(2);
R = y(3);
N = S + I + R;
Sdel = Z(1,1);
dydt(1) = rho-alpha*S*I/N - delta*S - u*Sdel;
dydt(2) = alpha*S*I/N - (beta + delta + epsilon)*I;
dydt(3) = beta*I - delta*R + u*Sdel;
dydt = dydt';
end