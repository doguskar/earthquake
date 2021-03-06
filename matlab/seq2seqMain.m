%% Prepare
keySet = {
    'str' ...
    'max_epochs'...
    'backward_size'
};
valueSet = {
    "str" ...
    1000 ...
    30
};
optMap = containers.Map(keySet,valueSet);

magnitude_ls = [4 5];
optMap('location_label') = 6;
backward_size = optMap('backward_size');

%Column rages
magnitude_start     =   9;  
magnitude_end       =   magnitude_start     + backward_size + 6;
depth_start         =   magnitude_end       + 1;
depth_end           =   depth_start         + backward_size + 6;
timestamp_start     =   depth_end           + 1;
timestamp_end       =   timestamp_start     + backward_size + 6;
lat_start           =   timestamp_end       + 1;
lat_end             =   lat_start           + backward_size + 6;
lon_start           =   lat_end             + 1;
lon_end             =   lon_start           + backward_size + 6;

bar(magnitude_ls);


%% Test
%{
optMap('bigger_than_magnitude') = 3;
optMap('max_epochs') = 1;
optMap('feature_columns') = magnitude_start:magnitude_end;
seq2seqFunc(optMap);
%}

%% Predict Magnitude
%{
optMap('wanted_columns') = 5;
optMap('wanted_columns_str') = "mag";
optMap('location_label') = 6;

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    for x=1:1
        %magnitude
        optMap('feature_columns') = magnitude_start:magnitude_end;
        optMap('feature_columns_str') = "mag";
        seq2seqFunc(optMap);

        %magnitude & depth
        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_dep";
        seq2seqFunc(optMap);

        %magnitude & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_tim";
        seq2seqFunc(optMap);

        %magnitude & depth & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_dep_tim";
        seq2seqFunc(optMap);

        %magnitude & lat & lon
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "mag_lat_lon";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & depth
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_tim";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & depth & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
        seq2seqFunc(optMap);
    end
end
%}
%% Predict Timestamp
%{
optMap('wanted_columns') = 6;
optMap('wanted_columns_str') = "tim";

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    for x=1:1
        %timestamp
        optMap('feature_columns') = timestamp_start:timestamp_end;
        optMap('feature_columns_str') = "tim";
        seq2seqFunc(optMap);

        %timestamp & magnitude
        optMap('feature_columns') = [timestamp_start:timestamp_end magnitude_start:magnitude_end];
        optMap('feature_columns_str') = "mag_tim";
        seq2seqFunc(optMap);

        %timestamp & depth
        optMap('feature_columns') = [timestamp_start:timestamp_end depth_start:depth_end];
        optMap('feature_columns_str') = "dep_tim";
        seq2seqFunc(optMap);

        %timestamp & magnitude & depth
        optMap('feature_columns') = [timestamp_start:timestamp_end magnitude_start:magnitude_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_dep_tim";
        seq2seqFunc(optMap);

        %timestamp & lat & lon
        optMap('feature_columns') = [timestamp_start:timestamp_end lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "lat_lon_tim";
        seq2seqFunc(optMap);

        %timestamp & magnitude & depth & lat & lon
        optMap('feature_columns') = [timestamp_start:timestamp_end magnitude_start:magnitude_end depth_start:depth_end lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
        seq2seqFunc(optMap);
    end
end
%}
%% Predict Hour Difference
%{
optMap('wanted_columns') = 8;
optMap('wanted_columns_str') = "hou";
optMap('location_label') = 6;

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    for x=1:1
        %timestamp
        optMap('feature_columns') = timestamp_start:timestamp_end;
        optMap('feature_columns_str') = "tim";
        seq2seqFunc(optMap);

        %timestamp & magnitude
        optMap('feature_columns') = [timestamp_start:timestamp_end magnitude_start:magnitude_end];
        optMap('feature_columns_str') = "mag_tim";
        seq2seqFunc(optMap);

        %timestamp & depth
        optMap('feature_columns') = [timestamp_start:timestamp_end depth_start:depth_end];
        optMap('feature_columns_str') = "dep_tim";
        seq2seqFunc(optMap);

        %timestamp & magnitude & depth
        optMap('feature_columns') = [timestamp_start:timestamp_end magnitude_start:magnitude_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_dep_tim";
        seq2seqFunc(optMap);

        %timestamp & lat & lon
        optMap('feature_columns') = [timestamp_start:timestamp_end lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "lat_lon_tim";
        seq2seqFunc(optMap);

        %timestamp & magnitude & depth & lat & lon
        optMap('feature_columns') = [timestamp_start:timestamp_end magnitude_start:magnitude_end depth_start:depth_end lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
        seq2seqFunc(optMap);
    end
end
%}
%% Predict lat and lonx
%{
optMap('wanted_columns') = [2 3];
optMap('wanted_columns_str') = "lat_lon";
optMap('wanted_colums_names') = ["Latitude", "Longitude"];
optMap('location_label') = 0;

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    for x=1:1
        %lat & lon
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "lat_lon";
        seq2seqFunc(optMap);

        %lat & lon & magnitude
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end];
        optMap('feature_columns_str') = "mag_lat_lon";
        seq2seqFunc(optMap);

        %lat & lon & depth
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end depth_start:depth_end];
        optMap('feature_columns_str') = "lat_lon_dep";
        seq2seqFunc(optMap);

        %lat & lon & magnitude & depth
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep";
        seq2seqFunc(optMap);

        %lat & lon & magnitude & timestamp
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_tim";
        seq2seqFunc(optMap);

        %lat & lon & depth & timestamp
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "lat_lon_dep_tim";
        seq2seqFunc(optMap);

        %lat & lon & magnitude & depth & timestamp
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
        seq2seqFunc(optMap);
    end
end
%}
%% Predict loc
%{
optMap('wanted_columns') = 7;
optMap('wanted_columns_str') = "loc";
optMap('location_label') = 0;

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    for x=1:1
        %lat & lon
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "lat_lon";
        seq2seqFunc(optMap);

        %lat & lon & magnitude
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end];
        optMap('feature_columns_str') = "mag_lat_lon";
        seq2seqFunc(optMap);

        %lat & lon & depth
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end depth_start:depth_end];
        optMap('feature_columns_str') = "lat_lon_dep";
        seq2seqFunc(optMap);

        %lat & lon & magnitude & depth
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep";
        seq2seqFunc(optMap);

        %lat & lon & magnitude & timestamp
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_tim";
        seq2seqFunc(optMap);

        %lat & lon & depth & timestamp
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "lat_lon_dep_tim";
        seq2seqFunc(optMap);

        %lat & lon & magnitude & depth & timestamp
        optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
        seq2seqFunc(optMap);
    end
end
%}
%% Predict Magnitude and Timestamp
%{
optMap('wanted_columns') = [5 6];
optMap('wanted_columns_str') = "mag_tim";
optMap('wanted_colums_names') = ["Magnitude", "Timestamp"];
optMap('location_label') = 6;

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    for x=1:1
        %magnitude
        optMap('feature_columns') = magnitude_start:magnitude_end;
        optMap('feature_columns_str') = "mag";
        seq2seqFunc(optMap);

        %magnitude & depth
        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_dep";
        seq2seqFunc(optMap);

        %magnitude & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_tim";
        seq2seqFunc(optMap);

        %magnitude & depth & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_dep_tim";
        seq2seqFunc(optMap);

        %magnitude & lat & lon
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "mag_lat_lon";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & depth
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_tim";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & depth & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
        seq2seqFunc(optMap);
    end
end
%}

%% Predict Magnitude and Hour Differece
%{
optMap('wanted_columns') = [5 8];
optMap('wanted_columns_str') = "mag_hou";
optMap('wanted_colums_names') = ["Magnitude", "Hour Difference"];
optMap('location_label') = 6;

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    for x=1:1
        %magnitude
        optMap('feature_columns') = magnitude_start:magnitude_end;
        optMap('feature_columns_str') = "mag";
        seq2seqFunc(optMap);

        %magnitude & depth
        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_dep";
        seq2seqFunc(optMap);

        %magnitude & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_tim";
        seq2seqFunc(optMap);

        %magnitude & depth & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_dep_tim";
        seq2seqFunc(optMap);

        %magnitude & lat & lon
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "mag_lat_lon";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & depth
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_tim";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & depth & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
        seq2seqFunc(optMap);
    end
end
%}
%% Predict Magnitude and Location label
%{
optMap('wanted_columns') = [5 7];
optMap('wanted_columns_str') = "mag_loc";
optMap('wanted_colums_names') = ["Magnitude", "Location Label"];
optMap('location_label') = 0;

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    for x=1:1
        %magnitude
        optMap('feature_columns') = magnitude_start:magnitude_end;
        optMap('feature_columns_str') = "mag";
        seq2seqFunc(optMap);

        %magnitude & depth
        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_dep";
        seq2seqFunc(optMap);

        %magnitude & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_tim";
        seq2seqFunc(optMap);

        %magnitude & depth & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_dep_tim";
        seq2seqFunc(optMap);

        %magnitude & lat & lon
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end];
        optMap('feature_columns_str') = "mag_lat_lon";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & depth
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_tim";
        seq2seqFunc(optMap);

        %magnitude & lat & lon & depth & timestamp
        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
        seq2seqFunc(optMap);
    end
end
%}

%% Predict loc

optMap('wanted_columns') = 7;
optMap('wanted_columns_str') = "loc";
optMap('location_label') = 0;
magnitude_ls = [5 5.3];                           %[5 5.3];
bacward_ls = 30;                            %[20 30 50 100];                    30 BEST
batch_ls = 100;                             %[10 20 50 100 100000];             100 BEST               
learn_ls = 0.05;                            %[0.1 0.01 0.05 0.001 ];            0.01 BEST

for magnitude = 1:size(magnitude_ls,2)
    for bacward = 1:size(bacward_ls,2)
        for batch = 1:size(batch_ls,2)
            for learn = 1:size(learn_ls ,2)
                
                backward_size = bacward_ls(bacward);
                
                %Column rages
                magnitude_start     =   9;  
                magnitude_end       =   magnitude_start     + backward_size + 6;
                depth_start         =   magnitude_end       + 1;
                depth_end           =   depth_start         + backward_size + 6;
                timestamp_start     =   depth_end           + 1;
                timestamp_end       =   timestamp_start     + backward_size + 6;
                lat_start           =   timestamp_end       + 1;
                lat_end             =   lat_start           + backward_size + 6;
                lon_start           =   lat_end             + 1;
                lon_end             =   lon_start           + backward_size + 6;
                
                
                optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
                optMap('backward_size') = bacward_ls(bacward);
                optMap('mini_batch_size') = batch_ls(batch);
                optMap('initial_learn_rate') = learn_ls(learn);

                for x=1:5
                    %{
                    %lat & lon & magnitude & timestamp
                    optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end timestamp_start:timestamp_end];
                    optMap('feature_columns_str') = "mag_lat_lon_tim";
                    seq2seqFunc(optMap);
                    %}
                    %lat & lon & magnitude & depth & timestamp
                    optMap('feature_columns') = [lat_start:lat_end lon_start:lon_end magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
                    optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
                    seq2seqFunc(optMap);
                end
            end
        end
    end
end
%{%}


%% Predict Magnitude
%{
optMap('wanted_columns') = 5;
optMap('wanted_columns_str') = "mag";
%optMap('location_label') = 1:15;

magnitude_ls = [4.4 5 5.3];                           %[4 5 5.3];
bacward_ls = 30;                       %[20 30 50 100];                 20 AND 30   20 BETTER 
batch_ls = 100;                             %[10 20 50 100 100000];          100 BEST
learn_ls = 0.01;                            %[20 30 50 100];                 0.01 BEST
location_ls = 0;

for location = 1:size(location_ls,2)
    for magnitude = 1:size(magnitude_ls,2)
        for bacward = 1:size(bacward_ls,2)
            for batch = 1:size(batch_ls,2)
                for learn = 1:size(learn_ls ,2)
                    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
                    optMap('backward_size') = bacward_ls(bacward);
                    optMap('mini_batch_size') = batch_ls(batch);
                    optMap('initial_learn_rate') = learn_ls(learn);
                    optMap('location_label') = location_ls(location);




                    backward_size = bacward_ls(bacward);

                    %Column rages
                    magnitude_start     =   9;  
                    magnitude_end       =   magnitude_start     + backward_size + 6;
                    depth_start         =   magnitude_end       + 1;
                    depth_end           =   depth_start         + backward_size + 6;
                    timestamp_start     =   depth_end           + 1;
                    timestamp_end       =   timestamp_start     + backward_size + 6;
                    lat_start           =   timestamp_end       + 1;
                    lat_end             =   lat_start           + backward_size + 6;
                    lon_start           =   lat_end             + 1;
                    lon_end             =   lon_start           + backward_size + 6;



                    for x=1:5
                        %{
                        %magnitude & depth
                        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end];
                        optMap('feature_columns_str') = "mag_dep";
                        seq2seqFunc(optMap);
                        %}
                        %magnitude & depth & timestamp
                        optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
                        optMap('feature_columns_str') = "mag_dep_tim";
                        seq2seqFunc(optMap);
                         %{   
                        %magnitude & lat & lon & depth & timestamp
                        optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
                        optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
                        seq2seqFunc(optMap);
                        %}
                    end
                end
            end
        end
    end
end
%}
%% Predict Magnitude and Location label
%{

for magnitude = 1:size(magnitude_ls,2)
    optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
    
end
%}
optMap('wanted_columns') = [5 7];
optMap('wanted_columns_str') = "mag_loc";
optMap('wanted_colums_names') = ["Magnitude", "Location Label"];
optMap('location_label') = 0;

magnitude_ls = 5;                           %[5 5.3];
bacward_ls = [30 40];                       %[20 30 50 100];                % 30 AND 40, 30 BETTER
batch_ls = 100;                             %[10 20 50 100 100000];
learn_ls = 0.01;                            %[20 30 50 100];

for magnitude = 1:size(magnitude_ls,2)
    for bacward = 1:size(bacward_ls,2)
        for batch = 1:size(batch_ls,2)
            for learn = 1:size(learn_ls ,2)
                optMap('bigger_than_magnitude') = magnitude_ls(magnitude);
                optMap('backward_size') = bacward_ls(bacward);
                optMap('mini_batch_size') = batch_ls(batch);
                optMap('initial_learn_rate') = learn_ls(learn);
                
                
                
                
                backward_size = bacward_ls(bacward);
                
                %Column rages
                magnitude_start     =   9;  
                magnitude_end       =   magnitude_start     + backward_size + 6;
                depth_start         =   magnitude_end       + 1;
                depth_end           =   depth_start         + backward_size + 6;
                timestamp_start     =   depth_end           + 1;
                timestamp_end       =   timestamp_start     + backward_size + 6;
                lat_start           =   timestamp_end       + 1;
                lat_end             =   lat_start           + backward_size + 6;
                lon_start           =   lat_end             + 1;
                lon_end             =   lon_start           + backward_size + 6;
                

                for x=1:5
                    %{
                    %magnitude
                    optMap('feature_columns') = magnitude_start:magnitude_end;
                    optMap('feature_columns_str') = "mag";
                    seq2seqFunc(optMap);
                    %}
                    %magnitude & depth & timestamp
                    optMap('feature_columns') = [magnitude_start:magnitude_end depth_start:depth_end timestamp_start:timestamp_end];
                    optMap('feature_columns_str') = "mag_dep_tim";
                    seq2seqFunc(optMap);

                    %magnitude & lat & lon & depth
                    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end];
                    optMap('feature_columns_str') = "mag_lat_lon_dep";
                    seq2seqFunc(optMap);

                    %magnitude & lat & lon & depth & timestamp
                    optMap('feature_columns') = [magnitude_start:magnitude_end lat_start:lat_end lon_start:lon_end depth_start:depth_end timestamp_start:timestamp_end];
                    optMap('feature_columns_str') = "mag_lat_lon_dep_tim";
                    seq2seqFunc(optMap);
                end
            end
        end
    end
end

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

magnitude_ls = [4 4.4 4.8 5 5.2 5.3];
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
