function Processing_time = Plot_Range_Vs_Magnitude( ...
    RD_map_dB, range_axis, R_est)

% RANGE VS MAGNITUDE (USING PAIRED TARGETS ONLY)

range_spectrum = max(RD_map_dB, [], 1);

figure; hold on; grid on;
plot(range_axis, range_spectrum, 'k', 'LineWidth', 1.6);

colors = lines(length(R_est));
legendText = {'Range Spectrum'};

for k = 1:length(R_est)

    % Find closest range bin
    [~, idx] = min(abs(range_axis - R_est(k)));

    plot(R_est(k), range_spectrum(idx), 'o', ...
        'MarkerSize', 7, ...
        'MarkerFaceColor', colors(k,:), ...
        'MarkerEdgeColor', colors(k,:));

    xline(R_est(k), '--', ...
        'Color', colors(k,:), ...
        'LineWidth', 1.4);

    text(R_est(k), range_spectrum(idx) + 2, ...
        sprintf('%.2f m', R_est(k)), ...
        'Color', colors(k,:), ...
        'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center');

    legendText{end+1} = ...
        sprintf('Target %d: %.2f m', k, R_est(k));
end

xlabel('Range (m)');
ylabel('Magnitude (dB)');
title('Range vs Magnitude (Paired RD Targets)');
xlim([0 300]);
legend(legendText, 'Location', 'best');

Processing_time = toc;
end