%% Test the implementation of simulation.m function

%% clean the workspace
clear all; %Removes all variables, functions, and MEX-files from memory, leaving the workspace empty
close all; % delete all figures whose handles are not hidden.
clc; % clear command window

%% Program
% Set the scenario
scenario = NewFlight();

% Run the simulation
[times, queues] = simulation(scenario);

% Graphical animation of the results
%DrawNetwork(scenario, times, queues);

% Chart of the results
%figure;DrawQueues(times, queues);