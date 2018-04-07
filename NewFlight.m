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
% .NUMBER_OF_PRODUCTS   number of the product fares offered by the company
% .MaxLAMBDA_BUSINESS   maximum value for given lambda function describing 
%                       business arrival rate (resulted analytically from 
%                       ??(t) = 1.2 sin(t), where the argument of sin is in
%                       degrees)
% .MaxLAMBDA_LEISURE    maximum value for given lambda function describing 
%                       leisure arrival rate (resulted analytically from 
%                       ??(t) = 0.6 t/179 )
% .MaxLAMBDA_ECONOMY    maximum value for given lambda function describing 
%                       economy arrival rate (resulted analytically from 
%                       ??(t) = 0.8 (1 + sin(t + 180), where the argument of
%                       sin is in degrees)
% .BusinessWeights      vector containing the preference weights of the
%                       Business segment for each fare ( each cell corresponds
%                       to a different fare, i.e., the first element of the
%                       vector refers to fare product A, the second element
%                       to product fare B, etc.). 
%                       The last element refers to No Purchase. 
% .LeisureWeights       vector containing the preference weights of the
%                       Leisure segment for each fare 
% .EconomyWeights       vector containing the preference weights of the
%                       Economy segment for each fare
% .revenues             vector containing the revenue for each fare product
%                       (in CHF)
% ============================================================================

scenario.PLANNING_HORIZON = 180;
scenario.MaxLAMBDA_BUSINESS = 1.2;  % resulted analytically from the functions given bla bla
scenario.MaxLAMBDA_LEISURE = 0.6; 
scenario.MaxLAMBDA_ECONOMY = 0.8; 
scenario.NUMBER_OF_PRODUCTS = 10;

scenario.BusinessWeights = [ 11 15 18 20 19 15 12 11 13 8 ];
scenario.LeisureWeights = [ 8 9 11 12 14 15 16 18 20 8 ];
scenario.EconomyWeights = [ 1 5 8 10 11 12 13 15 20 8 ];
scenario.revenues = [1000 900 850 750 700 650 600 500 350 0];
scenario.CaseIndex = 1; %1 or 2 for the two cases 
end


