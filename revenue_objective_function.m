function total_revenue = revenue_objective_function(scenario)
    [times, revenues, available_seats_for_fare, segments, sold_out_time] = simulation(scenario);
    total_revenue = sum(revenues);
end