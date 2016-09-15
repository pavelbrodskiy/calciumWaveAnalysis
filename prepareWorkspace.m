% Run this at the beginning of each calcium wave analysis script.
% This identifies the dependancy folders, and sets folders for
% inputs and output, and creates them if they do not exist.
%
% prepareWorkspace()

function settings = prepareWorkspace(varargin)
% Clear off the workspace
tic
close all
fclose('all');

settings = getSettings();
cd(settings.activeDir);

% Delete temporary directory if it exists
if exist(settings.tmp, 'dir')
    rmdir(settings.tmp, 's');
end

% Compile mexs (RUN ONCE ONLY)
if false
    mex([settings.depExt 'imgaussian.c'], '-v')
    cd([settings.depExt 'MinMaxFilterFolder' filesep])
    minmaxfilter_install
    cd(settings.activeDir);
end

disp('Workspace prepared');
end