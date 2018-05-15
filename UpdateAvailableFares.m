function [available_fares,available_seats_for_fare,sold_out_time] = UpdateAvailableFares (fare,available_fares,available_seats_for_fare,sold_out_time,t)

available_seats_for_fare(fare)=available_seats_for_fare(fare)-1; % reduces over one from the number of the available seats for this fare
% check if there are still available seats for this fare
if ( available_seats_for_fare(fare)==0 && t>=0 )
    available_fares = available_fares(available_fares~=fare);
    sold_out_time(fare)=t;
end

end

        