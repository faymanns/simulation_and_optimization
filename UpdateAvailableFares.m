function [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (fare,available_fares,available_seats_for_fare,sold_out_time,t,scenario)

if isempty(available_fares)
    % Booking limit for every product is defined by the generated scenario 
    available_seats_for_fare = scenario.booking_limits;
                
    % Initial set with the available fares
    for fare_index=1:(scenario.NUMBER_OF_PRODUCTS)
        if ( t<=scenario.availability_start(fare_index) && t>=scenario.availability_stop(fare_index) )
            available_fares = [ available_fares, fare_index];
        end
    end
    
else
    available_seats_for_fare(fare)=available_seats_for_fare(fare)-1; % reduces over one from the number of the available seats for this fare
    % check if there are still available seats for this fare
    if ( available_seats_for_fare(fare)==0 && t>=0 )
        available_fares = available_fares(available_fares~=fare);
        sold_out_time(fare)=t;
    end
    
    % update the list with the available fares based on the booking
    % intervals (from those that haven't sold out)
    for fare_index=1:(scenario.NUMBER_OF_PRODUCTS-1)
        if ( t<=scenario.availability_start(fare_index) && t>=scenario.availability_stop(fare_index) )
            available_fares = [available_fares, fare_index];
            available_fares = sort(available_fares);
        end
    end
end

end

        