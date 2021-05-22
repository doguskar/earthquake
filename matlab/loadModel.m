file_name = "2021-05-21_20-17-42-527_5_3_Mag_0_Loc_30_Bac_0_Tes_mag_dep_tim_Fea_mag_Wan_true_Nor_200_Hid_1000_Epo_100_Bat_0_01_Lea.mat";
load("../figs/experiments/models/" + file_name);

%% Predict
YPred = predict(net,XTest,'MiniBatchSize',1);

%% Show result
%saved_file_path = "../figs/experiments/";

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

%saveas(gcf, saved_file_path + "figs/" + saved_file_name)
%saveas(gcf,  saved_file_path + saved_file_name, "png")
    