function optimization_test()

warn = warning ('off','all');
poolobj = gcp('nocreate');
if isempty(poolobj)
    parpool;
end
pctRunOnAll warning('off','all')

clear all;
close all;
clc;

number_of_fares = 9;

problem.INITIAL_SCENARIO = NewFlight();

problem.OBJECTIVE_FUNCTION = @revenue_objective_function;


problem.M = 10;
problem.K = 50;
problem.D = 0.5;
problem.P0 = 0.99;
problem.Pf = 0.01;

[solutions, values, temperatures] = SimulatedAnnealing(problem);

[solutions, values] = local_search(problem);


end