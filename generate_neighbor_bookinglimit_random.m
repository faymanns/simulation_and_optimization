function scenario = generate_neighbor_bookinglimit_random(scenario, avg_available_seats_for_fare, avg_sold_out_time)
%Change booking Limits 
bookingLimits=scenario.booking_limits; 

%Randomly select 2 different fares
while 1
    rand1=ceil(9*rand());
    rand2=ceil(9*rand());
    if rand2~=rand1
        break 
    end
end

%Change booking limits of 2 random fares by a random value [0,10] (add it to the 1st,
%sustract from the 2nd) - no change of the duration and starting date 
dur=ceil(min(bookingLimits(rand1),180-bookingLimits(rand2))*rand());
bookingLimits(rand1)=bookingLimits(rand1)-dur;
bookingLimits(rand2)=bookingLimits(rand2)+dur;
scenario.booking_limits=bookingLimits;

end