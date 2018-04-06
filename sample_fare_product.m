function fare = sample_fare_product(passenger_segment, available_fare, scenario)
% ============================================================================
% DESCRIPTION
%
% usage: fare = sample_fare_product(passenger_segment, available_fare, scenario)
%
% Sampling fare product based on the weight preferences of each passenger segment
% and on the available fare products offered.
%
% ----------------------------------------------------------------------------
% PARAMETERS
%
% passenger_segment    the type of the event; an integer number where
%                           1 = BUSINESS segment
%                           2 = LEUISURE segment
%                           3 = ECONOMY segment
% available_fare       the set of the available products offered by the
%                      airline company
% scenario             a sinlge flight under study
%
% ---------------------------------------------------------------------------
% RETURN VALUES
%
% fare                 product fare sampled
% ============================================================================

r = rand();
fare = scenario.NUMBER_OF_PRODUCTS;
summation = 0;

if passenger_segment == 1       % Passenger from Business segment 
    for i = available_fare
        summation = summation + scenario.BusinessWeights(i);
    end
    
    threshold = 0;
    for i = available_fare
        threshold = threshold  + scenario.BusinessWeights(i)/summation;
        if r < threshold
            fare = i;
            break;
        end
    end
        
elseif passenger_segment == 2   % Passenger from Leisure segment
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
    
elseif passenger_segment == 3   % Passenger from Economy segment
    for i = available_fare
        summation = summation + scenario.EconomyWeights(i);
    end
    
    threshold = 0;
    for i = available_fare
        threshold = threshold + scenario.EconomyWeights(i)/summation;
        if r < threshold
            fare = i;
            break;
        end
    end
end
end