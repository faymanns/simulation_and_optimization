function plot_occupancy(scenario,save_path)
figure;
[total_revenue, avg_available_seats_for_fare, avg_sold_out_time, avg_number_of_no_purchase] = objective_function(scenario);
available_fares = (scenario.booking_limits~=0);
x = ['A','B','C','D','E','F','G','H','I'];
c = categorical(cellstr(x(available_fares).'));
y = [scenario.booking_limits(available_fares);...
    scenario.booking_limits(available_fares)-avg_available_seats_for_fare(available_fares)].';
bar(c, y, 'stacked');
legend(['Availabel seats      ';...
        'Seats sold on average'],'location','northeast')
saveas(gcf,save_path);
end