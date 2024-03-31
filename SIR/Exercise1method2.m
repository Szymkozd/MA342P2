%% Exercise 1
clc
clear variables
close all

alpha = 0.08;
beta = 0.01;
kappa = 0.3;
S_0 = 90;
I_0 = 10;
R_0 = 0;

history = [S_0; I_0; R_0];
delay = 1;
% options = ddeset('NormControl', 'on', 'MaxStep', 1); % , 'RelTol', 1e6, 'AbsTol', 1e6

%%
sol = ddesd(@(t, y, Z) SIR(t, y, Z, alpha, beta), delay, history, [0, 10]);
t_SIR = sol.x;
y_SIR = sol.y;
yp_SIR = sol.yp;
population = sum(y_SIR,1);
hold on
plot(t_SIR, y_SIR(1,:), 'b-',t_SIR, y_SIR(2,:), 'g-', t_SIR, y_SIR(3,:), 'r-',t_SIR,population,'.k')
plot(linspace(-delay,0,101), ones(101)*history(1), 'b--', linspace(-delay,0,101), ones(101)*history(2), 'g--', linspace(-delay,0,101), ones(101)*history(3), 'r--');
% plot(t_SIR, yp_SIR(1,:), 'b--',t_SIR, yp_SIR(2,:), 'g--', t_SIR, yp_SIR(3,:), 'r--')
legend("S", "I", "R")
ylim([-100 100])

function dydt = SIR(t, y, Z, alpha, beta)
S = y(1);
I = y(2);
R = y(3);

Sdel = Z(1,1);
Idel = Z(2,1);
Rdel = Z(3,1);

Ihat = alpha*S*I;
Ihatdel = alpha*Sdel*Idel;

dydt(1) = -(Ihat - Ihatdel);        % susceptible
dydt(2) = Ihat - Ihatdel - beta*I;  % infected
dydt(3) = beta*I;                   % recovered

if(S < 0)
    dydt(1) = 0;
end
if(I < 0)
    dydt(1) = 0;
    dydt(2) = 0;
    dydt(3) = 0;
end
if(R < 0)
    dydt(3) = 0;
end
dydt = dydt';
end

%% Potentially implement a different numerical integration technique using function history to validate this method of calcuation