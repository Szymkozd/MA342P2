function plotSolution(sol, figureNum)
y = sol.y;
x = sol.x;
[nodes, ~] = size(y);
figure(figureNum);
set(gcf, "Position", [50 50 1200 500])
hold on
% Plot each individual node
for i = 1:nodes
    plot(x,y(i,:));
    legendText(i) = "Node " + i;
end
% Plot the total computation quantity remaining
plot(x,sum(y,1),'k--');
yline(0)
legendText(i + 1) = "Total Remaining Computation";
% title(nodes + " Node Computing");
legend(legendText, 'Location', 'eastoutside')
xlabel("Time")
ylabel("Computation Quantity")
end