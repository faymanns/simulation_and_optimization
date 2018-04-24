
function [solutions, values, dummy] = FullEnumeration(problem)

% ============================================================================
% DESCRIPTION
%
% usage: [solutions, values, dummy] = FullEnumeration(problem)
%
% Solves the optimization problem "problem" using full enumeration.
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
%                             solution computed in the i-th iteration
% values                      a column vector where the i-th row contains 
%                             the objective function value computed in the 
%                             i-th iteration
% dummy                       a dummy output
%
% ============================================================================


%
% Implement your own solution here.
%
n = length(problem.INITIAL_SOLUTION);
n_fac = factorial(n);
%solutions = int16.empty(n_fac, n);
%solutions(1,:) = problem.INITIAL_SOLUTION;
%values = double.empty(n_fac);
%values(1,:) = problem.OBJECTIVE_FUNCTION(solutions);

current_permutation = problem.INITIAL_SOLUTION;
solution = problem.INITIAL_SOLUTION;
minimum = problem.OBJECTIVE_FUNCTION(current_permutation,problem);
n_iterations = 5000;
tic;
for i = 2:n_iterations
    %fprintf([num2str(i),' of ',num2str(n_fac),'\n']);
    %solutions(i,:) = problem.RANDOMIZE(solutions(i-1,:));
    %values(i,:) = problem.OBJECTIVE_FUNCTION(solutions(i,:));
    current_permutation = problem.RANDOMIZE(current_permutation);
    value = problem.OBJECTIVE_FUNCTION(current_permutation,problem);
    if value < minimum
        minimum = value;
        solution = current_permutation;
    end
end
fprintf(['Estimate of required time ',num2str(n_fac/n_iterations*toc/60/60/24),'\n'])
solutions = solution;
values = minimum;
dummy = 0;
