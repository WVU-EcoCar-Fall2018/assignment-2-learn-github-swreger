% FIND_SYSTEM is the key function. It allows you to search blocks,
% signals, etc. in the model. In this case, the search is for all
% blocks in the model that are not subsystems and do not have their
% sample time set to -1 for inherited or inf for constant blocks.

% Find blocks with specified sample times
specified_blocks = find_system(bdroot, ...
    'RegExp','on', ... % Allow for Not include ([^]) later
	'FollowLinks','on', ... % Follow links to libraries
	'LookUnderMasks','on', ... % Look under all masks
	'SampleTime','[^-1|inf]'); % Include all blocks with SampleTime values

% Highlight the blocks with specified sample times
hilite_system(specified_blocks,'find')
