function [R_est, Processing_time] = Plot_Range_Vs_Magnitude(RD_map_dB, range_axis, R_true)

% Range spectrum
range_spectrum = max(RD_map_dB, [], 1);
figure; hold on; grid on;
plot(range_axis, range_spectrum, 'b', 'LineWidth', 1.5);
ylim([min(range_spectrum)-5, max(range_spectrum)+10]);
colors = lines(length(R_true));
R_est  = zeros(1, length(R_true));
legendText = cell(1, length(R_true) + 1);
legendText{1} = 'Range Spectrum';


for k = 1:length(R_true) % For Each Target
    % Process of Finding the Peak
    [~, c] = min(abs(range_axis - R_true(k)));
    bins = max(1,c-5):min(length(range_axis),c+5);
    [~, p] = max(range_spectrum(bins)); % For Automatic Detection of Peaks
    idx = bins(p);
    R_est(k) = range_axis(idx); % Saving Peaks

    % Ploting and Legend Details
    xline(R_true(k), '--', 'Color', colors(k,:), 'LineWidth', 1.5);
    plot(R_est(k), range_spectrum(idx), 'o','Color', colors(k,:), 'MarkerFaceColor', colors(k,:));
    text(R_est(k), range_spectrum(idx)+2, sprintf('%.2f m', R_est(k)), 'Color', colors(k,:), 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    legendText{k+1} = sprintf('Target %d: True %.1f m | Est %.2f m', k, R_true(k), R_est(k));
end

Processing_time = toc; % The End of the Required Processing Time

% Labels
xlabel('Range (m)');
ylabel('Magnitude (dB)');
title('Range Vs Magnitude');
xlim([0 300]);
legend(legendText, 'Location', 'best');

end
