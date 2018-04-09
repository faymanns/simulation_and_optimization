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
total_revenue = 0;               % the sum of the revenues for all the fares sold

% Add 21-day advantage end event because products D and H are not offered
% after t = 21 [days]
EventList = UpdatedEventList(EventList, NewEvent(21., 4));

% Generate first business customer
t_g = sample(t,1,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 1));
% Generate first leasure customer
t_g = sample(t,2,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 2));
% Generate first economy customer
t_g = sample(t,3,scenario);
EventList = UpdatedEventList(EventList, NewEvent(t_g, 3));

times=[];
revenues=[];
segments=[];
sold_out_time=-ones(1,10);
fare=[];
available_fares=[];
available_seats_for_fare=[];
CaseIndex=scenario.CaseIndex; %Fare availability case  
t = EventList(1).time;
[available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (CaseIndex,fare,available_fares,available_seats_for_fare,sold_out_time,t);
while t>=0
    
    type = EventList(1).passenger_segment;

    switch type
        case 1  % Business
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 1, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 1));
            fare = sample_fare_product(1, available_fares, scenario);
            [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (CaseIndex,fare,available_fares,available_seats_for_fare,sold_out_time,t);
            revenues = [revenues, scenario.revenues(fare)];
            
        case 2  % Leisure
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 2, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 2));
            fare = sample_fare_product(2, available_fares, scenario);
            [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (CaseIndex,fare,available_fares,available_seats_for_fare,sold_out_time,t);
            revenues = [revenues, scenario.revenues(fare)];
            
        case 3  % Economy
            segments = [segments, type];
            times = [times, t];
            t_g = sample(t, 3, scenario);
            EventList = UpdatedEventList(EventList,NewEvent(t_g, 3));
            fare = sample_fare_product(3, available_fares, scenario);
            [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (CaseIndex,fare,available_fares,available_seats_for_fare,sold_out_time,t);
            revenues = [revenues, scenario.revenues(fare)];
        case 4%end of 21-day advantage
            if CaseIndex==1 
                available_fares = available_fares(available_fares~=4);
                available_fares = available_fares(available_fares~=8);
            else
                current=available_fares(1); 
                available_fares = available_fares(available_fares~=4);
                available_fares = available_fares(available_fares~=8);
                if length(available_fares)==1
                    available_fares=[(current-1) available_fares]; 
                end
            end
     
    end
    
    EventList = EventList([2:end]);
    t = EventList(1).time;
end

end
