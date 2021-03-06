%% Test the implementation of simulation.m function

%% clean the workspace
clear all; % removes all variables, functions, and MEX-files from memory, leaving the workspace empty
close all; % delete all figures whose handles are not hidden.
clc;       % clear command window

%% Program

%For running the two different cases (1st and 2nd scenario) change
%respectively the scenario.CaseIndex (1 or 2) in the function NewFlight.m 
%and run the simulation_test.m 
%1 : All products available from the beginning of the test, limit=20/fare
%2 : Only one fare available each time until it reaches its limit, starting 
%from H, G, ..., A , limit = 20 / fare 


% Set verbosity
verbosity = false;

% Set the scenario
scenario = NewFlight();

% Run the simulation
number_of_couldnt_purchase=[];				%Total No of customers who CANNOT purchase (flight sold out) in each simulation test 
number_of_no_purchase = [];					%Total No of customers who DO NOT purchase (dicide to do so) in each simulation test 
number_of_business_customers = [];			%Total No of business customers who "arrive" in each simulation test  
number_of_leisure_customers = [];			%Total No of leisure customers who "arrive" in each simulation test
number_of_economy_customers = [];			%Total No of economy customers who "arrive" in each simulation test
number_of_no_purchase_business = [];		%Total No of business customers who DO NOT purchase (decide to do so) in each simulation test 
number_of_no_purchase_leisure = [];			%Total No of leisure customers who DO NOT purchase (decide to do so) in each simulation test
number_of_no_purchase_economy = [];			%Total No of economy customers who DO NOT purchase (decide to do so) in each simulation test
number_of_seats_sold = [];					%Total No of seats sold in each simulation test 


sold_out_times = zeros(scenario.NUMBER_OF_PRODUCTS,1);  %Sold-out times for each product 

total_number_of_customers = [];
total_number_of_economy_customers = [];
total_number_of_economy_customers2 = [];
total_revenue = [];


%max_number_of_no_purchase_avg = 0;      % mean value of the max number of no purchases
%max_number_of_no_purchase_var = 0;      % variance of the max number of no purchases
no_purchase_avg = 0;
no_purchase_var = 0;
couldnt_purchase_avg=0;
couldnt_purchase_var=0;
list_no_purchase_avg = [];
list_no_purchase_var = [];
list_couldnt_purchase_avg = [];
list_couldnt_purchase_var = [];

run = 0;
while(true)
    run = run + 1;
    
    if verbosity
        fprintf('Run %d\n', run);
    end
    
    [times, revenues, available_seats_for_fare, segments, sold_out_time] = simulation(scenario);
        
    total_number_of_economy_customers = [total_number_of_economy_customers, sum(segments==3)];
    
	%Check if flight is sold out or not - Count "Couldn't purchase" and "Didn't purchase" 
    if sum(available_seats_for_fare(1:(end-1)))==0 %Case : Sold out 
        index = find(revenues,1,'last');   % last customer that could by a ticket, afterwards no seats were left
        number_of_couldnt_purchase = [number_of_couldnt_purchase, sum(revenues(index:end)==0)];
        
        revenues = revenues(1:index);
        segments = segments(1:index);
    else %Case Not sold out 
        number_of_couldnt_purchase = [number_of_couldnt_purchase, 0];
    end
    
	%No of passengers who "Didn't purchase" 
    number_of_no_purchase = [number_of_no_purchase, sum(revenues==0)];
	
    % Worst case - all simlulations 
    max_number_of_no_purchase = max(number_of_no_purchase); % [persons] maximum length of the number_of_no_purchase 
	
	
    %[max_number_of_no_purchase_avg, max_number_of_no_purchase_var] = UpdatedStatistics(max_number_of_no_purchase_avg, max_number_of_no_purchase_var, max_number_of_no_purchase, run);
   
	%Statistics - Passengers who don't purchase
    [no_purchase_avg, no_purchase_var] = UpdatedStatistics(no_purchase_avg, no_purchase_var, number_of_no_purchase(end), run);
    list_no_purchase_avg = [list_no_purchase_avg, no_purchase_avg];
    list_no_purchase_var = [list_no_purchase_var, no_purchase_var];
    
	%Statistics - Passengers who CANNOT purchase (Flight sold out) 
	[couldnt_purchase_avg, couldnt_purchase_var] = UpdatedStatistics(couldnt_purchase_avg, couldnt_purchase_var, number_of_couldnt_purchase(end), run);
	list_couldnt_purchase_avg = [list_couldnt_purchase_avg, couldnt_purchase_avg];
    list_couldnt_purchase_var = [list_couldnt_purchase_var, couldnt_purchase_var];
	
	
	
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
    
    if var(number_of_no_purchase)/run < 0.5 && var(number_of_no_purchase)/run > 0 && run>10
        break;
    end    
        
end

fprintf('Number of simulation runs: %d\n', run)

%% Plotting results 

%Passengers who DON'T purchase 

fprintf('No purchase');
figure; histogram(number_of_no_purchase); grid on;
title('Distribution of "No purchases"')
xlabel('Number of "No purchases"'); ylabel('Frequency'); 
mean_no_purchase = mean(number_of_no_purchase)
MSE_no_purchase = var(number_of_no_purchase)/length(number_of_no_purchase) %theoretical MSE of mean No-purchase
bootMSE_no_purchase = BootstrapMSE(number_of_no_purchase, @mean, 100)	   %Bootstrapp MSE of mean No-purchase
hold on;
ylim=get(gca,'ylim');
l1 = line([mean_no_purchase mean_no_purchase], ylim,'Color','r','LineWidth',2.0);
l2 = line([mean_no_purchase+MSE_no_purchase mean_no_purchase+MSE_no_purchase], ylim,'Color','r','LineWidth',2.0,'LineStyle',':');
l3 = line([mean_no_purchase-bootMSE_no_purchase mean_no_purchase-bootMSE_no_purchase], ylim,'Color','r','LineWidth',2.0,'LineStyle','--');
l4 = line([prctile(number_of_no_purchase,5) prctile(number_of_no_purchase,5)], ylim,'Color','g','LineWidth',2.0,'LineStyle','--');
line([prctile(number_of_no_purchase,95) prctile(number_of_no_purchase,95)], ylim,'Color','g','LineWidth',2.0,'LineStyle','--');
hold off;
legend([l1,l2,l3,l4],'mean', 'MSE', 'bootstrap MSE','5 and 95 percentile')
saveas(gcf,sprintf('no_purchase_scenario%i.png',scenario.CaseIndex));

%Passengers who CANNOT purchase (Flight sold-out) 

fprintf('Could not purchase');
figure; histogram(number_of_couldnt_purchase); grid on;
title('Distribution of "Could not purchase"')
xlabel('Number of "Could not purchase" customers'); ylabel('Frequency'); 
mean_couldnt_purchase = mean(number_of_couldnt_purchase)
MSE_couldnt_purchase = var(number_of_couldnt_purchase)/length(number_of_couldnt_purchase) %theoretical MSE of mean Couldnt-purchase
bootMSE_couldnt_purchase = BootstrapMSE(number_of_couldnt_purchase, @mean, 100)	   %Bootstrapp MSE of mean Couldnt-purchase
hold on;
ylim=get(gca,'ylim');
l1 = line([mean_couldnt_purchase mean_couldnt_purchase], ylim,'Color','r','LineWidth',2.0);
l2 = line([mean_couldnt_purchase+MSE_couldnt_purchase mean_couldnt_purchase+MSE_couldnt_purchase], ylim,'Color','r','LineWidth',2.0,'LineStyle',':');
l3 = line([mean_couldnt_purchase-bootMSE_couldnt_purchase mean_couldnt_purchase-bootMSE_couldnt_purchase], ylim,'Color','r','LineWidth',2.0,'LineStyle','--');
l4 = line([prctile(number_of_couldnt_purchase,5) prctile(number_of_couldnt_purchase,5)], ylim,'Color','g','LineWidth',2.0,'LineStyle','--');
line([prctile(number_of_couldnt_purchase,95) prctile(number_of_couldnt_purchase,95)], ylim,'Color','g','LineWidth',2.0,'LineStyle','--');
hold off;
legend([l1,l2,l3,l4],'mean', 'MSE', 'bootstrap MSE','5 and 95 percentile')
saveas(gcf,sprintf('couldnt_purchase_scenario%i.png',scenario.CaseIndex));

%Total number of economy customer "arrivals" (Used as Y in variance reduction) 
fprintf('Total number of Economy customers');
figure; histogram(total_number_of_economy_customers); grid on;
title('Distribution of the total number of Economy customers')
xlabel('Total number of Economy customers [persons]'); ylabel('Frequency'); 
saveas(gcf,sprintf('number_of_economy_customers_scenario%i.png',scenario.CaseIndex));

%Variance Reduction for average no of no-purchase customers - Control Variates method 
fprintf('Control variates no purchase');
cov = 1/(length(number_of_no_purchase)-1)...
    *sum((number_of_no_purchase - mean(number_of_no_purchase))...
.*(total_number_of_economy_customers - mean(total_number_of_economy_customers)));
variance = 1/(length(number_of_no_purchase)-1)...
            *sum((total_number_of_economy_customers-mean(total_number_of_economy_customers)).^2);
Z = number_of_no_purchase - cov/variance*(total_number_of_economy_customers- 144*(1-2/pi));

%Plots Variance Reduction 
figure; histogram(Z);
title('Variance Reduction: Control Variates'); grid on;
xlabel('Number of "No purchases"'); ylabel('Frequency'); 
saveas(gcf,sprintf('variance_reduction_scenario%i.png',scenario.CaseIndex));

mean_Z = mean(Z)
MSE_Z = var(Z)/length(Z)
bootMSE_Z = BootstrapMSE(Z, @mean, 100)
hold on;
ylim=get(gca,'ylim');
l1 = line([mean_Z mean_Z], ylim,'Color','r','LineWidth',2.0);
l2 = line([mean_Z+MSE_Z mean_Z+MSE_Z], ylim,'Color','r','LineWidth',2.0,'LineStyle',':');
l3 = line([mean_Z-bootMSE_Z mean_Z-bootMSE_Z], ylim,'Color','r','LineWidth',2.0,'LineStyle','--');
l4 = line([prctile(Z,5) prctile(Z,5)], ylim,'Color','g','LineWidth',2.0,'LineStyle','--');
line([prctile(Z,95) prctile(Z,95)], ylim,'Color','g','LineWidth',2.0,'LineStyle','--');
hold off;
legend([l1,l2,l3,l4],'mean', 'MSE', 'bootstrap MSE', '5 and 95 percentile')

%Plot - Total Revenue 
fprintf('Total revenue:')
figure; histogram(total_revenue/10^6); grid on;
title('Total revenue distribution'); 
xlabel('Total revenue [millions of CHF]'); ylabel('Frequency');
mean_total_revenue = mean(total_revenue)/10^6
MSE_total_revenue = var(total_revenue/10^6)/length(total_revenue)
bootMSE_total_revenue = BootstrapMSE(total_revenue/10^6, @mean, 100)
hold on;
ylim=get(gca,'ylim');
l1 = line([mean_total_revenue mean_total_revenue], ylim,'Color','r','LineWidth',2.0);
l2 = line([mean_total_revenue+MSE_total_revenue mean_total_revenue+MSE_total_revenue], ylim,'Color','r','LineWidth',2.0,'LineStyle',':');
l3 = line([mean_total_revenue-bootMSE_total_revenue mean_total_revenue-bootMSE_total_revenue], ylim,'Color','r','LineWidth',2.0,'LineStyle','--');
l4 = line([prctile(total_revenue/10^6,5) prctile(total_revenue/10^6,5)], ylim,'Color','g','LineWidth',2.0,'LineStyle','--');
line([prctile(total_revenue/10^6,95) prctile(total_revenue/10^6,95)], ylim,'Color','g','LineWidth',2.0,'LineStyle','--');
hold off;
legend([l1,l2,l3,l4],'mean', 'MSE', 'bootstrap MSE', '5 and 95 percentile')
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

%Joined Graph for variance reduction (Z and X=No of no purchases) 
figure; 
joinedh = histogram(number_of_no_purchase);
hold on;
histogram(Z, 'BinEdges', joinedh.BinEdges);
hold off;
grid on;
xlabel('');
ylabel('Frequency');
h = legend('X = # of no purchase', 'Variable Z');
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