function lambdaValue = lambdaFunctionBusiness(t)

% ============================================================================
% DESCRIPTION
%
% usage: lambdaValue = lambdaFunction(t)
%
% Function describing rate of the Nonhomogeneous Poisson Process over time
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
lambdaValue = 1.2*sin(degtorad(t)); 

end
