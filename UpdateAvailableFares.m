function [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (CaseIndex,fare,available_fares,available_seats_for_fare,sold_out_time,t)

    switch CaseIndex 
        case 1 
            if isempty(available_fares)
                %All fare products available from t=179 to t=0 
                %Booking limit = 20 for every product 
                available_seats_for_fare = [20,20,20,20,20,20,20,20,20,0];
                available_fares = [1,2,3,4,5,6,7,8,9,10];
            else
                available_seats_for_fare(fare)=available_seats_for_fare(fare)-1;
                if available_seats_for_fare(fare)==0 && t>=0 
                    available_fares = available_fares(available_fares~=fare);
                    sold_out_time(fare)=t;
                end
            end
                      
        case 2 
            %Only 1 product available every time available until it reaches its
            %limit starting from I, H, ... A 
            %Booking limit = 20 for every product 
            if isempty(available_fares)
                index=9;
                available_seats_for_fare = [20,20,20,20,20,20,20,20,20,0];
                available_fares = [index,10];
            else
                available_seats_for_fare(fare)=available_seats_for_fare(fare)-1;
                if available_seats_for_fare(fare)==0 && t>=0 
                    available_fares = available_fares(available_fares~=fare);
                    sold_out_time(fare)=t;
                    if fare>1
                        available_fares=[(fare-1) available_fares];
                    end
                end
            end
    end
    
end

        