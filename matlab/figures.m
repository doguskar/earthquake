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
bar(magnitudes)
for k = 1:size(magnitudes,2)
    earthquake_counts = [];
    current_data_all_locations = filterData(data, magnitudes(k), -1);
    for i = 1:size(locations,2)
        current_data = filterData(data, magnitudes(k), locations(i));
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
keySet = {'Jan','Feb','Mar','Apr'};
valueSet = {327.2 368.2 197.6 "asdas"};
M = containers.Map(keySet,valueSet);
if ~isKey(M,'test')
    disp('yes')
end
if isKey(M,'Jan')
    disp(M("Jan"))
end
%%

keySet = {'Jan','Feb','Mar','Apr'};
valueSet = {327.2 368.2 197.6 "asdas"};
optMap = containers.Map(keySet,valueSet);

optMap('wanted_colums_names') = ["Earthquake", "Time", "Latitude", "Longitude"];
wanted_colums_names = optMap('wanted_colums_names')
disp(wanted_colums_names(1))
%%

test = 5;

test(1)

test(end)



