function [solutions, values] = local_search(problem)

    scenario = problem.INITIAL_SCENARIO;
    solutions = [scenario];
    values = [problem.OBJECTIVE_FUNCTION(scenario)];
    
    termination_theshold = 10; %If no better solution is found for termination_theshold consecutive iteration the loop stops
    number_of_no_change_iteration = 0;
    
    while number_of_no_change_iteration < termination_theshold
        [Q, avg_available_seats_for_fare, avg_sold_out_time] = problem.OBJECTIVE_FUNCTION(scenario);
        if Q > values(end)
            values = [values, Q];
            solutions = [solutions, scenario];
            number_of_no_change_iteration = 0;
        else
            number_of_no_change_iteration = number_of_no_change_iteration + 1;
        end
        scenario = generate_neighbor_random(solutions(end), avg_available_seats_for_fare, avg_sold_out_time);
    end
end