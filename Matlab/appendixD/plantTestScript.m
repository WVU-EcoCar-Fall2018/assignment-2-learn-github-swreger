% This example shows how to automate simulation runs from the
% MATLAB command line.  It reads in data from EXCEL and uses that 
% data as input data for throttle model.  The data is then displayed
% on a MATLAB figure.

% Open model
etc_plant_simple

% Read in data
%
% Data is in this form
% time case1 case2 case3
xlsdata = xlsread('plantTestInputs.xls');

% Assign time
test_time = xlsdata(:,1);

% Set up figure
figure;
num_of_tests = size(xlsdata,2)-1;
for i = 1:num_of_tests
	subplot(num_of_tests,1,i);
	hold on;
	title(['\bfTest Case ' num2str(i)]);
end

% Run test cases
for i = 1:num_of_tests
	% Map EXCEL data to model's expected inputs
	test_duty = abs(xlsdata(:,i+1));
	test_direction = sign(xlsdata(:,i+1));
    
    %Create model parameter overrides arguments
    paramOverrides.StopTime = num2str(xlsdata(end,1));
    paramOverrides.ExternalInput = '[test_time test_duty test_direction]';
    paramOverrides.LoadExternalInput = 'on';
    
	% Simulate model with test inputs
	simOut = sim('etc_plant_simple', paramOverrides);
    
	% Plot inputs and outputs
    y = get(simOut,'yout');
    theta = getElement(y,'theta');
    subplot(num_of_tests,1,i)
	plotyy(theta.Values.Time,theta.Values.Data, ...
           test_time,test_duty.*test_direction);
end

% Clean up
close_system('etc_plant_simple');