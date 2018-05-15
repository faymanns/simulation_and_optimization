function [solutions, values, temperatures] = SimulatedAnnealing(problem)

% ============================================================================
% DESCRIPTION
%
% usage: [solutions, values, temperatures] = SimulatedAnnealing(problem)
%
% Solves the optimization problem "problem" using simulated annealing.
% "problem" is a MATLAB data structure. Using a data structure allows to
% pass problem specific information between the different function handles
% specified further below.
%
% ----------------------------------------------------------------------------
% PARAMETERS
%
% problem.M                   Number of temperature changes
% problem.K                   Number of iterations per level of temperature
% problem.D                   Average increase of the objective function
% problem.P0                  Initial acceptance probability
% problem.Pf                  Final acceptance probability
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
%                             solution computed in the i-th iteration
% values                      a column vector where the i-th row contains 
%                             the objective function value computed in the 
%                             i-th iteration
% temperatures                a vector with the temperature at each iteration
%
% ============================================================================


%
% Implement your own solution here.
%



solutions = [problem.INITIAL_SCENARIO];
[Q, avg_available_seats_for_fare, avg_sold_out_time] = problem.OBJECTIVE_FUNCTION(problem.INITIAL_SCENARIO);
values = [Q];

m=1:problem.M;
temperatures = -problem.D./(log(problem.P0 + (problem.Pf-problem.P0)/problem.M*m));



for i = 1:problem.M
T = temperatures(i);
for j = 1:problem.K
    neighbour = generate_neighbor_random(solutions(end), avg_available_seats_for_fare, avg_sold_out_time);
    [Q, avg_available_seats_for_fare, avg_sold_out_time] = problem.OBJECTIVE_FUNCTION(neighbour);
    if Q > values(end)
        solutions = [solutions,neighbour];
        values = [values, Q];
    elseif rand() < exp((Q-values(end))/T)
        solutions = [solutions,neighbour];
        values = [values, Q];
    end
end
end

end

