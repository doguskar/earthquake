%% Load data and splite train and test
data = readmatrix('../data/6_earthquake_magnitude_bigger_than_4_2021_04_05_extended.csv')

numTimeStepsTrain = height(data) - 50; %floor(0.95*numel(data));

XTrain = {data(31:numTimeStepsTrain+1, 6:11).'};%[2:4 6:29 end] [4 6:17]
YTrain = {data(31:numTimeStepsTrain+1,5).'};

XTest = {data(numTimeStepsTrain+1:end, 6:11).'};
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


maxEpochs = 200;
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



