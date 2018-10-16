for Fdrive = 1000:100:2000
    % Simulate the model and get simulation data
    simout = sim('bmw_vehicle_dynamics','StopTime','5');
    t = get(simout,'tout');
    y = get(simout,'yout');
    
    % Get velocity from simulation data (in feet per second)
    y_fps = y(:,2);
    
    % Convert velocity to miles per hour
    y_mph = y_fps*60*60/5280;
    
    % Stop iterating if the maximum speed is >= 60 mph
    if max(y_mph)>=60
        break
    end
end

% Plot the results
plot(t,y_mph)
disp(['minimum Fdrive is ',num2str(Fdrive), 'lbf'])