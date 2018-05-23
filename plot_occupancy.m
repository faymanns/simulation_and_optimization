function plot_occupancy(scenario,save_path)
figure;
[total_revenue, avg_available_seats_for_fare, avg_sold_out_time, avg_number_of_no_purchase] = objective_function(scenario);
available_fares = (scenario.booking_limits~=0);
c = ['A';'B';'C';'D';'E';'F';'G';'H';'I'];
bar(scenario.booking_limits(available_fares),0.5,'FaceColor',[0.2 0.2 0.5]);
hold on;
bar(scenario.booking_limits(available_fares)-avg_available_seats_for_fare(available_fares),0.4,'FaceColor',[0 0.7 0.7]);
hold off;
set(gca,'xticklabel',c(available_fares))
legend(['Availabel seats      ';...
        'Seats sold on average'],'location','northeast')
saveas(gcf,save_path);
end