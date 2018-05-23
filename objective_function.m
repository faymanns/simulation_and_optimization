function [total_revenue, avg_available_seats_for_fare, avg_sold_out_time, avg_number_of_no_purchase] = objective_function(scenario)

    nruns = 100;
    penalty = 150; %cost to the company for every lost customer 
    total_revenues = zeros(nruns,1);
    all_available_seats_for_fare = zeros(nruns,scenario.NUMBER_OF_PRODUCTS);
    all_sold_out_time = zeros(nruns,scenario.NUMBER_OF_PRODUCTS);
    number_of_no_purchase = zeros(1,nruns);
    
    parfor i = 1:nruns
        [~, revenues, available_seats_for_fare, ~, sold_out_time] = simulation(scenario);
        total_revenues(i) = sum(revenues);
        all_available_seats_for_fare(i,:) = available_seats_for_fare;
        all_sold_out_time(i,:) = sold_out_time;
        number_of_no_purchase(i) = sum(revenues==0);
    end
    
    net_total_revenue = sum(total_revenues)/nruns;
    avg_available_seats_for_fare = sum(all_available_seats_for_fare,1)/nruns;
    avg_sold_out_time = sum(all_sold_out_time,1)/nruns;
    avg_number_of_no_purchase = sum(number_of_no_purchase)/nruns;
    %total_revenue = net_total_revenue - penalty*avg_number_of_no_purchase;
    total_revenue = net_total_revenue;
end
