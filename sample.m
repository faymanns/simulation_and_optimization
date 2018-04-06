function t_sampled = sample(t, passenger_segment, scenario)
% ============================================================================
% DESCRIPTION
%
% usage: t_sampled = sample(t, segment_type, scenario)
%
% Sampling arrival time based on the passenger segment arrival rates.
% Given the integer for the passenger segment, it samples from 
% a Nonhomogeneous Poisson Process over time.
%
% ----------------------------------------------------------------------------
% PARAMETERS
%
% t                   current time 
% passenger_segment   the type of the event; an integer number where
%                           1 = BUSINESS segment
%                           2 = LEUISURE segment
%                           3 = ECONOMY segment
% scenario            a single flight under study 
%
% ---------------------------------------------------------------------------
% RETURN VALUES
%
% t_sampled      sampled arrival time for a passenger from segment
%                "segment_type"
% ============================================================================

switch passenger_segment
    
    case 1      % Corresponds to Business segment
        t_sampled = NaN;
        while isnan(t_sampled)
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_BUSINESS);
            s = rand();
            if s<=lambdaFunctionBusiness(t)/(scenario.MaxLAMBDA_BUSINESS)
                t_sampled = t;
            end
        end

    case 2     % Corresponds to Leisure segment
        t_sampled = NaN;
        while isnan(t_sampled)
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_LEISURE);
            s = rand();
            if s<=lambdaFunctionLeisure(t)/(scenario.MaxLAMBDA_LEISURE)
                t_sampled = t;
            end
        end

    case 3     % Corresponds to Economy segment
        t_sampled = NaN;
        while isnan(t_sampled)
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_ECONOMY);
            s = rand();
            if s<= lambdaFunctionEconomy(t)/(scenario.MaxLAMBDA_ECONOMY)
                t_sampled = t;
            end
        end
end
end
