%% Test the implementation of simulation.m function

%% clean the workspace
clear all; %Removes all variables, functions, and MEX-files from memory, leaving the workspace empty
close all; % delete all figures whose handles are not hidden.
clc; % clear command window

%% Program
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
total_number_of_customers = [];
total_revenue = [];

for i = 1:1000
    [times, revenues, available_seats_for_fare, segments] = simulation(scenario);
    if available_seats_for_fare==0
        index = find(revenues,1,'last');   %last customer that could by a ticket, afterwards no seats were left
    else
        index = length(revenues);
    end
    
    number_of_couldent_purchase = [number_of_no_purchase, sum(revenues(index:end)==0)];
    
    revenues = revenues(1:index);
    segments = segments(1:index);
    
    number_of_no_purchase = [number_of_no_purchase, sum(revenues==0)];
    number_of_business_customers = [number_of_business_customers, sum(segments==1)];
    number_of_leisure_customers = [number_of_leisure_customers, sum(segments==2)];
    number_of_economy_customers = [number_of_economy_customers, sum(segments==3)];
    number_of_no_purchase_business = [number_of_no_purchase_business, sum(revenues(segments==1)~=0)];
    number_of_no_purchase_leisure = [number_of_no_purchase_leisure, sum(revenues(segments==2)~=0)];
    number_of_no_purchase_economy = [number_of_no_purchase_economy, sum(revenues(segments==3)~=0)];
    number_of_seats_sold = [number_of_seats_sold, 180-sum(available_seats_for_fare)];
    total_number_of_customers = [total_number_of_customers, length(revenues)];
    total_revenue = [total_revenue, sum(revenues)];
end


% for i = [1 2 3 4 5 6 7 8 9]
%     if ~( (20-sum(revenues==scenario.revenues(i))) == available_seats_for_fare(i) )
%         fprintf('Numbers for fare %d do not add up!\n',i)
%     end
% end
% 
% histogram(times(segments==1), 20);
% figure;
% histogram(times(segments==2), 20);
% figure;
% histogram(times(segments==3), 20);