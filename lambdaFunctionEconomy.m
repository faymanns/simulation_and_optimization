function gammaValue = lambdaFunctionEconomy(t)

% ============================================================================
% DESCRIPTION
%
% usage: gammaValue = lambdaFunction(t)
%
% Function describing Economy segment arrival rate of the Nonhomogeneous
% Poisson Process over time.
% 
% ----------------------------------------------------------------------------
% PARAMETERS
%
% t             time
%
% ---------------------------------------------------------------------------
% RETURN VALUES
%
% lambdaValue   rate at time t  
%
% ============================================================================


%% Function
gammaValue = 0.8*(1+sin(degtorad(t+180))); 

end
