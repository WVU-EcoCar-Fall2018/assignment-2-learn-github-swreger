function F = air_resistance(v, a, b, c)

% Taylor series for air resistance
% as a function of velocity. Enter 
% coefficients through the dialog 
% on the air resistance block.

F =  a + b*v + c*v*abs(v);