function plot_solution(solution,save_path)
figure;
n = solution.NUMBER_OF_PRODUCTS - 1;

x = [solution.availability_start; solution.availability_stop];
height = solution.booking_limits;
c = categorical(cellstr(['A','B','C','D','E','F','G','H','I'].'));
for i = 1:n
    subplot(n,1,i);
    area(x(:,i),height(i)*ones(2,1));
    xlim([0 solution.PLANNING_HORIZON]);
    ylim([0 max(height)+1]);
    t = text(sum(x(:,i))/2,max(height)/2,num2str(height(i)));
    t.Color = 'r';
    t.FontSize = 12;
    set(gca, 'XDir','reverse');
    yyaxis right
    ylabel(char(c(i)),'Rotation',0,'Fontsize',14);
    set(gca,'YTickLabel',[]);
    set(gca,'YTick',[]);
end
saveas(gcf,save_path);