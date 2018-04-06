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

scenario.PLANNING_HORIZON = 180;
scenario.MaxLAMBDA_BUSINESS = 1.2;  % resulted analytically from the functions given bla bla
scenario.MaxLAMBDA_LEISURE = 0.6; 
scenario.MaxLAMBDA_ECONOMY = 0.8; 
% scenario.BusinessWeights = table([ 11;15;18;20;19;15;12;11;13;8 ],{'A';'B';'C';'D';'E';'F';'G';'H';'I';'NP'});
% scenario.LeisureWeights = table([ 8;9;11;12;14;15;16;18;20;8 ],{'A';'B';'C';'D';'E';'F';'G';'H';'I';'NP'});
% scenario.EconomyWeights = table([ 1;5;8;10;11;12;13;15;20;8 ],{'A';'B';'C';'D';'E';'F';'G';'H';'I';'NP'}); 
scenario.BusinessWeights = [ 11 15 18 20 19 15 12 11 13 8 ];
scenario.LeisureWeights = [ 8 9 11 12 14 15 16 18 20 8 ];
scenario.EconomyWeights = [ 1 5 8 10 11 12 13 15 20 8 ];
scenario.revenues = [1000 900 850 750 700 650 600 500 350 0];
scenario.CaseIndex = 2; %1 or 2 for the two cases 
end


