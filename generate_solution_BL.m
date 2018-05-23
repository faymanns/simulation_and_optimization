function scenario = generate_solution_BL(scenario, avg_available_seats_for_fare, avg_sold_out_time)
%Chooses one product with good average sales and increases its limit /
%inverse for one product with bad sales 
%product_sale: For each prouct - average no of sold items for the previous
%solution (not the no purhase) 

%Change booking limits for 2 of the products 
%Find total revenue for each product 

salesrevenues=(scenario.booking_limits(1:9)-avg_available_seats_for_fare(1:9)).*scenario.revenues(1:9);
%Increase booking limit of more profitable product  
sum1=sum(salesrevenues);
mat1=salesrevenues./sum1; %probabilities matrix
r=rand();
sum1=0;
i=1;
flag=0;
while flag==0 
    sum1=sum1+mat1(i);
    if r<=sum1
        prod=i; %The selected product
        flag=1;
    end
    i=i+1;
end
%Increase up to a maximum max_inc
max_inc = 5; % We set these values (max increase/decrease limit = seats) 
r=rand();
inc=ceil(max_inc*r);
new_limit=scenario.booking_limits(prod)+inc; 
if new_limit>180
    new_limit=180;
    inc=scenario.booking_limits(prod)-new_limit;
end
scenario.booking_limits(prod)=new_limit;
%Decrease booking limit of less profitable product 

mat1=(1-mat1);%inverse probability
mat1=mat1/sum(mat1);
r=rand();
sum1=0;
i=1;
flag=0;
while flag==0 
    sum1=sum1+mat1(i);
    if r<=sum1
        prod=i; %The selected product
        newlimit=scenario.booking_limits(i)-inc; 
        if newlimit>=0
            scenario.booking_limits(prod)=newlimit;
            flag=1;
        end
        sum1=0;
        i=0;
        r=rand();
    end
    i=i+1;
end
%Decrease by the same amount 



%Select two products with high and low value of sales/availability day and 
%increase / decrease their durations 
durations=scenario.availability_start(1:9)-avg_sold_out_time(1:9); %time counts inversely 
mat2=salesrevenues./durations;
mat2=mat2/sum(mat2);
r=rand();
sum1=0;
i=1;
flag=0;
while flag==0
    sum1=sum1+mat2(i);
    if r<=sum1
        prod=i; %The selected product
        flag=1;
    end
    i=i+1;
end

%Increase duration up to a maximum max_inc 
max_inc = 5;  % We set these values (max increase/decrease = days) 
r=rand();
inc=ceil(max_inc*r);
new_duration=durations(prod)+inc; 
if new_duration>179
    new_duration=179;
    inc=new_duration-durations(prod);
end

%randomly choose whether to move starting date or ending date 
r=rand();
if r<=0.5 && (scenario.availability_start(prod)+inc)<=179
    %move starting date 
    scenario.availability_start(prod)=scenario.availability_start(prod)+inc;
else 
    %move ending date
    scenario.availability_stop(prod)=scenario.availability_stop(prod)-inc;
end
if scenario.availability_start(prod)>179 
    scenario.availability_start(prod)=179;
    scenario.availability_stop(prod)=179-new_duration;
end
if scenario.availability_stop(prod)<0
    scenario.availability_stop(prod)=0;
    scenario.availability_start(prod)=new_duration;
end

%Decrease duration of a low revenue/avail. day product 
mat2=1-mat2; %inverse probability
r=rand();
sum1=0;
i=1;
flag=0;
while flag==0
    sum1=sum1+mat2(i);
    if r<=sum1
        prod=i; %The selected product
        new_duration=durations(prod)-inc; 
        if new_duration>0
            flag=1;
        end
        sum1=0;
        r=rand();
        i=0;
    end
    i=i+1;
end
%randomly choose whether to move starting date or ending date 
r=rand();
if r<=0.5 && (scenario.availability_start(prod)-inc)>=0
    %move starting date 
    scenario.availability_start(prod)=scenario.availability_start(prod)-inc;
else
    %move ending date
    scenario.availability_stop(prod)=scenario.availability_stop(prod)+inc;
end
if scenario.availability_start(prod)>179 
    scenario.availability_start(prod)=179;
    scenario.availability_stop(prod)=179-new_duration;
end
if scenario.availability_stop(prod)<0
    scenario.availability_stop(prod)=0;
    scenario.availability_start(prod)=new_duration;
end