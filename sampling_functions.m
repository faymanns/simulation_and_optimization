function t_sampled = sample_business(t,lambda,lambda_max)
    t_sampled = Nan
    while t_sampled == Nan
        r=rand();
        t=t+log(r)/lambda_max;
        s=rand();
        if s<=lambdaFunction(t)/lambda
            t_sampled = t;
        end
    end
end

function t_sampled = sample_leisure(t,lambda,lambda_max)
    t_sampled = Nan
    while t_sampled == Nan
        r=rand();
        t=t+log(r)/lambda_max;
        s=rand();
        if s<=lambdaFunction(t)/lambda
            t_sampled = t;
        end
    end
end

function t_sampled = sample_economy(t,lambda,lambda_max)
    t_sampled = Nan
    while t_sampled == Nan
        r=rand();
        t=t+log(r)/lambda_max;
        s=rand();
        if s<=lambdaFunction(t)/lambda
            t_sampled = t;
        end
    end
end