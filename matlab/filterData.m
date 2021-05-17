function filtered_data = filterData(data,bigger_than_magnitude,location_label)
    filtered_data = zeros(1, size(data,2));
    for i = 1:length(data)
        current_magnitude = data(i,5);
        current_location_label = data(i,7);
        
        if current_magnitude >= bigger_than_magnitude
            if location_label >= 1 && location_label <= 15
                if current_location_label == location_label 
                    filtered_data(end+1,:) = data(i,:);
                end
            else
                filtered_data(end+1,:) = data(i,:);
            end
        end
    end
    filtered_data(1,:) = [];
end