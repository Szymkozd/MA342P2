%% Solving SIR with ODE45 (no delay)
clc
clear variables
close all

k = 0.3;
S_0 = 60;
I_0 = 2;
R_0 = 38;

% Traditional SIR model
[t_SIR,y_SIR] = ode45(@SIR, [0, 10], [S_0;I_0;R_0]);
figure();
plot(t_SIR,y_SIR(:,1),'g-',t_SIR,y_SIR(:,2),'k-',t_SIR,y_SIR(:,3),'r-');
xlabel("Time (t)")
ylabel("Population")
title("Traditional SIR Model");
legend("S", "I", "R", "Location", "east")

% Adapted SIR model
[t_aSIR,y_aSIR] = ode45(@aSIR, [0, 10], [S_0;I_0;R_0]);
figure();
plot(t_aSIR,y_aSIR(:,1),'g-',t_aSIR,y_aSIR(:,2),'k-',t_aSIR,y_aSIR(:,3),'r-');
xlabel("Time (t)")
ylabel("Population")
title("Adapted SIR Model");
legend("S", "I", "R", "Location", "east")

function dydt = SIR(t, y)
alpha = 0.08;
beta = 0.8;
S = y(1);
I = y(2);
R = y(3);
dydt(1) = -alpha*S*I;
dydt(2) = alpha*S*I - beta*I;
dydt(3) = beta*I;
dydt = dydt';
% N = sum(dydt);
end

function dydt = aSIR(t, y)
alpha = 0.08;
beta = 0.8;
k = 0.3;
S = y(1);
I = y(2);
R = y(3);
dydt(1) = -alpha*S*I + k*beta*I;
dydt(2) = alpha*S*I - beta*I;
dydt(3) = (1-k)*beta*I;
dydt = dydt';
% N = sum(dydt);
end