function Plot_Range_Vs_Magnitude(RD_map_dB, range_axis, R_true)

% ---- Extract range spectrum ----
range_spectrum = max(RD_map_dB, [], 1);

figure; hold on; grid on;

% ---- Plot range spectrum ----
plot(range_axis, range_spectrum, 'b', ...
     'LineWidth', 1.5, ...
     'DisplayName', 'Range Spectrum');

% ---- Auto Y-axis scaling ----
y_max = max(range_spectrum);
ylim([min(range_spectrum)-5, y_max + 10]);

% ---- Colors for targets ----
colors = lines(length(R_true));

for k = 1:length(R_true) % for Each Target

    xline(R_true(k), '--', 'Color', colors(k,:), 'LineWidth', 1.8, 'HandleVisibility', 'off');

    % Find closest bin to true range
    [~, idx_center] = min(abs(range_axis - R_true(k)));

    % Local search window (±5 bins)
    search_bins = max(1, idx_center-5) : min(length(range_axis), idx_center+5);

    % Find peak
    [~, local_idx] = max(range_spectrum(search_bins));
    idx_peak = search_bins(local_idx);
    R_est = range_axis(idx_peak); % Estimated range from FFT

    % Annotate estimated range
    text(R_est, range_spectrum(idx_peak) + 2, sprintf('%.2f m', R_est), ...
         'Color', colors(k,:), ...
         'FontSize', 10, ...
         'FontWeight', 'bold', ...
         'HorizontalAlignment', 'center');
end

% Figure Details
xlabel('Range (m)');
ylabel('Magnitude (dB)');
title('Range Vs Magnitude');
xlim([0 350]);
legend('Range Spectrum', 'Location', 'best');

end
