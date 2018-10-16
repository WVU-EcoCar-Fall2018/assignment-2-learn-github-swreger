% etc_all_data.m
%
% Loads parameters for the etc_ref.mdl model, and similar

% Data for the controller (Ki, Kp, Ts)
etc_controller_data;

% Data for the plant (J, Cs, Kd, Ks, etc.)
etc_plant_data;

% Data for the sensor (degConv)
degConv = 180/pi;