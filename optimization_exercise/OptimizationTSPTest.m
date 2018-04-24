%% Test Travelling Salesman Problem

%% clean the workspace
clear all; % remove all variables, functions, and MEX-files from memory, leaving the workspace empty
close all; % delete all figures whose handles are not hidden.
clc; % clear command window 

%% Program
% The dimension of the problem. Here: 20 cities.
% Try other dimensions, if you want.
DIM = 20;

% Create a random disposition of the cities.
problem.CITIES = zeros(DIM, 2);
for i = 1 : DIM
	x   = rand();
	y   = rand();
	problem.CITIES(i, :) = [x, y];
end

% Create a initial city sequence.
problem.INITIAL_SOLUTION = 1 : DIM;

% Plot the initial solution.
figure();DrawSalesman(problem.INITIAL_SOLUTION, problem);
title ('Initial solution');
drawnow();


%% Run the optimization.
% Implement the different optimization algorithms.
% For each algorithm, implement the appropriate problem.RANDOMIZE, and optimization algorithm.
% Remember to comment out previous algorithm before running.

%% Full enumeration
problem.RANDOMIZE = @GenerateNewCitySequence; %IMPLEMENT THE APPROPRIATE PERMUTATION FUNCTION
problem.OBJECTIVE_FUNCTION = @EvaluateCitySequence;


[solutions, values, ~] = FullEnumeration(problem); %IMPLEMENT THE ALGORITHM LOGIC


% Plot the result. (Note that better solutions 
% may have been found during the iterations)

figure();DrawSalesman(solutions(size(solutions,1), :), problem);
title('Final Solution');
drawnow();

dummy = []; % dummy variable
figure();ObjectiveFunctionPlot(values,dummy);


%% Greedy algorithm
problem.RANDOMIZE = @GenerateNewCitySequence; %IMPLEMENT THE APPROPRIATE PERMUTATION FUNCTION
problem.OBJECTIVE_FUNCTION = @EvaluateCitySequence;


[solutions, values, ~] = GreedyAlgorithm(problem); %IMPLEMENT THE ALGORITHM LOGIC

% Plot the result.

figure();DrawSalesman(solutions(size(solutions,1), :), problem);
title('Final Solution');
drawnow();

dummy = []; % dummy variable
figure();ObjectiveFunctionPlot(values,dummy);


%% Local search
problem.RANDOMIZE = @GenerateNewCitySequence; %IMPLEMENT THE APPROPRIATE PERMUTATION FUNCTION
problem.OBJECTIVE_FUNCTION = @EvaluateCitySequence;


[solutions, values, ~] = LocalSearch(problem);  %IMPLEMENT THE ALGORITHM LOGIC

% Plot the final result.

figure();DrawSalesman(solutions(size(solutions,1), :), problem);
title('Final Solution');
drawnow();

dummy = []; % dummy variable
figure();ObjectiveFunctionPlot(values,dummy);


%% Variable neighborhood search
problem.RANDOMIZE = @GenerateNewCitySequence; %IMPLEMENT THE APPROPRIATE PERMUTATION FUNCTION
%
% Define your own parameters here.
%
%   problem.RANDOMIZE_2   = @GenerateNewCitySequence_2;   %IMPLEMENT THE APPROPRIATE PERMUTATION FUNCTION
%   problem.RANDOMIZE_... = @GenerateNewCitySequence_...; %IMPLEMENT THE APPROPRIATE PERMUTATION FUNCTION
%   problem.RANDOMIZE_k   = @GenerateNewCitySequence_k;   %IMPLEMENT THE APPROPRIATE PERMUTATION FUNCTION
%
problem.OBJECTIVE_FUNCTION = @EvaluateCitySequence;


[solutions, values, ~] = VariableNeighborhoodSearch(problem); %IMPLEMENT THE ALGORITHM LOGIC

% Plot the final result.

figure();DrawSalesman(solutions(size(solutions,1), :), problem);
title('Final Solution');
drawnow();

dummy = []; % dummy variable
figure();ObjectiveFunctionPlot(values,dummy);


%% Simulated annealing
problem.RANDOMIZE = @GenerateNewCitySequence; %IMPLEMENT THE APPROPRIATE PERMUTATION FUNCTION
problem.OBJECTIVE_FUNCTION = @EvaluateCitySequence;
%
% Define your own parameters here.
%
%   problem.M   Number of temperature changes
%   problem.K 	Number of iterations per level of temperature
%   problem.D   Average increase of the objective function
%   problem.P0	Initial acceptance probability
%   problem.Pf  Final acceptance probability
%
% Vary any of these parameters to change the behavior of the optimization

  problem.M = 10;
  problem.K = 50;
  problem.D = 0.5;
  problem.P0 = 0.99;
  problem.Pf = 0.01;

[solutions, values, temperatures] = SimulatedAnnealing(problem);

% Plot the final result. (Note that better solutions 
% may have been found during the iterations)

figure();DrawSalesman(solutions(size(solutions,1), :), problem);
title('Final Solution');
drawnow();

figure();ObjectiveFunctionPlot(values,temperatures);
