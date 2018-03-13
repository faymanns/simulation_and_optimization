function fare = sample_fare_product(passenger_segment,available_fare,scenario)
    r = rand();
    fare = 10;
    summation = 0;
    if passenger_segment == 1
        for i = available_fare
            summation = summation + scenario.BusinessWeights(i);
        end
        threshold = 0;
        for i = available_fare
            threshold = threshold  + scenario.BusinessWeights(i)/summation;
            if r < scenario.BusinessWeights(i)/summation
                fare = i;
                break;
            end
        end
    elseif passenger_segment == 2
        for i = available_fare
            summation = summation + scenario.LeisureWeights(i);
        end
        threshold = 0;
        for i = available_fare
            threshold = threshold + scenario.LeisureWeights(i)/summation;
            if r < threshold
                fare = i;
                break;
            end
        end
    elseif passenger_segment == 3
        for i = available_fare
            summation = summation + scenario.EconomyWeights(i);
        end
        threshold = 0;
        for i = available_fare
            threshold + threshold + scenario.LeisureWeights(i)/summation;
            if r < threshold
                fare = i;
                break;
            end
        end
    end
end