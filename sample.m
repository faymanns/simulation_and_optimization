function t_sampled = sample(t,segment_type,scenario)

switch segment_type
    
    case 1      % Corresponds to Business segment
        t_sampled = NaN;
        while isnan(t_sampled)
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_BUSINESS);
            s = rand();
            if s<=sin(degtorad(t))
                t_sampled = t;
            end
        end

    case 2     % Corresponds to Leisure segment
        t_sampled = NaN;
        while isnan(t_sampled)
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_LEISURE);
            s = rand();
            if s<=t/179
                t_sampled = t;
            end
        end

    case 3     % Corresponds to Economy segment
        t_sampled = NaN;
        while isnan(t_sampled)
            r = rand();
            t = t+log(r)/(scenario.MaxLAMBDA_ECONOMY);
            s = rand();
            if s<= 0.5*(1+sin(degtorad(t+180)))
                t_sampled = t;
            end
        end
end
end
