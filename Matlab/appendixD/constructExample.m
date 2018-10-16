% This example creates a model with 3 blocks connected in this
% order sine wave, gain, and then scope.  The gain will have a 
% value of 5.

% Create and load a new model
new_system('mysys')
% Open model for viewing
open_system('mysys')
% Define starting position of blocks
pos = [100 100 130 130];
% Define horizontal offset
h_offset = [100 0 100 0];

% Add Blocks
% Add blocks to model in a specific location. If position is not
% defined then the blocks are all added at the same default 
% location.  Create blocks with any additional parameter values 
% desired (in this case a gain value of 5 for Gain block).
add_block('built-in/Sin','mysys/Source', ...
	'Position',pos);
add_block('built-in/Gain','mysys/Gain1', ...
	'Position',pos+h_offset, ...
	'Gain','5');
add_block('built-in/Scope','mysys/Scope1', ...
	'Position',pos+2*h_offset);

% Create Signals
% The connection is in the form: sourceblockname/port# 
% to destinationblockname/port#
add_line('mysys','Source/1','Gain1/1');
add_line('mysys','Gain1/1','Scope1/1');
