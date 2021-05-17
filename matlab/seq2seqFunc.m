function seq2seqFunc = seq2seqFunc(optMap)
    %% Paramaters
    %{
    keySet = {
        'bigger_than_magnitude', ...
        'location_label', ...
        'backward_size', ...
        'test_size', ...
        'feature_columns', ...
        'wanted_columns', ...
        'normalized', ...
        'num_hidden_units', ...
        'max_epochs', ...
        'mini_batch_size', ...
        'initial_learn_rate', ...
        'wanted_colums_names', ...
    };
    %}
    %Default Values
    if(~isKey(optMap, 'bigger_than_magnitude'))
        optMap('bigger_than_magnitude') = 3;
    end
    if(~isKey(optMap, 'location_label'))
        optMap('location_label') = 0;
    end
    if(~isKey(optMap, 'backward_size'))
        optMap('backward_size') = 30;
    end
    if(~isKey(optMap, 'test_size'))
        optMap('test_size') = 0;
    end
    if(~isKey(optMap, 'feature_columns'))
        backward_size = optMap('backward_size');
        featureEndColumn = 8 + backward_size + 7;
        optMap('feature_columns') = 8:featureEndColumn;
    end
    if(~isKey(optMap, 'wanted_columns'))
        optMap('wanted_columns') = 5;
    end
    if(~isKey(optMap, 'normalized'))
        optMap('normalized') = true;
    end
    if(~isKey(optMap, 'num_hidden_units'))
        optMap('num_hidden_units') = 200;
    end
    if(~isKey(optMap, 'max_epochs'))
        optMap('max_epochs') = 200;
    end
    if(~isKey(optMap, 'mini_batch_size'))
        optMap('mini_batch_size') = 100;
    end
    if(~isKey(optMap, 'initial_learn_rate'))
        optMap('initial_learn_rate') = 0.01;
    end
    if(~isKey(optMap, 'plot_type'))
        optMap('plot_type') = 1;
    end
    if(~isKey(optMap, 'wanted_colums_names'))
        optMap('wanted_colums_names') = ["Magnitude", "Date Time", "Latitude", "Longitude"];
    end
    

    %% Load data
    % data cols -> datetime,lat,lon,depth,magnitude,timestamp,location_label
    loadData;

    % Filter data
    bigger_than_magnitude = optMap('bigger_than_magnitude');
    location_label = optMap('location_label'); %declare -1 for all locations 
    data = filterData(data, bigger_than_magnitude, location_label);

    % Preprocessing
    backward_size = optMap('backward_size');

    newMagnitudeCols = createFeature(data(:,5), backward_size);     % 8                             ->  8 + backward_size + 6
    newDepthCols = createFeature(data(:,4), backward_size);         % 9 + backward_size + 7         ->  9 + 2x(backward_size + 6)
    newTimestampCols = createFeature(data(:,6), backward_size);     % 10 + 2x(backward_size + 7)     ->  10 + 3x(backward_size + 6)
    newLatCols = createFeature(data(:,2), backward_size);
    newLonCols = createFeature(data(:,3), backward_size);
    %{
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
    %}
    data = [data newMagnitudeCols newDepthCols newTimestampCols newLatCols newLonCols];

    %% Splite train and test
    test_size = optMap('test_size');
    if test_size <= 0
        if length(data) <= 100
            test_size = 5;
        elseif length(data) <= 200
            test_size = 10;
        elseif length(data) <= 5000
            test_size = 25;
        else
            test_size = 50;
        end
    end
    numTimeStepsTrain = size(data, 1) - test_size;
    
    if size(data, 1) < 100
        return;
    end
    if numTimeStepsTrain < backward_size
        return;
    end

    featureColumns = optMap('feature_columns');
    wantedColumns = optMap('wanted_columns');

    XTrain = {data(backward_size+1:numTimeStepsTrain, featureColumns).'};
    YTrain = {data(backward_size+1:numTimeStepsTrain, wantedColumns).'};

    XTest = {data(numTimeStepsTrain+1:end, featureColumns).'};
    YTest = {data(numTimeStepsTrain+1:end, wantedColumns).'};
    
    if optMap('normalized')
        % Standardize data
        mu = mean([XTrain{:}],2);
        sig = std([XTrain{:}],0,2);

        for i = 1:numel(XTrain)
            XTrain{i} = (XTrain{i} - mu) ./ sig;
        end

        for i = 1:numel(XTest)
            XTest{i} = (XTest{i} - mu) ./ sig;
        end
    end


    %% Create model
    numFeatures = size(XTrain{1},1);
    numResponses = size(YTrain{1},1);
    numHiddenUnits = optMap('num_hidden_units');

    layers = [ ...
        sequenceInputLayer(numFeatures)
        lstmLayer(numHiddenUnits,'OutputMode','sequence')
        fullyConnectedLayer(50)
        dropoutLayer(0.5)
        fullyConnectedLayer(numResponses)
        regressionLayer];


    maxEpochs = optMap('max_epochs');
    miniBatchSize = optMap('mini_batch_size');
    initialLearnRate = optMap('initial_learn_rate');

    options = trainingOptions('adam', ...
        'ExecutionEnvironment','auto', ...
        'MaxEpochs',maxEpochs, ...
        'MiniBatchSize',miniBatchSize, ...
        'InitialLearnRate',initialLearnRate, ...
        'GradientThreshold',1, ...
        'Shuffle','never', ...
        'Verbose',0);
    %'Plots','training-progress',...

    %% Train
    net = trainNetwork(XTrain,YTrain,layers,options);

    %% Predict
    YPred = predict(net,XTest,'MiniBatchSize',1);

    %% Show result
    learn_rate_str = strrep("" + optMap('initial_learn_rate'), ".", "_");
    fig_file_name = optMap('bigger_than_magnitude') + "_Mag_" + ...
        optMap('location_label') + "_Loc_" + ...
        optMap('backward_size') + "_Bac_" + ...
        optMap('test_size') + "_Tes_" + ...
        featureColumns(1) + "_" + featureColumns(end) + "_Fea_" + ...
        wantedColumns(1) + "_" + wantedColumns(end) + "_Wan_" + ...
        optMap('normalized') + "_Nor_" + ...
        optMap('num_hidden_units') + "_Hid_" + ...
        optMap('max_epochs') + "_Epo_" + ...
        optMap('mini_batch_size') + "_Bat_" + ...
        learn_rate_str + "_Lea_" + ...
        datestr(datetime('now'),'yyyy-mm-dd_HH-MM-SS-FFF');
    fig_file_path = "../figs/experiments/";
    
    wanted_colums_names = optMap('wanted_colums_names');
    
    if size(YTest{1},1) == 1
        
        YTestRow1= YTest{1};
        YPredRow1 = YPred{1};
        
        rmse = sqrt(mean((YPredRow1-YTestRow1).^2));

        subplot(2,1,1)
        plot(YTestRow1)
        hold on
        plot(YPredRow1,'.-')
        set(findall(gcf,'-property','FontSize'),'FontSize',18)
        hold off
        legend(["Observed" "Forecast"])
        ylabel(wanted_colums_names(1))
        title("Forecast")

        subplot(2,1,2)
        stem(YPredRow1 - YTestRow1)
        set(findall(gcf,'-property','FontSize'),'FontSize',18)
        xlabel("Last Eartquakes")
        ylabel("Error")
        title("RMSE = " + rmse)
        
    elseif size(YTest{1},1) == 2
        YTestRow1 = YTest{1}(1,:);
        YPredRow1 = YPred{1}(1,:);
        YTestRow2 = YTest{1}(2,:);
        YPredRow2 = YPred{1}(2,:);

        rmseRow1 = sqrt(mean((YPredRow1-YTestRow1).^2));
        rmseRow2= sqrt(mean((YPredRow2-YTestRow2).^2));

        subplot(2,2,1)
        plot(YTestRow1)
        set(findall(gcf,'-property','FontSize'),'FontSize',18)
        hold on
        plot(YPredRow1,'.-')
        hold off
        legend(["Observed" "Forecast"])
        ylabel(wanted_colums_names(1))
        title("Forecast")
        
        subplot(2,2,3)
        stem(YPredRow1 -YTestRow1)
        set(findall(gcf,'-property','FontSize'),'FontSize',18)
        xlabel("Last Eartquakes")
        ylabel("Error")
        title(wanted_colums_names(1) + " RMSE = " + rmseRow1)

        subplot(2,2,2)
        plot(YTestRow2)
        set(findall(gcf,'-property','FontSize'),'FontSize',18)
        hold on
        plot(YPredRow2,'.-')
        hold off
        legend(["Observed" "Forecast"])
        ylabel(wanted_colums_names(2))
        title("Forecast")

        subplot(2,2,4)
        stem(YPredRow2 - YTestRow2)
        set(findall(gcf,'-property','FontSize'),'FontSize',18)
        xlabel("Last Eartquakes")
        ylabel("Error")
        title(wanted_colums_names(2) + " RMSE = " + rmseRow2) 
    end
    
    saveas(gcf, fig_file_path + "figs/" + fig_file_name)
    saveas(gcf,  fig_file_path + fig_file_name, "png")
    

    


    
    
    

end