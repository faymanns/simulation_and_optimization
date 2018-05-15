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


no_purchase_prc_threshold = 0.1;     % constraint for the percentage of the number of no purchases


problem.INITIAL_SCENARIO = NewFlight();
problem.OBJECTIVE_FUNCTION = @objective_function;


% %% Local search
% [solutions, values] = local_search(problem);
% for i = 1:length(solutions)
%     fprintf(['Solution ',num2str(i)]);
%     solutions(end).booking_limits
%     solutions(end).availability_start
%     solutions(end).availability_stop
% end
% 
% save('local_search','solutions','values');
% 
% plot_solution(solutions(end),'local_search_optimal_solution.pdf');
% plot_occupancy(solutions(end),'local_search_occupancy.pdf');
% 
% figure();
% plot(values);
% xlabel('Iteration');
% ylabel('Objective function');
% saveas(gcf,'local_search_values.pdf')


%% Simulated Annealing
problem.M = 10;
problem.K = 50;
problem.D = 0.5;
problem.P0 = 0.99;
problem.Pf = 0.01;


[solutions, values, temperatures] = SimulatedAnnealing(problem);

save('simulated_annealing','solutions','values','temperatures');

plot_solution(solutions(end),'simulated_annealing_optimal_solution.pdf');
plot_occupancy(solutions(end),'simulated_annealing_occupancy.pdf');
figure();
plot(values);
xlabel('Iteration');
ylabel('Objective function');


end