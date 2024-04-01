clc
clear variables
close all

% TOPOLOGY STRUCTURE
% must be symmetric along diagonal
% size of matrix dictates number of nodes
% diagonal must be zeros
% -1 indicates disconnected nodes
% any delay must be a integer less than 10 due to the way delays are calculated

%% Verification Model 1
% history = [2,8];
% topology = [0, 1;
%             1, 0];
% z = [1,1];
% 
% y = 5; % weight for sending away computation (scalar)
% delays = 1:10;
% options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);
% sol = dde23(@(t,x,Z)cloudFUN(t,x,Z,topology,y,z), delays, history, [0 15], options);
% plotSolution(sol, 1)

%% Verification Model 2
% history = 1:10;
% topology = ones(10)-eye(10);
% z = ones(10);
% 
% y = 5; % weight for sending away computation (scalar)
% delays = 1:10;
% options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);
% sol = dde23(@(t,x,Z)cloudFUN(t,x,Z,topology,y,z), delays, history, [0 8], options);
% plotSolution(sol, 2)

%% Star formation
% history = [10;20;30;40;50];
% topology = [ 0, -1,  1,  1, -1;
%             -1,  0, -1,  1,  1;
%              1, -1,  0, -1,  1;
%              1,  1, -1,  0, -1;
%             -1,  1,  1, -1,  0];
% z = ones(5,1);
% y = 5; % weight for sending away computation (scalar)
% delays = 1:10;
% options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);
% sol = dde23(@(t,x,Z)cloudFUN(t,x,Z,topology,y,z), delays, history, [0 50], options);
% plotSolution(sol, 3)

%% Hub and Spoke
% % hub is able to compute much faster, starts with more computation
% history = [110;8;9;11;12];
% topology = [0,  1,  1,  1,  1;
%             1,  0, -1, -1, -1;
%             1, -1,  0, -1, -1;
%             1, -1, -1,  0, -1;
%             1, -1, -1, -1,  0];
% z = [5;1;1;1;1];
% y = 5; % weight for sending away computation (scalar)
% delays = 1:10;
% options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);
% sol = dde23(@(t,x,Z)cloudFUN(t,x,Z,topology,y,z), delays, history, [0 15], options);
% plotSolution(sol, 4)
% 
% % hub is faster, starts with less computation
% history = [10; 33; 34; 36; 37];
% topology = [0,  1,  1,  1,  1;
%             1,  0, -1, -1, -1;
%             1, -1,  0, -1, -1;
%             1, -1, -1,  0, -1;
%             1, -1, -1, -1,  0];
% z = [5;1;1;1;1];
% y = 5; % weight for sending away computation (scalar)
% delays = 1:10;
% options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);
% sol = dde23(@(t,x,Z)cloudFUN(t,x,Z,topology,y,z), delays, history, [0 35], options);
% plotSolution(sol, 5)

%% Corrupted Node
% corrupted
history = [55; 10; 45];
topology = [0, 20, 0;
            20, 0, 1;
            0, 1, 0];
z = [1;1;1];
y = 5; % weight for sending away computation (scalar)
delays = 1:20;
options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);
sol = dde23(@(t,x,Z)cloudFUN(t,x,Z,topology,y,z), delays, history, [0 25], options);
plotSolution(sol, 6)

% non corrupted for comparison
history = [55; 10; 45];
topology = [0, 1, 0;
            1, 0, 1;
            0, 1, 0];
z = [1;1;1];
y = 5; % weight for sending away computation (scalar)
delays = 1:20;
options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);
sol = dde23(@(t,x,Z)cloudFUN(t,x,Z,topology,y,z), delays, history, [0 25], options);
plotSolution(sol, 7)

