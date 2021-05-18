%% Load data
% data cols -> datetime,lat,lon,depth,magnitude,timestamp,location_label
loadData;

magnitudes = [3, 4, 4.4, 4.8, 5, 5.2, 5.3];
locations = 1:15;
location_lables =  [" "];

for i = 1:size(locations,2) 
    location_lables(end+1)= "" + locations(i);
end
location_lables(:,1) = [];

%%
filterKeySet = {
    'bigger_than_magnitude' ...
    'location_label'
};
filterValueSet = {
    3 ...
    0
};
filterOptMap = containers.Map(filterKeySet,filterValueSet);

bar(magnitudes)
for k = 1:size(magnitudes,2)
    earthquake_counts = [];
    filterOptMap('bigger_than_magnitude') = magnitudes(k);
    filterOptMap('location_label') = 0;
    current_data_all_locations = filterData(data, filterOptMap);
    
    for i = 1:size(locations,2)
        filterOptMap('location_label') = locations(i);
        current_data = filterData(data, filterOptMap);
        earthquake_counts(end+1) = size(current_data,1); 
    end
    
    magnitude_str = strrep("" + magnitudes(k),".","_");
    
    % Bars
    bar(earthquake_counts)
    set(findall(gcf,'-property','FontSize'),'FontSize',18)
    ylabel("Earthquake Counts", 'FontSize', 24)
    xlabel("Location", 'FontSize', 24)
    title("Earthquake Counts by Location (Magnitudes Bigger Than " + magnitude_str + ")", 'FontSize', 24)
    saveas(gcf,"../figs/analysises/bars/Earthquake_Counts_by_Location_Magnitude_" + magnitude_str)
    saveas(gcf,"../figs/analysises/bars/Earthquake_Counts_by_Location_Magnitude_" + magnitude_str,"png")

    %Pies
    pie(earthquake_counts)
    set(findall(gcf,'-property','FontSize'),'FontSize',18)
    title("Earthquake Counts by Location (Magnitudes Bigger Than " + magnitude_str + ")", 'FontSize', 24)
    legend(location_lables)
    saveas(gcf,"../figs/analysises/pies/Earthquake_Counts_by_Location_Magnitude_" + magnitude_str + "_pie")
    saveas(gcf,"../figs/analysises/pies/Earthquake_Counts_by_Location_Magnitude_" + magnitude_str + "_pie","png")
    
    % Scatters
    scatter(current_data_all_locations(:,6),current_data_all_locations(:,5))
    magnitude_count_str = size(current_data_all_locations,1);
    ylabel("Magnitude", 'FontSize', 24)
    xlabel("Timestamp", 'FontSize', 24)
    title("Magnitude Distribution (Magnitudes Bigger Than " + magnitude_str + ", Magnitude Count: " + magnitude_count_str + ")", 'FontSize', 24)
    saveas(gcf,"../figs/analysises/scatters/" + magnitude_str + "_Magnitude_All_Location_scatter")
    saveas(gcf,"../figs/analysises/scatters/" + magnitude_str + "_Magnitude_All_Location_scatter","png")
    
end

%%
filterKeySet = {
    'bigger_than_magnitude' ...
    'bigger_than_timestamp'
};
filterValueSet = {
    3 ...
    0
};
filterOptMap = containers.Map(filterKeySet,filterValueSet);
locations = 0:15;
for i = 1:16
    filterOptMap('location_label') = locations(i);
    current_data = filterData(data, filterOptMap);

    % Scatters
    scatter(current_data(:,6),current_data(:,5))
    magnitude_count_str = size(current_data,1);
    ylabel("Magnitude", 'FontSize', 24)
    xlabel("Timestamp", 'FontSize', 24)
    title("Magnitude Distribution (Magnitudes Bigger Than 3, Magnitude Count: " + magnitude_count_str + ")", 'FontSize', 24)
    saveas(gcf,"../figs/analysises/scatters/3_Magnitude_" + i + "_Location_scatter")
    saveas(gcf,"../figs/analysises/scatters/3_Magnitude_" + i + "_Location_scatter","png")

end
%%
filterOptMap('bigger_than_magnitude') = 3.5;
for i = 1:16
    filterOptMap('location_label') = locations(i);
    current_data = filterData(data, filterOptMap);

    % Scatters
    scatter(current_data(:,6),current_data(:,5))
    magnitude_count_str = size(current_data,1);
    ylabel("Magnitude", 'FontSize', 24)
    xlabel("Timestamp", 'FontSize', 24)
    title("Magnitude Distribution (Magnitudes Bigger Than 3.5, Magnitude Count: " + magnitude_count_str + ")", 'FontSize', 24)
    saveas(gcf,"../figs/analysises/scatters/3_5_Magnitude_" + i + "_Location_scatter")
    saveas(gcf,"../figs/analysises/scatters/3_5_Magnitude_" + i + "_Location_scatter","png")

end