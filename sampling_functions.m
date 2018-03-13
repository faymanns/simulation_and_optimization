function t_sampled = sample_business(t)
    t_sampled = Nan;
    while t_sampled == Nan
        r = rand();
        t = t+log(r)/1.2;
        s = rand();
        if s<=sin(degtorad(t))
            t_sampled = t;
        end
    end
end

function t_sampled = sample_leisure(t)
    t_sampled = Nan;
    while t_sampled == Nan
        r = rand();
        t = t+log(r)/0.6;
        s = rand();
        if s<=t/179
            t_sampled = t;
        end
    end
end

function t_sampled = sample_economy(t)
    t_sampled = Nan;
    while t_sampled == Nan
        r = rand();
        t = t+log(r)/1.6;
        s = rand();
        if s<= 0.5*(1+sin(degtorad(t+180)))
            t_sampled = t;
        end
    end
end