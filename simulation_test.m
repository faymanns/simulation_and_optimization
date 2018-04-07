%% Test the implementation of simulation.m function

%% clean the workspace
clear all; % removes all variables, functions, and MEX-files from memory, leaving the workspace empty
close all; % delete all figures whose handles are not hidden.
clc;       % clear command window

%% Program

% Set verbosity
verbosity = false;

% Set the scenario
scenario = NewFlight();

% Run the simulation
number_of_no_purchase = [];
number_of_business_customers = [];
number_of_leisure_customers = [];
number_of_economy_customers = [];
number_of_no_purchase_business = [];
number_of_no_purchase_leisure = [];
number_of_no_purchase_economy = [];
number_of_seats_sold = [];
sold_out_times = zeros(scenario.NUMBER_OF_PRODUCTS,1);

total_number_of_customers = [];
total_number_of_economy_customers = [];
total_number_of_economy_customers2 = [];
total_revenue = [];


max_number_of_no_purchase_avg = 0;      % mean value of the max number of no purchases
max_number_of_no_purchase_var = 0;      % variance of the max number of no purchases
no_purchase_avg = 0;
no_purchase_var = 0;
list_no_purchase_avg = [];
list_no_purchase_var = [];

run = 0;
while(true)
    run = run + 1;
    
    if verbosity
        fprintf('Run %d\n', run);
    end
    
    [times, revenues, available_seats_for_fare, segments, sold_out_time] = simulation(scenario);
        
    total_number_of_economy_customers = [total_number_of_economy_customers, sum(segments==3)];
    
    if sum(available_seats_for_fare(1:(end-1)))==0
        index = find(revenues,1,'last');   % last customer that could by a ticket, afterwards no seats were left
        number_of_coundnt_purchase = [number_of_no_purchase, sum(revenues(index:end)==0)];
        
        revenues = revenues(1:index);
        segments = segments(1:index);
    else
        number_of_coundnt_purchase = [number_of_no_purchase, 0];
    end
    
    number_of_no_purchase = [number_of_no_purchase, sum(revenues==0)];
    
    max_number_of_no_purchase = max(number_of_no_purchase); % [persons] maximum length of the number_of_no_purchase in this simulation run
    [max_number_of_no_purchase_avg, max_number_of_no_purchase_var] = UpdatedStatistics(max_number_of_no_purchase_avg, max_number_of_no_purchase_var, max_number_of_no_purchase, run);
    [no_purchase_avg, no_purchase_var] = UpdatedStatistics(no_purchase_avg, no_purchase_var, number_of_no_purchase(end), run);
    list_no_purchase_avg = [list_no_purchase_avg, no_purchase_avg];
    list_no_purchase_var = [list_no_purchase_var, no_purchase_var];
    
    number_of_business_customers = [number_of_business_customers, sum(segments==1)];
    number_of_leisure_customers = [number_of_leisure_customers, sum(segments==2)];
    number_of_economy_customers = [number_of_economy_customers, sum(segments==3)];
    number_of_no_purchase_business = [number_of_no_purchase_business, sum(revenues(segments==1)==0)];
    number_of_no_purchase_leisure = [number_of_no_purchase_leisure, sum(revenues(segments==2)==0)];
    number_of_no_purchase_economy = [number_of_no_purchase_economy, sum(revenues(segments==3)==0)];
    number_of_seats_sold = [number_of_seats_sold, 180-sum(available_seats_for_fare(1:(end-1)))];
    sold_out_times = [sold_out_time', sold_out_times];
    total_number_of_customers = [total_number_of_customers, length(revenues)];
    total_revenue = [total_revenue, sum(revenues)];
    
    
    
    if verbosity
        var(number_of_no_purchase)/run
        no_purchase_avg        
    end
    
    if var(number_of_no_purchase)/run < 0.5 && var(number_of_no_purchase)/run > 0
        break;
    end    
        
end

fprintf('Number of simulation runs: %d\n', run)

%% Plotting results 
fprintf('No purchase');
figure; histogram(number_of_no_purchase); grid on;
title('Distribution of "No purchases"')
xlabel('Number of "No purchases"'); ylabel('Frequency'); 
mean(number_of_no_purchase)
var(number_of_no_purchase)/length(number_of_no_purchase)
BootstrapMSE(number_of_no_purchase, @mean, 100)
saveas(gcf,sprintf('no_purchase_scenario%i.png',scenario.CaseIndex));

fprintf('Total number of Economy customers');
figure; histogram(total_number_of_economy_customers); grid on;
title('Distribution of the total number of Economy customers')
xlabel('Total number of Economy customers [persons]'); ylabel('Frequency'); 
saveas(gcf,sprintf('number_of_economy_customers_scenario%i.png',scenario.CaseIndex));

fprintf('Control variates no purchase');
cov = 1/(length(number_of_no_purchase)-1)...
    *sum((number_of_no_purchase - mean(number_of_no_purchase))...
.*(total_number_of_economy_customers - mean(total_number_of_economy_customers)));
variance = 1/(length(number_of_no_purchase)-1)...
            *sum((total_number_of_economy_customers-mean(total_number_of_economy_customers)).^2);
Z = number_of_no_purchase - cov/variance*(total_number_of_economy_customers- 144*(1-2/pi));


figure; histogram(Z);
title('Variance Reduction: Control Variates'); grid on;
xlabel('Number of "No purchases"'); ylabel('Frequency'); 
saveas(gcf,sprintf('variance_reduction_scenario%i.png',scenario.CaseIndex));

mean(Z)
var(Z)/length(Z)
BootstrapMSE(Z, @mean, 100)

fprintf('Total revenue:')
figure; histogram(total_revenue/10^6); grid on;
title('Total revenue distribution'); 
xlabel('Total revenue [millions of CHF]'); ylabel('Frequency');
mean(total_revenue)
var(total_revenue)/length(total_revenue)
BootstrapMSE(total_revenue, @mean, 100)
saveas(gcf,sprintf('total_revenue_scenario%i.png',scenario.CaseIndex));

% plot for stopping cirteria
figure;
plot(list_no_purchase_avg);
hold on;
plot(list_no_purchase_var(2:end)./[2:run]);
hold off;
grid on;
xlabel('simulation run');
ylabel('number of no purchase');
h = legend('mean no purchase', 'std of mean no purchase');
set(h, 'Box', 'off');
set(h, 'Location', 'best');
saveas(gcf,sprintf('stopping_criteria_scenario%i.png',scenario.CaseIndex));

%Joined Graph for variance reduction (Z and Y=No of no purchases) 
figure; 
joinedh = histogram(number_of_no_purchase);
hold on;
histogram(Z, 'BinEdges', joinedh.BinEdges);
hold off;
grid on;
xlabel('');
ylabel('Frequency');
h = legend('Y = # of no purchase', 'Variable Z');
set(h, 'Box', 'off');
set(h, 'Location', 'best');
saveas(gcf,sprintf('variance_reduction_combined_scenario%i.png',scenario.CaseIndex));

% fprintf('sold out times');
% for j = 1:9
% idx = find(sold_out_times(j,1:end-1)~=-1);
% figure; histogram(sold_out_times(j,idx));
% mean(sold_out_times(j,idx))
% var(sold_out_times(j,idx))/length(sold_out_times(j,idx))
% BootstrapMSE(sold_out_times(j,idx), @mean, 100)
% end