function event = NewEvent(time, passenger_segment)
% =========================================================================
% 
% DESCRIPTION
%
% usage: event = NewEvent(time, link, type)
%
% Generates a "type" event that occurred at "time" on "link" 
%
% -------------------------------------------------------------------------
% 
% PARAMETERS
%
% time   the time at which the event occurred; a real number
% link   the link on which the event occurred; an integer number
% type   the type of the event; an integer number where
%          1 = ARRIVAL event
%          2 = DEPARTURE (service) event
%
% -------------------------------------------------------------------------
% 
% RETURN VALUES
%
% event  a data structure with the three fields "time", "link", and "type"
%        that represents the respective event
%
% =========================================================================
% 

event.time = time;
event.passenger_segment = passenger_segment;

end