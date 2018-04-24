function neighbours = generate_neighbours(solution)

neighbours = zeros(length(solution)-1,length(solution));
for i = 2:length(solution)
    neighbour = solution;
    neighbour(i) = solution(i-1);
    neighbour(i-1) = solution(i);
    neighbours(i-1,:) = neighbour;
end