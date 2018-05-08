function scenario = generate_neighbors3(scenario, avg_available_seats_for_fare, avg_sold_out_time)

%Change ending dates
%Randomly choose a product and move its ending point
endingDates=scenario.availability_stop;
maxChange=3; 
r=rand();
d=ceil(maxChange*r);
r=rand();
index=ceil(r*9);
r=rand();
if r<0.5 
    d=-d;
end
endingDates(index)=min(max(endingDates(index)+d,0),179);
scenario.availability_stop=endingDates;
end