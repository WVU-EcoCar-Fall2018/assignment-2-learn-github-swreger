function addSLBE_AtoPath

% Get the current course folder
rootDir = fileparts(mfilename('fullpath'));

% Populate list of folders to add to path
path2add = {};
path2add{end+1} = rootDir;
path2add{end+1} = fullfile(rootDir,'chapter2');
path2add{end+1} = fullfile(rootDir,'chapter3');
path2add{end+1} = fullfile(rootDir,'chapter4');
path2add{end+1} = fullfile(rootDir,'chapter5');
path2add{end+1} = fullfile(rootDir,'chapter6');
path2add{end+1} = fullfile(rootDir,'chapter7');
path2add{end+1} = fullfile(rootDir,'chapter8');
path2add{end+1} = fullfile(rootDir,'chapter9');
path2add{end+1} = fullfile(rootDir,'chapter10');
path2add{end+1} = fullfile(rootDir,'appendixA');
path2add{end+1} = fullfile(rootDir,'appendixC');
path2add{end+1} = fullfile(rootDir,'appendixD');
path2add{end+1} = fullfile(rootDir,'exercises');

% Add folders to the path
addpath(path2add{:},'-end');