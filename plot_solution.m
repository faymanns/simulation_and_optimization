function plot_solution(solution,save_path)

n = solution.NUMBER_OF_PRODUCTS - 1;

x = [solution.availability_start; solution.availability_stop];
height = solution.booking_limits;

for i = 1:n
    subplot(n,1,i);
    area(x(:,i),height(i)*ones(2,1));
    xlim([0 solution.PLANNING_HORIZON]);
    ylim([0 max(height)+1]);
    set(gca, 'XDir','reverse');
end
saveas(gcf,save_path);