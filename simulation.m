
function [times, revenues, available_seats_for_fare, segments, sold_out_time] = simulation(scenario)

% ============================================================================
% DESCRIPTION
%
% usage: [times, queues] = QueueingSimulation1(scenario)
%
% Runs a simulation of "scenario".
%
% ----------------------------------------------------------------------------
% PARAMETERS
%
% scenario
% .DEMAND_DURATION  length of the demand interval (how long vehicles enter)
% .T0               1 x 1 matrix that contains the free flow travel time
% .LAMBDA           1 x 1 matrix that contains the external entry rate
% .MU               1 x 1 matrix that contains the road service rate
% .JOBLENGTH        length of a single vehicle 
%
% ---------------------------------------------------------------------------
% RETURN VALUES
%
% times             row vector of event times
% queues            row vector of queue sizes at the event times
%
% ============================================================================


%
% implement your solution here
%
t = scenario.PLANNING_HORIZON;
total_revenue = 0;
EventList = [];

available_fares = [1,2,3,4,5,6,7,8,9,10];
available_seats_for_fare = [20,20,20,20,20,20,20,20,20,0];

%Add 21-day advantage end event
EventList = UpdatedEventList(EventList, NewEvent(21., 4));

%Generate first business customer
t_g = sample(t,1,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 1));
%Generate first leasure customer
t_g = sample(t,2,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 2));
%Generate first economy customer
t_g = sample(t,3,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 3));

times=[];
revenues=[];
segments=[];
sold_out_time=-ones(1,10);
while t>=0
    t = EventList(1).time;
    type = EventList(1).passenger_segment;

    switch type
        case 1%Business
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 1, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 1));
            fare = sample_fare_product(1, available_fares, scenario);
            available_seats_for_fare(fare) = available_seats_for_fare(fare) - 1;
            revenues = [revenues, scenario.revenues(fare)];
        case 2%Leisure
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 2, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 2));
            fare = sample_fare_product(2, available_fares, scenario);
            available_seats_for_fare(fare) = available_seats_for_fare(fare) - 1;
            revenues = [revenues, scenario.revenues(fare)];
        case 3%Economy
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 3, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 3));
            fare = sample_fare_product(3, available_fares, scenario);
            available_seats_for_fare(fare) = available_seats_for_fare(fare) - 1;
            revenues = [revenues, scenario.revenues(fare)];
        case 4%end of 21-day advantage
            available_fares = available_fares(available_fares~=4);
            available_fares = available_fares(available_fares~=8);
    end
    if available_seats_for_fare(fare)==0 && t>=0 && type ~= 4
        available_fares = available_fares(available_fares~=fare);
        sold_out_time(fare)=t;
    end
    EventList = EventList([2:end]);
end

end
