function [solutions, values] = local_search(problem)

    scenario = problem.INITIAL_SCENARIO;
    solutions = [scenario];
    [Q, avg_available_seats_for_fare, avg_sold_out_time] = problem.OBJECTIVE_FUNCTION(scenario);
    values = [Q];
    
    max_number_of_iterations = 10000;
    number_of_iteration = 0;
    termination_theshold = 10; %If no better solution is found for termination_theshold consecutive iteration the loop stops
    number_of_no_change_iteration = 0;
    
    while number_of_no_change_iteration < termination_theshold && number_of_iteration < max_number_of_iterations
        fprintf(['Iteration ',num2str(number_of_iteration),'\n']);
        [Q, avg_available_seats_for_fare, avg_sold_out_time] = problem.OBJECTIVE_FUNCTION(scenario);
        if Q > values(end)
            values = [values, Q];
            solutions = [solutions, scenario];
            number_of_no_change_iteration = 0;
        else
            number_of_no_change_iteration = number_of_no_change_iteration + 1;
        end
        number_of_iteration = number_of_iteration + 1
        scenario = generate_neighbor_random(solutions(end), avg_available_seats_for_fare, avg_sold_out_time);
        %scenario = generate_solution_BL(solutions(end), avg_available_seats_for_fare, avg_sold_out_time);
    end
    fprintf('Finished local search!\n')
end
