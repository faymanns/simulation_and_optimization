function lambdaValue = lambdaFunctionLeisure(t)

% ============================================================================
% DESCRIPTION
%
% usage: lambdaValue = lambdaFunction(t)
%
% Function describing Leisure segment arrival rate of the Nonhomogeneous
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
lambdaValue = (0.6/179)*abs(t); 

end
