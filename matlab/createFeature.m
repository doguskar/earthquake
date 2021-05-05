%This function returns length(col)x(backward_size + 7) matrix
function newCols = createFeature(col, backward_size)
    length_of_col = length(col);

    newCols = zeros(length_of_col, backward_size);
    newRow = zeros(1, backward_size); 
    minCol = zeros(length_of_col, 1);
    maxCol = zeros(length_of_col, 1);
    meanCol = zeros(length_of_col, 1);
    medianCol = zeros(length_of_col, 1);
    varCol = zeros(length_of_col, 1);
    skewnessCol = zeros(length_of_col, 1);
    kurtosisCol = zeros(length_of_col, 1);

    for i = 1:length(col)
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
        newRow(end + 1) = col(i);
    end

    newCols = [newCols minCol maxCol meanCol medianCol varCol skewnessCol kurtosisCol];

end