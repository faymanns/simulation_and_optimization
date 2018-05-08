function scenario = generate_neighbors2(scenario)

%Change starting dates
%Randomly choose a product and move its starting point
startingDates=scenario.availability_start;
maxChange=3; 
r=rand();
d=ceil(maxChange*r);
r=rand();
index=ceil(r*9);
r=rand();
if r<0.5 
    d=-d;
end
startingDates(index)=min(max(startingDates(index)+d,0),179);
scenario.availability_start=startingDates;

end

