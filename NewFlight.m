function scenario = NewFlight()

% ============================================================================
% DESCRIPTION
%
% usage: scenario = ()
%
% Create a single flight scenario.
%
% ----------------------------------------------------------------------------
% PARAMETERS
%
% ----------------------------------------------------------------------------
% RETURN VALUES
%  
% scenario
% .PLANNING_HORIZON     planning horizon for the sale of the seat inventory
%                       (ends on the day of departure)
% .MaxLAMBDA_BUSINESS   maximum value for given lambda function describing business arrival rate       
% .MaxLAMBDA_LEISURE    maximum value for given lambda function describing leisure arrival rate        
% .MaxLAMBDA_ECONOMY    maximum value for given lambda function describing economy arrival rate
% ============================================================================

scenario.PLANNING_HORIZON = 179;
scenario.MaxLAMBDA_BUSINESS = 1.2;  % resulted analytically from the functions given bla bla
scenario.MaxLAMBDA_LEISURE = 0.6; 
scenario.MaxLAMBDA_ECONOMY = 1.6; 
end


