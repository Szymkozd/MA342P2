clc
clear variables
close all

%% TOPOLOGY STRUCTURE
% must be symmetric along diagonal
% size of matrix dictates number of nodes
% diagonal must be zeros
% -1 indicates disconnected nodes
% any delay must be a integer less than 10 due to the way delays are calculated

%% Example 1
% N = 10;
% history = 1:N;
% topology = ones(10);
% topology = topology.*-(eye(height(topology))-1);
% z = ones(N);
% z(5)=5;

%% Example 2
% history = [0;0;0;0];
% topology = [0, 1,  1, 5;
%             1, 0,  1, 5;
%             1, 1,  0, 5;
%             5, 5,  5, 0];
% z = [1;1;1;1];

%% Example 3
% history = [10;20;70];
% topology = [0, 1, 1;
%             1, 0, 1;
%             1, 1, 0];
% z = [1;1;1];

%% Example 4
history = [2;8];
topology = [0, 8;
            8, 0];
z = [1;1];

%% Example 5
% history = [10;20;30;40];
% topology = [0, 1, 2, 3;
%             1, 0, 1, 3;
%             2, 1, 0, -1;
%             3, 3, -1, 0];
% z = [1;1;1;1];        % rate of computation

%% Example 8 Hub & Spoke
% topology = [0, 1, -1, -1, -1;
%             1, 0,  4,  5,  7; 
%            -1, 4,  0, -1, -1; 
%            -1, 5, -1,  0, -1; 
%            -1, 7, -1, -1, 0;];
% z = [1;1;1;1;1];      % rate of computation

y = 5;                  % weight for sending away computation (scalar)
delays = 1:10;
options = odeset('NormControl', 'on', 'MaxStep', 1, 'RelTol', 1e-2, 'AbsTol',1e-2);
sol = dde23(@(t,x,Z)cloudFUN(t,x,Z,topology,y,z), delays, history, [0 100], options);
plotSolution(sol)
