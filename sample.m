function t_sampled = sample(t,segment_type)

switch segment_type
    
    case 1      % Corresponds to Business segment
        t_sampled = NaN;
        while t_sampled == Nan
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_BUSINESS);
            s = rand();
            if s<=lambdaFunctionBusiness(t)/(scenario.MaxLAMBDA_BUSINESS)
                t_sampled = t;
            end
        end

    case 2     % Corresponds to Leisure segment
        t_sampled = Nan;
        while t_sampled == Nan
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_LEISURE);
            s = rand();
            if s<=lambdaFunctionLeisure(t)/(scenario.MaxLAMBDA_LEISURE)
                t_sampled = t;
            end
        end

    case 3     % Corresponds to Economy segment
        t_sampled = Nan;
        while t_sampled == Nan
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_ECONOMY);
            s = rand();
            if s<= lambdaFunctionEconomy(t)/(scenario.MaxLAMBDA_ECONOMY)
                t_sampled = t;
            end
        end
end
end
