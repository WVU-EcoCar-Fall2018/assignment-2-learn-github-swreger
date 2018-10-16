% This M-file implements the ODE2 solver.  All lines that only pertain
% to the animation are indented and can be safely ignored when you
% interpret the code.
%
% Z Carwile
% 19-JAN-2009

function ode2
%% Simulink parameters
stepsize = 0.5;    % Config Parameters dialog
stoptime = 3;      % Config Parameters dialog
IC = 1;            % Integrator block

%% Initialize

state = IC;

            % Figure stuff
            close all
            figure
            hold on;
            % Analytical solution
            time = 0:0.01:stoptime;
            plot(time,exp(-time));
            title('ode2 (Heun''s method)');
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
            delete([line4 line5]);

    %% Derivatives/Updates
    deriv_pred1 = -1*state;
    state_pred = state + deriv_pred1*stepsize;
    
            %Figure stuff
            h1 = plot([t t+stepsize],[state state_pred],'r:');
            line4 = text(1.5,0.7,'Predicted Derivative:');
            line5 = sprintf('$$\\dot y(%4.2f) = -y(%4.2f) = %4.2f$$',...
                t,t,deriv_pred1);
            line5 = text(1.5,0.65,line5,'interpreter','latex');

            % Animation
            h2 = plot(t+stepsize,state_pred,'ro');
            axis([0 stoptime 0 1])
            uiwait;
        
    deriv_pred2 = -1*state_pred;
    
            %Animation     
            line6 = text(1.5,0.60,'Predicted Derivative (next step)');   
            line7 = sprintf('$$\\dot y(%4.2f) = -y(%4.2f) = %4.2f$$',...
                t+stepsize,t+stepsize,deriv_pred2);
            line7 = text(1.5,0.55,line7,'interpreter','latex');
            uiwait;
            delete([h1 h2]);
        
        
    deriv = (deriv_pred1 + deriv_pred2)/2;
    
            %Animation
            line8 = text(1.5,0.45,'Average of predicted derivatives:');
            line9 = sprintf(...
                '$$\\dot y(%4.2f) = (%4.2f + %4.2f)/2 = %4.2f$$',...
                t,deriv_pred1,deriv_pred2,deriv);
            line9 = text(1.5,0.4,line9,'interpreter','latex');
            uiwait;
            delete([line4 line5 line6 line7 line8 line9]);
        
    state = state + deriv*stepsize;

            % Animation 
            line8 = text(1.5,0.45,'Average of predicted derivatives:');
            line9 = sprintf('$$\\dot y(%4.2f) = %4.2f$$',t,deriv);
            line9 = text(1.5,0.4,line9,'interpreter','latex');
            plot([t t+stepsize],[state-deriv*stepsize state],'r:');
            uiwait
            delete([line3 line8 line9]);

end    

%% Terminate
disp('Simulation complete!');

uiwait
close