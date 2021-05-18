function filtered_data = filterData(data,filterOptMap)
    %{
    keySet = {
        'bigger_than_magnitude', ...
        'location_label', ...
        'bigger_than_timestamp'
    };
    %}
    if(~isKey(filterOptMap, 'bigger_than_magnitude'))
        filterOptMap('bigger_than_magnitude') = 3;
    end
    if(~isKey(filterOptMap, 'location_label'))
        filterOptMap('location_label') = 0;
    end
    if(~isKey(filterOptMap, 'bigger_than_timestamp'))
        filterOptMap('bigger_than_timestamp') = -2186351999;
    end

    bigger_than_magnitude = filterOptMap('bigger_than_magnitude');
    location_label = filterOptMap('location_label');
    bigger_than_timestamp = filterOptMap('bigger_than_timestamp');
    
    filtered_data = zeros(1, size(data,2));
    for i = 1:length(data)
        current_magnitude = data(i,5);
        current_timestamp = data(i,6);
        current_location_label = data(i,7);
        
        if current_timestamp >= bigger_than_timestamp
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
    end
    filtered_data(1,:) = [];
end