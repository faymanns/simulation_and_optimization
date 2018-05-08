function [solutions, values] = local_search(problem)

    scenario = problem.INITIAL_SCENARIO;
    solutions = [scenario];
    values = [problem.OBJECTIVE_FUNCTION(scenario)];
    
    for i =1:10
        [Q, avg_available_seats_for_fare, avg_sold_out_time] = problem.OBJECTIVE_FUNCTION(scenario);
        if Q > values(end)
            values = [values, Q];
            solutions = [solutions, scenario];
        end
        scenario = generate_neighbor(solutions(end), avg_available_seats_for_fare, avg_sold_out_time);
    end
end