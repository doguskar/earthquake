function new_time_col = createDiffHourCol(timestamp_col)
    new_time_col = zeros(1,1);
    for i = 2:size(timestamp_col,1)
        prv = timestamp_col(i-1);
        curr = timestamp_col(i);
        diff_hour = (curr - prv)/60/60;
        new_time_col(end+1,:) = diff_hour;
    end
end