function scenario = generate_neighbor_random(scenario, avg_available_seats_for_fare, avg_sold_out_time)
    scenario = generate_neighbor_bookinglimit_random(scenario, avg_available_seats_for_fare, avg_sold_out_time);
    scenario = generate_neighbor_startavail_random(scenario, avg_available_seats_for_fare, avg_sold_out_time);
    scenario = generate_neighbor_stopavail_random(scenario, avg_available_seats_for_fare, avg_sold_out_time);