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


problem.INITIAL_SCENARIO = NewFlight();

problem.OBJECTIVE_FUNCTION = @revenue_objective_function;

%% Local search
[solutions, values] = local_search(problem);
for i = 1:length(solutions)
    fprintf(['Solution ',num2str(i)]);
    solutions(end).booking_limits
    solutions(end).availability_start
    solutions(end).availability_stop
end
plot_solution(solutions(end),'local_search_optimal_solution.pdf');

figure();
plot(values);
xlabel('Iteration');
ylabel('Objective function');
saveas(gcf,'local_search_values.pdf')


% %% Simulated Annealing
% problem.M = 10;
% problem.K = 50;
% problem.D = 0.5;
% problem.P0 = 0.99;
% problem.Pf = 0.01;
% 
% 
% [solutions, values, temperatures] = SimulatedAnnealing(problem);
% 
% figure();
% plot(values);
% xlabel('Iteration');
% ylabel('Objective function');


end