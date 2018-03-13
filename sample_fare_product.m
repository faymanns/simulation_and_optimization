function fare = sample_fare_product(passenger_segment,available_fare,scenario)
    r = rand();
    summation = 0;
    if passenger_segment == 1
        for i = available_fare
            summation = summation + scenario.BusinessWeights(i);
        end
        for i = available_fare
            if r < scenario.BusinessWeights(i)/summation
                fare = i;
                break;
            end
        end
    elseif passenger_segment == 2
        for i = available_fare
            summation = summation + scenario.LeisureWeights(i);
        end
        for i = available_fare
            if r < scenario.LeisureWeights(i)/summation
                fare = i;
                break;
            end
        end
    elseif passenger_segment == 3
        for i = available_fare
            summation = summation + scenario.EconomyWeights(i);
        end
        for i = available_fare
            if r < scenario.EconomyWeights(i)/summation
                fare = i;
                break;
            end
        end
    end
end