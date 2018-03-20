function [newAverage, newVariance] = UpdatedStatistics(oldAverage, oldVariance, newData, iteration)
% ============================================================================
% DESCRIPTION
%
% usage: [newAverage, newVariance] = UpdatedStatistics(oldAverage, ...
%                                            oldVariance, newData, iteration)
%
% Recursively updates "oldAverages" and "oldVariances" based on the data
% "newData", which arrived in iteration "iteration".
%
% ----------------------------------------------------------------------------
% PARAMETERS
%
% oldAverage    the previously calculated average, must be initially zero
% oldVariance   the previously calculated variance, must be initially zero
% newData       a newly sampled random number
% iteration     the iteration in which "newData" arrived, where the i-th data
%               item arrives in iteration i
%
% ---------------------------------------------------------------------------
% RETURN VALUES
%
% newAverage    the updated average including the new data
% newVariance   the updated variance including the new data
% ============================================================================


%% Implementation of solution 

% Calculate new average after the newly sampled random number is added
newAverage = (newData + (iteration-1)*oldAverage)/iteration;

% Calculate new variance after the newly sampled random number is added
newVariance = (iteration/(iteration+1))*(oldVariance + ((oldAverage - newData)^2)/(iteration+1));

end