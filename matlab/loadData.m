% data cols -> datetime,lat,lon,depth,magnitude,timestamp,location_label
filePath = '../data/earthquakes_2021_05_05_with_timestamp_and_location_label.csv';
dataOpts = detectImportOptions(filePath);
dataPreview = preview(filePath,dataOpts);
data = readmatrix(filePath);