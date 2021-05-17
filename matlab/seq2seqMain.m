%% Predict Magnitude
keySet = {
    'str' ...
    'max_epochs'...
    'backward_size'
};
valueSet = {
    "str" ...
    1 ...
    30
};
optMap = containers.Map(keySet,valueSet);

magnitude_ls = [4 5];

optMap('location_label') = 6;
backward_size = optMap('backward_size');

magnitude_start     =   8;
magnitude_end       =   magnitude_start     + backward_size + 6;
depth_start         =   magnitude_end       + 1;
depth_end           =   depth_start         + backward_size + 6;
timestamp_start     =   depth_end           + 1;
timestamp_end       =   timestamp_start     + backward_size + 6;
lat_start           =   timestamp_end       + 1;
lat_end             =   lat_start           + backward_size + 6;
lon_start           =   lat_end             + 1;
lon_end             =   lon_start           + backward_size + 6;

%magnitude
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    optMap('location_label') = 6;

    seq2seqFunc(optMap);
end
%magnitude & depth
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end];
    
    seq2seqFunc(optMap);
end
%magnitude & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & depth & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & depth
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & depth & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%% Predict Timestamp
%{
keySet = {
    'str' ...
    'max_epochs'...
    'backward_size' ...
    'wanted_columns'
};
valueSet = {
    "str" ...
    1 ...
    30 ...
    6
};
optMap = containers.Map(keySet,valueSet);

magnitude_ls = [4 5];

optMap('location_label') = 6;
backward_size = optMap('backward_size');

magnitude_start     =   8;
magnitude_end       =   magnitude_start     + backward_size + 6;
depth_start         =   magnitude_end       + 1;
depth_end           =   depth_start         + backward_size + 6;
timestamp_start     =   depth_end           + 1;
timestamp_end       =   timestamp_start     + backward_size + 6;
lat_start           =   timestamp_end       + 1;
lat_end             =   lat_start           + backward_size + 6;
lon_start           =   lat_end             + 1;
lon_end             =   lon_start           + backward_size + 6;

%magnitude
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    optMap('location_label') = 6;

    seq2seqFunc(optMap);
end
%magnitude & depth
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end];
    
    seq2seqFunc(optMap);
end
%magnitude & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & depth & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & depth
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & depth & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%}
%% Predict lat and lon
%{
keySet = {
    'str' ...
    'max_epochs'...
    'backward_size' ...
    'wanted_columns' ...
    'wanted_colums_names'
};
valueSet = {
    "str" ...
    1 ...
    30 ...
    [2 3] ... 
    ["Latitude", "Longitude"]
};
optMap = containers.Map(keySet,valueSet);

magnitude_ls = [4 5];

optMap('location_label') = 6;
backward_size = optMap('backward_size');

magnitude_start     =   8;
magnitude_end       =   magnitude_start     + backward_size + 6;
depth_start         =   magnitude_end       + 1;
depth_end           =   depth_start         + backward_size + 6;
timestamp_start     =   depth_end           + 1;
timestamp_end       =   timestamp_start     + backward_size + 6;
lat_start           =   timestamp_end       + 1;
lat_end             =   lat_start           + backward_size + 6;
lon_start           =   lat_end             + 1;
lon_end             =   lon_start           + backward_size + 6;

%magnitude
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    optMap('location_label') = 6;

    seq2seqFunc(optMap);
end
%magnitude & depth
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end];
    
    seq2seqFunc(optMap);
end
%magnitude & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & depth & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & depth
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%magnitude & lat & lon & depth & timestamp
for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
    
    seq2seqFunc(optMap);
end
%}
%%
%{
keySet = {
    'str' ...
    'max_epochs'
};
valueSet = {
    "str" ...
    1000
};
optMap = containers.Map(keySet,valueSet);

magnitude_ls = [3 4 4.4 4.8 5 5.2 5.3];
location_ls = 1:15;
bacward_ls = [20 30 50 100];
batch_ls = [10 20 50 100 100000];
learn_ls = [0.01 0.001];

for magnitude = 1:size(magnitude_ls,2)
    for location = 1:size(location_ls,2)
        for bacward = 1:size(bacward_ls,2)
           for batch = 1:size(batch_ls,2)
                for learn = 1:size(learn_ls ,2)
                    optMap('bigger_than_magnitude') = magnitude;
                    optMap('location_label') = location;
                    optMap('backward_size') = bacward;
                    optMap('mini_batch_size') = batch;
                    optMap('initial_learn_rate') = learn;
                    
                    seq2seqFunc(optMap);
                end
            end 
        end
    end
end
%}
