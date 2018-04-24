
function Q = EvaluateCitySequence(x, problem)

% ============================================================================
% DESCRIPTION
%
% usage: Q = EvaluateCitySequence(x, problem)
%
% Returns the objective function value of the solution x.
% 
% ----------------------------------------------------------------------------
% PARAMETERS
%
% x        a row vector representing the solution to be evaluated
% problem  MATLAB data structure that contains supplementary information
%          about the problem, in particular the coordinates of the cities:
%          problem.CITIES is a matrix where every row contains the x- and y-
%          coordinate of one city.
% 
% ----------------------------------------------------------------------------
% RETURN VALUES
%
% Q        a scalar representing the objective function value of "x"
%
% ============================================================================


%
% Implement your own solution here.
%
Q=0;
provenance = x(1);

for i = x(2:end)
    Q = Q + norm(problem.CITIES(i,:)-problem.CITIES(provenance,:));
    provenance = i;
end
Q = Q + norm(problem.CITIES(x(1),:)-problem.CITIES(provenance,:));