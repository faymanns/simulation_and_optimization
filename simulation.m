function [times, revenues, available_seats_for_fare, segments, sold_out_time] = simulation(scenario)
% ============================================================================
% DESCRIPTION
%
% usage: [times, revenues, available_seats_for_fare, segments, sold_out_time] = simulation(scenario)
%
% Runs a simulation of "scenario".
%
% ----------------------------------------------------------------------------
% PARAMETERS
%
% scenario                      a sinlge flight under study
%
% ---------------------------------------------------------------------------
% RETURN VALUES
%
% times                         row vector of event times
% revenues                      row vector of revenues at the event times
% available_seats_for_fare      row vector of available seats for each fare 
% segments                      row vector of segments at the event times
% sold_out_time                 row vector of the sold out time for each fare
% ============================================================================

t = scenario.PLANNING_HORIZON;   % starting simulation from the first day of sales (t=179)    
EventList = [];                  % create an empty events' list

% Add 21-day advantage end event because products D and H are not offered
% after t = 21 [days]
% EventList = UpdatedEventList(EventList, NewEvent(21., 4));

% Generate first business customer
t_g = sample(t,1,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 1));
% Generate first leasure customer
t_g = sample(t,2,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 2));
% Generate first economy customer
t_g = sample(t,3,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 3));

% Generate availability start event
for product_id = 1:scenario.NUMBER_OF_PRODUCTS
    EventList = UpdatedEventList(EventList, NewEvent(scenario.availability_start(product_id), 4));
end
% Generate availability stop event
for product_id = 1:scenario.NUMBER_OF_PRODUCTS
    EventList = UpdatedEventList(EventList, NewEvent(scenario.availability_stop(product_id), 5));
end

times=[];
revenues=[];
segments=[];
sold_out_time=-ones(1,10);
fare=[];
available_fares = [];
available_seats_for_fare=scenario.booking_limits;
t = EventList(1).time;

while t>=0
    
    type = EventList(1).passenger_segment;

    switch type
        case 1  % Business
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 1, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 1));
            fare = sample_fare_product(1, available_fares, scenario);
            [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (fare,available_fares,available_seats_for_fare,sold_out_time,t);
            revenues = [revenues, scenario.revenues(fare)];
            
        case 2  % Leisure
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 2, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 2));
            fare = sample_fare_product(2, available_fares, scenario);
            [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (fare,available_fares,available_seats_for_fare,sold_out_time,t);
            revenues = [revenues, scenario.revenues(fare)];
            
        case 3  % Economy
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 3, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 3));
            fare = sample_fare_product(3, available_fares, scenario);
            [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (fare,available_fares,available_seats_for_fare,sold_out_time,t);
            revenues = [revenues, scenario.revenues(fare)];
        case 4 %start availability
            for product_id = 1:scenario.NUMBER_OF_PRODUCTS
                if t == scenario.availability_start(product_id) && ~any(available_fares==product_id)
                    available_fares = [available_fares, product_id];
                end
            end
        case 5 %stop availability
            for product_id = 1:scenario.NUMBER_OF_PRODUCTS
                if t == scenario.availability_stop(product_id)
                    available_fares = available_fares(available_fares~=product_id);
                end
            end
    end
    
    EventList = EventList([2:end]);
    t = EventList(1).time;
end

end
