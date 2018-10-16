function sl_customization(cm)

% Register Extra Menu items for the Simulink Display Menu
cm.addCustomMenuFcn('Simulink:DisplayMenu', @CreateMenuItems);

% Create Extra Menu items
function menuhandles = CreateMenuItems(callbackInfo)
% In this case, only one menu item is being added.
menuhandles = {@HighlightSampleTimes};

% Create menu item object
function menu = HighlightSampleTimes(callbackInfo)
% Make menu item an object that has something happen when 
% you click on it.
menu = sl_action_schema;

% Name shown in menu for user to see
menu.label = 'Blocks with Ts Specified';

% Handle to what should be executed when you click on this item
menu.callback = @HighlightTsCallback;

% Callback function for when menu item is selected
function HighlightTsCallback(callbackInfo)
% Call script to highlight blocks with specified sample times.
sampleTimeCheck;

