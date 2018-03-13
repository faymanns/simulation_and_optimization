
function [times, queues] = QueueingSimulation1(scenario)

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

t=179;
total_revenue=0;
EventList = [];
%Generate first business customer
t_g = sample(t,1)
EventList = UpdatedEventList(EventList, NewEvent(t_g, 1));
%Generate first leasure customer
t_g = sample(t,2)
EventList = UpdatedEventList(EventList, NewEvent(t_g, 2));
%Generate first economy customer
t_g = sample(t,3)
EventList = UpdatedEventList(EventList, NewEvent(t_g, 3));

times=[];
while not(isempty(EventList))
    t = EventList(1).time;
    if t<0
        break;
    end
    times = [times, t];
    type = EventList(1).type;
    switch type
        case 1%Business
            t_g = sample(t,1)
            EventList = UpdatedEventList(EventList,NewEvent(t_g,1,1));
        case 2%Leisure
            t_g = sample(t,2)
            EventList = UpdatedEventList(EventList,NewEvent(t_g,1,2));
        case 3%Economy
            t_g = sample(t,3)
            EventList = UpdatedEventList(EventList,NewEvent(t_g,1,3));
    end
    EventList = EventList([2:end]);
end

end
