function total_revenue = revenue_objective_function(scenario)

    nruns = 100;
    total_revenues = zeros(nruns,1);

    parfor i = 1:nruns
        [times, revenues, available_seats_for_fare, segments, sold_out_time] = simulation(scenario);
        total_revenues(i) = sum(revenues);
    end
    total_revenue = sum(total_revenues)/nruns;
end