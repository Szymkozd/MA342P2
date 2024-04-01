%% Parametrically generates the model from the input topology graph and evaluates it at (t,x,Z)
% INPUTS (t,x,Z,topology,y,z)
% t - time
% x - value of function at time t
% Z - value of function at time (t-delay(i))
% topology - square matrix representing node connections and delays
% y - weight for sending away computation
% z - rate of computing

function dX = cloudFUN(t, x, Z, topology, y, z)
fprintf(t + "\n")
N = length(x);              % Number of nodes
c = 1.01*sum(x)/N;          % distributed computation for a single node
cd = 1.01*sum(Z,1)/N;       % delayed distributed computation for a single node
w = y./sum(topology>0,2);   % weight for receiving computation based on number of connected nodes

for i = 1:N % i represents the node itself
    dx = 0;
    for j = 1:N % j represents nodes that could be connected
        if topology(i,j) == 0 % the selected node
            dx = dx - (x(i)>c)*y;              % sending
            dx = dx - (x(i)<=c)*(x(i)>0)*z(i); % computing
            if(x(i) < 0)
                dx = 0;
            end
        elseif topology(i,j) > 0  % connected nodes
            dx = dx + (Z(j,topology(i,j))>cd(topology(i,j)))*w(i); % receiving
        end
    end
    dX(i) = dx;
end
dX = dX';
end
% % Redistribute computing tasks
% %           in         in         out           compute
% dX(1) = (x2d>cd)*w + (x3d>cd)*w - (x1>c)*y - (x1<=c)*(x1>0)*z;
% dX(2) = (x1d>cd)*w + (x3d>cd)*w - (x2>c)*y - (x2<=c)*(x2>0)*z;
% dX(3) = (x1d>cd)*w + (x2d>cd)*w - (x3>c)*y - (x3<=c)*(x3>0)*z;
% dX = dX';