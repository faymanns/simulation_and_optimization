
function MSE = BootstrapMSE(data, statistic, draws)

% ============================================================================
% DESCRIPTION
%
% usage: mse = BootstrapMSE(data, statistic, draws)
%
% Calculates the bootstrap mean square error "mse" for the function handle
% "statistic" applied to the data "data", using "draws" bootstrap draws.
%
% Example: If you want to estimate the Bootstrap MSE for the mean of a data
% set "data" with 100 bootstrap draws, call this: Bootstrap(data, @mean, 100)
% ----------------------------------------------------------------------------
% PARAMETERS
%
% data       a row vector of the data
% statistic  a function handle for the statistic to be evaluated; if this
%            statistic is implemented as a function f then you need to
%            -- pass @f as the statistic parameter
%            -- implement f such that f(data) yields the desired statistic
%            Help: use the function feval() to evaluate a function handle
% draws      the number of bootstrap draws; a recommended value is 100
%
% ----------------------------------------------------------------------------
% RETURN VALUES
%
% MSE        the bootstrap mean square error of the given statistic over the
%            given data
% ============================================================================

iteration = 0;
n = length(data);
M_r = [];
data_stat = statistic(data);

while iteration<draws
    set = [];
    i = 0;
    while i < n
        i = i + 1;
        set = [set data(ceil(n*rand()))];
    end
    M_r = [M_r (statistic(set)-data_stat)^2];
    iteration = iteration + 1;
end
MSE = sum(M_r)/draws;
end
