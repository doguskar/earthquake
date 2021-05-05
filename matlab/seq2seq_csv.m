%% Load data
% data cols -> datetime,lat,lon,depth,magnitude,timestamp,location_label

filePath = '../data/earthquakes_2021_05_05_with_timestamp_and_location_label.csv';
opts = detectImportOptions(filePath);
preview(filePath,opts);
data = readmatrix(filePath);

% Filter data
data = filterData(data);
% Preprocessing
backward_size = 30;

newMagnitudeCols = createFeature(data(:,5), backward_size);     % 8                             ->  8 + backward_size + 7
newDepthCols = createFeature(data(:,4), backward_size);         % 9 + backward_size + 7         ->  9 + 2x(backward_size + 7)
newTimestampCols = createFeature(data(:,6), backward_size);     % 10 + 2x(backward_size + 7)     ->  10 + 3x(backward_size + 7)
newLatCols = createFeature(data(:,2), backward_size);
newLonCols = createFeature(data(:,3), backward_size);

data = [data newMagnitudeCols newDepthCols newTimestampCols newLatCols newLonCols];

%% Splite train and test
numTimeStepsTrain = length(data) - 50; %floor(0.95*numel(data));

featureColumns = [8:44 45:81];
wantedColumns = [5 4];

XTrain = {data(backward_size+1:numTimeStepsTrain+1, featureColumns).'};
YTrain = {data(backward_size+1:numTimeStepsTrain+1, wantedColumns).'};

XTest = {data(numTimeStepsTrain+1:end, featureColumns).'};
YTest = {data(numTimeStepsTrain+1:end, wantedColumns).'};

%{
mu = mean([XTrain{:}],2);
sig = std([XTrain{:}],0,2);

for i = 1:numel(XTrain)
    XTrain{i} = (XTrain{i} - mu) ./ sig;
end

mu = mean([XTest{:}],2);
sig = std([XTest{:}],0,2);

for i = 1:numel(XTest)
    XTest{i} = (XTest{i} - mu) ./ sig;
end
%}

%% Create model
numFeatures = size(XTrain{1},1);
numResponses = size(YTrain{1},1);
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    fullyConnectedLayer(50)
    dropoutLayer(0.5)
    fullyConnectedLayer(numResponses)
    regressionLayer];


maxEpochs = 500;
miniBatchSize = 100;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','auto', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',0.01, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Plots','training-progress',...
    'Verbose',0);

%% Train
net = trainNetwork(XTrain,YTrain,layers,options);

%% Predict
YPred = predict(net,XTest,'MiniBatchSize',1);

%% Show result
YTestMagnitude = YTest{1}(1,:);
YPredMagnitude = YPred{1}(1,:);
YPredDepth = YPred{1}(2,:);
YTestDepth = YTest{1}(2,:);

rmseMagnitude = sqrt(mean((YPredMagnitude-YTestMagnitude).^2));
rmseDepth = sqrt(mean((YPredDepth-YTestDepth).^2));

figure
subplot(2,2,1)
plot(YTestMagnitude)
hold on
plot(YPredMagnitude,'.-')
hold off
legend(["Observed" "Forecast"])
ylabel("Magnitude")
title("Forecast")

subplot(2,2,2)
plot(YTestDepth)
hold on
plot(YPredDepth,'.-')
hold off
legend(["Observed" "Forecast"])
ylabel("Depth")
title("Forecast")

subplot(2,2,3)
stem(YPredMagnitude -YTestMagnitude)
xlabel("Days")
ylabel("Error")
title("Magnitude RMSE = " + rmseMagnitude)

subplot(2,2,4)
stem(YPredDepth - YTestDepth)
xlabel("Days")
ylabel("Error")
title("Depth RMSE = " + rmseDepth)


%{
rmse = sqrt(mean((YPred{1}-YTest{1}).^2));

figure
subplot(2,1,1)
plot(YTest{1})
hold on
plot(YPred{1},'.-')
hold off
legend(["Observed" "Forecast"])
ylabel("Earthquakes")
title("Forecast")

subplot(2,1,2)
stem(YPred{1} - YTest{1})
xlabel("Days")
ylabel("Error")
title("RMSE = " + rmse)
%}




