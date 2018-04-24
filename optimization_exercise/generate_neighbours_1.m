function neighbours = generate_neighbours_1(solution)

l = length(solution);

neighbours = zeros(l-1,l);
for i = 2:l
    neighbour = solution;
    idx1 = ceil(rand()*l);
    idx2 = ceil(rand()*l);
    while idx2 == idx1
        idx2 = ceil(rand()*l);
    end
    neighbour(idx1:idx2) = fliplr(neighbour(idx1:idx2));
    neighbours(i-1,:) = neighbour;
end