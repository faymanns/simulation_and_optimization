
function [solutions, values, dummy] = GreedyAlgorithm(problem)

% ============================================================================
% DESCRIPTION
%
% usage: [solutions, values, dummy] = GreedyAlgorithm(problem)
%
% Solves the optimization problem "problem" using a greedy algorithm.
% For example, visiting the closest city every step. 
% "problem" is a MATLAB data structure. Using a data structure allows to
% pass problem specific information between the different function handles
% specified further below.
%
% ----------------------------------------------------------------------------
% PARAMETERS
%
% problem.INITIAL_SOLUTION    a row vector that represents an initial solution
%                             of the problem                         
% problem.RANDOMIZE           a handle to a function that generates a proposal
%                             solution from a given solution; this function
%                             must take the following two parameters:
%                             1. the current solution (a row vector)
%                             2. the entire "problem" data structure 
%                             The return value of this function must again be
%                             a row vector of appropriate dimension.
% problem.OBJECTIVE_FUNCTION  a handle to a function that computes the
%                             objective function value for a given solution;
%                             this function must take the following 
%                             parameters:
%                             1. the solution to be evaluated (a row vector)
%                             2. the "problem" data structure
%                             The return value of this function must be a 
%                             scalar value.
% 
% ----------------------------------------------------------------------------
% RETURN VALUES
%
% solutions                   a matrix where the i-th row contains the 
%                             solution computed in the i-th iteration.
%                             Only one solution is returned by the greedy algorithm        
% values                      a column vector where the i-th row contains 
%                             the objective function value computed in the 
%                             i-th iteration.
%                             Only a value is returned by the greedy algorithm
% dummy                       a dummy output
%
% ============================================================================


%
% Implement your own solution here.
%
n = length(problem.INITIAL_SOLUTION);
solution = problem.INITIAL_SOLUTION;
current_city = solution(1);
for i = 2:n
    minimum = norm(problem.CITIES(solution(i),:)-problem.CITIES(current_city,:));
    idx = i;
    for j = i+1:n
        d = norm(problem.CITIES(solution(j),:)-problem.CITIES(current_city,:));
        if minimum > d
            minimum = d;
            idx = j;
        end
    end
    tmp = solution(idx);
    solution(idx) = solution(i);
    solution(i) = tmp;
    current_city = tmp;
end
solutions = solution;
values = EvaluateCitySequence(solution,problem);
dummy = 0;