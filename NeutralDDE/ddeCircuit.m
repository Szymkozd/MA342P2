options = odeset('NormControl', 'on', 'MaxStep', 1);
sol = ddensd(@circuitFUN, @dely, @delyp, @history, [0, 40], options);

plot(sol.x,sol.y,'-')
xlabel('Time'); ylabel('Charge'); title('PEC Circuit with delay = 16'); grid on
ylim([-0.8,0.8])
legend("Element 1","Element 2","Element 3")

function dY = circuitFUN(t, y, ydel, ypdel)
    L = 100*[-7 1 2; 3 -9 0; 1 2 -6;];
    M = 100*[1 0 -3; -0.5 -0.5 -1; -0.5 -1.5 0;];
    N = (1/72)*[-1 5 2; 4 0 3; -2 4 1;];

    dY = L*y + M*ydel + N*ypdel;
end

function h = history(t)
    h = [sin(t); sin(2*t); sin(3*t)];
end

function dy = dely(t,y) 
    dy = t-16;
end

function dyp = delyp(t,y) 
    dyp = t-16;
end

