function odeff

% This M-file animates an ODE45 solver.  All lines that only pertain
% to the animation are indented and can be safely ignored when you
% interpret the code.
%
% Z Carwile
% 21-JAN-2009

%% Simulink parameters
maxstepsize = 1;    % Config Parameters dialog
stoptime = 3;      % Config Parameters dialog
IC = 1;            % Integrator block

%% Initialize

open_system('simpleFirstOrder');
set_param(gcs,'SolverType','Fixed-step');
set_param(gcs,'StopTime',num2str(maxstepsize))

        % Figure stuff
        close all
        figure
        title('ode45');
        axis([0 stoptime 0 1])
        hold on;
        pb = uicontrol('Style','pushbutton','String','Next',...
            'Units','normalized','Position',[0.39 0.82 0.1 0.05],...
            'Callback','uiresume');
        line1 = text(1.5,0.9,'Consider differential equation:',...
            'FontWeight','bold');
        line2 = text(1.5,0.85,'$$\dot y + y = 0,  y(0) = 1$$',...
            'interpreter','latex');
        uiwait

%% ODE4 estimate
set_param(gcs,'Solver','ode4');
set_param(gcs,'FixedStep',num2str(maxstepsize));
[t,x,y4] = sim('simpleFirstOrder');

        % Figure stuff
        plot(t,y4,'ro:');
        axis([0 stoptime 0 1])
        line3 = text(1.5,0.75,'ODE4 Estimate:');
        line4 = sprintf('$$y_4(%5.3f) = %5.3f$$',t(end),y4(end));
        line4 = text(1.5,0.7,line4,'interpreter','latex');
        uiwait

%% ODE5 estimate
set_param(gcs,'Solver','ode5');
set_param(gcs,'FixedStep',num2str(maxstepsize));
[t,x,y5] = sim('simpleFirstOrder');
        
        % Figure stuff
        plot(t,y5,'mo:');
        axis([0 stoptime 0 1])
        line5 = text(1.5,0.6,'ODE5 Estimate:');
        line6 = sprintf('$$y_5(%5.3f) = %5.3f$$',t(end),y5(end));
        line6 = text(1.5,0.55,line6,'interpreter','latex');
        legend('ODE4','ODE5','Location','SW');
        uiwait
        delete([line1 line2 line3 line4 line5 line6]);

%% Error explanation

        % Tightening limits
        ave = (y4(end)+y5(end))/2;
        posx = t(end) + 0.001;
        posy = ave+0.008;
        h = plot([t(end) t(end)],[y4(end) y5(end)],'k-');
        axis([t(end)-0.01,t(end)+0.01,ave-0.01,ave+0.01])
        uiwait

% Absolute error
AE = y4(end) - y5(end);

        line3 = text(posx,posy,'Absolute error:');
        line4 = sprintf('$$|y_4 - y_5| = $$');
        line4 = text(posx,posy-0.001,line4,'interpreter','latex');
        line5 = sprintf('$$|%5.3f - %5.3f| = %5.3f $$',...
            y4(end),y5(end),AE);
        line5 = text(posx,posy-0.002,line5,'interpreter','latex');
        uiwait

% Relative error        
RE = AE/y5(end);      

        line6 = text(posx,posy-0.004,'Relative error:');
        
        line7 = sprintf('$$|y_4 - y_5| / |y5|  = $$');
        line7 = text(posx,posy-0.005,line7,'interpreter','latex');
        line8 = sprintf('$$|%5.3f-%5.3f|/|%5.3f| = %5.3f $$',...
            y4(end),y5(end),y5(end),RE);
        line8 = text(posx,posy-0.006,line8,'interpreter','latex');
        uiwait

%% Tolerances

        line9 = text(posx,posy-0.008,'Is at least one error less');
        line10 = text(posx,posy-0.009,'than its specified tolerance?');
        uiwait
        line11 = text(posx,posy-0.011,'YES:','FontWeight','bold');
        line12 = text(posx,posy-0.012,'Continue to next time step!');
        uiwait
        line13 = text(posx,posy-0.014,'NO:','FontWeight','bold');
        line14 = text(posx,posy-0.015,'Repeat process with smaller step');
        uiwait
        delete([line3,line4,line5,line6]);
        delete([line7,line8,line9,line10]);
        delete([line11,line12,line13,line14]);
        delete(h);
        
%% Analytical Solution

t = 0:0.01:3;
plot(t,exp(-t));
legend('ODE4','ODE5','Analytical','Location','SW');
%axis([0 stoptime 0 1])       
uiwait

%% Clean up
close all
close_system('simpleFirstOrder',0);
disp('Simulation complete!');
