clc
clear all
close all
tic

%% El-Nino Data

data = xlsread('ElNinoData.xlsx');
count = 1;
for i = 1:1:66
    for j = 2:1:13
        history_vec(count) = data(i,j);
        count = count + 1;
    end
end
t_vec_extended = -66:(66/792):0;
for i = 1:1:length(t_vec_extended)-1
    t_vec(i) = t_vec_extended(i);
end

%% Exercise 2

% Constant History T(t) = 1
% Instance 1
sol1_1 = dde23(@calcdT1_1,0.01,1,[0 10]);
x_hist1_1 = -2:0.1:0;
y_hist1_1 = linspace(1,1,length(x_hist1_1));
figure(1)
subplot(2,3,1)
plot(x_hist1_1,y_hist1_1,'k--',sol1_1.x,sol1_1.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 1')

% Instance 2
sol1_2 = dde23(@calcdT1_2,0.15,1,[0 10]);
x_hist1_2 = -2:0.1:0;
y_hist1_2 = linspace(1,1,length(x_hist1_2));
subplot(2,3,2)
plot(x_hist1_2,y_hist1_2,'k--',sol1_2.x,sol1_2.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 2')

% Instance 3
sol1_3 = dde23(@calcdT1_3,0.995,1,[0 10]);
x_hist1_3 = -2:0.1:0;
y_hist1_3 = linspace(1,1,length(x_hist1_3));
subplot(2,3,3)
plot(x_hist1_3,y_hist1_3,'k--',sol1_3.x,sol1_3.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 3')

% Instance 4
sol1_4 = dde23(@calcdT1_4,[0.9 0.1],1,[0 10]);
x_hist1_4 = -2:0.1:0;
y_hist1_4 = linspace(1,1,length(x_hist1_4));
subplot(2,3,4)
plot(x_hist1_4,y_hist1_4,'k--',sol1_4.x,sol1_4.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 4')

% Instance 5
sol1_5 = dde23(@calcdT1_5,[0.6 0.6],1,[0 10]);
x_hist1_5 = -2:0.1:0;
y_hist1_5 = linspace(1,1,length(x_hist1_5));
subplot(2,3,5)
plot(x_hist1_5,y_hist1_5,'k--',sol1_5.x,sol1_5.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 5')

% Constant History T(t) = 0
% Instance 1
sol2_1 = dde23(@calcdT1_1,0.01,0,[0 10]);
x_hist2_1 = -2:0.1:0;
y_hist2_1 = linspace(0,0,length(x_hist2_1));
figure(2)
subplot(2,3,1)
plot(x_hist2_1,y_hist2_1,'k--',sol2_1.x,sol2_1.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 1')

% Instance 2
sol2_2 = dde23(@calcdT1_2,0.15,0,[0 10]);
x_hist2_2 = -2:0.1:0;
y_hist2_2 = linspace(0,0,length(x_hist2_2));
subplot(2,3,2)
plot(x_hist2_2,y_hist2_2,'k--',sol2_2.x,sol2_2.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 2')

% Instance 3
sol2_3 = dde23(@calcdT1_3,0.995,0,[0 10]);
x_hist2_3 = -2:0.1:0;
y_hist2_3 = linspace(0,0,length(x_hist2_3));
subplot(2,3,3)
plot(x_hist2_3,y_hist2_3,'k--',sol2_3.x,sol2_3.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 3')

% Instance 4
sol2_4 = dde23(@calcdT1_4,[0.9 0.1],0,[0 10]);
x_hist2_4 = -2:0.1:0;
y_hist2_4 = linspace(0,0,length(x_hist2_4));
subplot(2,3,4)
plot(x_hist2_4,y_hist2_4,'k--',sol2_4.x,sol2_4.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 4')

% Instance 5
sol2_5 = dde23(@calcdT1_5,[0.6 0.6],0,[0 10]);
x_hist2_5 = -2:0.1:0;
y_hist2_5 = linspace(0,0,length(x_hist2_5));
subplot(2,3,5)
plot(x_hist2_5,y_hist2_5,'k--',sol2_5.x,sol2_5.y,'b-')
xlabel('Time')
ylabel('Temperature')
title('Instance 5')

%% Exercise 3

data = xlsread('ElNinoData.xlsx');
count = 1;
for i = 1:1:66
    for j = 2:1:13
        history_vec(count) = data(i,j);
        count = count + 1;
    end
end

t_vec_extended = -66:(66/792):0;
for i = 1:1:length(t_vec_extended)-1
    t_vec(i) = t_vec_extended(i);
end


actual_data = xlsread('2013_2022data.xlsx');
count = 1;
for i = 1:1:10
    for j = 2:1:13
        history_vec_actual(count) = actual_data(i,j);
        count = count + 1;
    end
end
t_vec_actual = 0:10/120:(10-(10/120));

sol_10_7 = dde23(@calcdT,10,@(t)history(t,t_vec,history_vec),[0 30]);
figure(3)
plot(t_vec,history_vec,'r-',sol_10_7.x,sol_10_7.y,'b-')
xlabel('Time (t) - Yearly Index')
ylabel('Temperature')

figure(4)
plot(sol_10_7.x,sol_10_7.y,'b-',t_vec_actual,history_vec_actual,'r-')
xlabel('Time (t) - Yearly Index')
ylabel('Temperature')

toc

%% FUNCTIONS
function [dT1_1] = calcdT1_1(t,T,Z)

alpha = 1;
beta = 0;
kappa = 100;
gamma = 1;

T_lag1 = Z(:,1);
dT1_1 = -alpha*tanh(kappa*(T_lag1)) + beta*tanh(kappa*(T)) + gamma*cos(2*pi*t);

end

function [dT1_2] = calcdT1_2(t,T,Z)

alpha = 1;
beta = 0;
kappa = 100;
gamma = 1;

T_lag1 = Z(:,1);
dT1_2 = -alpha*tanh(kappa*(T_lag1)) + beta*tanh(kappa*(T)) + gamma*cos(2*pi*t);

end

function [dT1_3] = calcdT1_3(t,T,Z)

alpha = 1;
beta = 0;
kappa = 100;
gamma = 1;

T_lag1 = Z(:,1);
dT1_3 = -alpha*tanh(kappa*(T_lag1)) + beta*tanh(kappa*(T)) + gamma*cos(2*pi*t);

end

function [dT1_4] = calcdT1_4(t,T,Z)

alpha = 1;
beta = 1;
kappa = 10;
gamma = 1;

T_lag1 = Z(:,1);
T_lag2 = Z(:,2);
dT1_4 = -alpha*tanh(kappa*(T_lag1)) + beta*tanh(kappa*(T_lag2)) + gamma*cos(2*pi*t);

end

function [dT1_5] = calcdT1_5(t,T,Z)

alpha = 1.2;
beta = 0.8;
kappa = 10;
gamma = 1;

T_lag1 = Z(:,1);
T_lag2 = Z(:,2);
dT1_5 = -alpha*tanh(kappa*(T_lag1)) + beta*tanh(kappa*(T_lag2)) + gamma*cos(2*pi*t);

end

function y = history(t,t_vec,history_vec)

y = spline(t_vec,history_vec,t);

end

function [dT] = calcdT(t,T,Z)

alpha = 1.2;

T_lag = Z(:,1);
dT = -alpha*T_lag + T - T^3;

end