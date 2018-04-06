function event = NewEvent(time, passenger_segment)
% =========================================================================
% 
% DESCRIPTION
%
% usage: event = NewEvent(time, passenger_segment)
%
% Generates a "passenger_segment" event that occurred at "time"
%
% -------------------------------------------------------------------------
% 
% PARAMETERS
%
% time                  the time at which the event occurred; a real number
% passenger_segment     the type of the event; an integer number where
%                           1 = BUSINESS segment
%                           2 = LEUISURE segment
%                           3 = ECONOMY segment
%                       The company classifies the passengers into these
%                       three segments. Passengers of each segment have
%                       similar behavior.
%
% -------------------------------------------------------------------------
% 
% RETURN VALUES
%
% event                 a data structure with the two fields "time", 
%                       "passenger_segment" that represents the respective event
%
% =========================================================================
% 

event.time = time;
event.passenger_segment = passenger_segment;

end