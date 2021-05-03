%% Load data
filePath = '../data/all_earthquake_magnitude_bigger_than_4_2021_04_05_with_timestamp.csv';
opts = detectImportOptions(filePath);
preview(filePath,opts);
data = readmatrix(filePath);

% Preprocessing
backward_size = 30;
data_height = height(data);
data_width = width(data);

newCols = zeros(data_height, backward_size);
newRow = zeros(1, backward_size); 
minCol = zeros(data_height, 1);
maxCol = zeros(data_height, 1);
meanCol = zeros(data_height, 1);
medianCol = zeros(data_height, 1);
varCol = zeros(data_height, 1);
skewnessCol = zeros(data_height, 1);
kurtosisCol = zeros(data_height, 1);

for i = 1:length(data)
    % last "backward" value of the column
    newCols(i,:) = newRow;
    % some features from backward values
    if i > backward_size
        minCol(i) = min(newRow);
        maxCol(i) = max(newRow);
        meanCol(i) = mean(newRow);
        medianCol(i) = median(newRow);
        varCol(i) = var(newRow);
        skewnessCol(i) = skewness(newRow);
        kurtosisCol(i) = kurtosis(newRow);
    end
    newRow(1) = [];
    newRow(end + 1) = data(i,5);
end

data = [data newCols minCol maxCol meanCol medianCol varCol skewnessCol kurtosisCol];

%% Splite train and test
numTimeStepsTrain = height(data) - 100; %floor(0.95*numel(data));

XTrain = {data(backward_size+1:numTimeStepsTrain+1, 7:43).'};
YTrain = {data(backward_size+1:numTimeStepsTrain+1,5).'};

XTest = {data(numTimeStepsTrain+1:end, 7:43).'};
YTest = {data(numTimeStepsTrain+1:end,5).'};


%% Create model
numFeatures = size(XTrain{1},1)
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
miniBatchSize = 20;

options = trainingOptions('adam', ...
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

rmse = sqrt(mean((YPred{1}-YTest{1}).^2))

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



