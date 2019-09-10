clc;
clear;

% Add the folder containing require .m files to the path
addpath('mfiles');

% Set full path to .mat file to be loaded
fullPath_mat = 'res.mat'

% Load the .mat file. If not found see 'err' for error
[dymstr,err] = dymload(fullPath_mat);

% Get time variable. Only need to load once as it is the same for all variables
t = dymget(dymstr,'Time');

% Get time-data for specified variable
x = dymget(dymstr,'lorenzSystem.x');
y = dymget(dymstr,'lorenzSystem.y');
z = dymget(dymstr,'lorenzSystem.z');

% NOTE: 
% Some data is automatically repeated and must be cleaned up.
% 1. The final value is repeated
% 2. An 'event' during simulation causes that time instance to repeat

% Don't have to do it this way, just an example
x = removeRepeatRows([t,x],1,true);
y = removeRepeatRows([t,y],1,true);
z = removeRepeatRows([t,z],1,true);
t = removeRepeatRows(t,1,false);

%Some plots
fig1=figure;
plot(t,x,'k',t,y,'r--',t,z,'b')

fig2=figure;
plot3(x,y,z)