
function y = GenerateNewCitySequence(x, problem)

% ============================================================================
% DESCRIPTION
%
% usage: y = GenerateNewCitySequence(x, problem)
%
% Returns a permutation of the row vector "x", where the first element
% of "x" stays unchanged. Implement different specifications. For example:
%   - exchanges two randomly selected entries of "x"
% 
% ----------------------------------------------------------------------------
% PARAMETERS
%
% x         a row vector representing the current city sequence
% problem   the entire "problem" data structure. To be added as dummy if not used
% 
% ----------------------------------------------------------------------------
% RETURN VALUES
%
% y         a row vector with a permutation of "x" where the first element 
%           of "y" is the first element of "x"
%    
%
% ============================================================================

idx1 = ceil(rand()*(length(x)-1))+1;
idx2 = ceil(rand()*(length(x)-1))+1;
while idx2 == idx1
    idx2 = ceil(rand()*(length(x)-1))+1;
end
y = x;
y(idx1) = x(idx2);
y(idx2) = x(idx1);