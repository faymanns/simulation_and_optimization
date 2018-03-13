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
% .DEMAND_DURATION  length of the demand interval (how long vehicles enter)
% .T0               1 x 1 matrix that contains the free flow travel time
% .LAMBDA           1 x 1 matrix that contains the external entry rate
%
% ============================================================================


scenario.PLANNING_HORIZON = 179;
scenario.MaxLAMBDA_BUSINESS = 1.2;  % resulted analytically from the functions given bla bla
scenario.MaxLAMBDA_LEISURE = 0.6; 
scenario.MaxLAMBDA_ECONOMY = 1.6; 
end


