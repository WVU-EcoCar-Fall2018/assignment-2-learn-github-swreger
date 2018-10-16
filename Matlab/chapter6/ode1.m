% This M-file implements the ODE1 solver.  All lines that only pertain
% to the animation are indented and can be safely ignored when you
% interpret the code.
%
% Z Carwile
% 19-JAN-2009
function ode1
%% Simulink parameters
stepsize = 0.5;    % Config Parameters dialog
stoptime = 3;      % Config Parameters dialog
IC = 1;            % Integrator block

%% Initialize

state = IC;

        % Figure stuff
        close all
        %pause on
        fig = figure;
        title('ode1 (Euler method)');
        hold on;
        % Analytical solution
        time = 0:0.01:stoptime;
        plot(time,exp(-time));
        pb = uicontrol('Style','pushbutton','String','Next',...
            'Units','normalized','Position',[0.39 0.82 0.1 0.05],...
            'Callback','uiresume');
        line1 = text(1.5,0.9,'Consider differential equation:',...
            'FontWeight','bold');
        line2 = text(1.5,0.85,'$$\dot y + y = 0,  y(0) = 1$$',...
            'interpreter','latex');


%% Simulation loop
for t = 0:stepsize:stoptime
    
    %% Outputs
    output = state;
    
            % Figure stuff
            plot(t,output,'ro');
            line3 = sprintf('t = %4.2f',t);
            line3 = text(1.5,0.75,line3,'FontWeight','bold');
            line4 = text(1.5,0.7,'Output:');
            line5 = sprintf('$$y(%4.2f) = %4.2f$$',t,output);
            line5 = text(1.5,0.65,line5,'interpreter','latex');

            % Animation
            axis([0 stoptime 0 1])
            uiwait;
   
    %% Derivatives/Updates
    deriv = -1*state;
    state = state + deriv*stepsize;
    
            %Figure stuff
            plot([t t+stepsize],[state-deriv*stepsize state],'r:');
            line6 = text(1.5,0.60,'Derivative:');
            line7 = sprintf('$$\\dot y(%4.2f) = -y(%4.2f) = %4.2f$$',...
                t,t,deriv);
            line7 = text(1.5,0.55,line7,'interpreter','latex');
            line8 = text(1.5,0.5,'Update:');
            line9 = sprintf(...
                '$$y(%4.2f) = y(%4.2f) + \\dot y(%4.2f) * \\Delta t$$',...
                t+stepsize,t,t);
            line9 = text(1.5,0.45,line9,'interpreter','latex');

            % Animation and cleanup
            axis([0 stoptime 0 1])
            uiwait;
            delete([line3 line4 line5 line6 line7 line8 line9]);
            
    
end    

%% Terminate
disp('Simulation complete!');

uiwait

close all
