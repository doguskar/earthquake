function filtered_data = filterData(data)
    filtered_data = zeros(1, width(data));
    for i = 1:length(data)
        current_magnitude = data(i,5);
        current_location_label = data(i,7);
        
        if current_magnitude >= 4 && current_location_label == 6
            filtered_data(end+1,:) = data(i,:);
        end
    end
    filtered_data(1,:) = [];
end