function Plot_Velocity_Vs_Magnitude( ...
    RD_map_dB, velocity_axis, V_est)

% VELOCITY VS MAGNITUDE (USING PAIRED TARGETS ONLY)

velocity_spectrum = max(RD_map_dB, [], 2);
velocity_spectrum = velocity_spectrum(:);

figure; hold on; grid on;
plot(velocity_axis, velocity_spectrum, 'k', 'LineWidth', 1.6);

colors = lines(length(V_est));
legendText = {'Velocity Spectrum'};

for k = 1:length(V_est)

    % Find closest velocity bin
    [~, idx] = min(abs(velocity_axis - V_est(k)));

    plot(V_est(k), velocity_spectrum(idx), 'o', ...
        'MarkerSize', 7, ...
        'MarkerFaceColor', colors(k,:), ...
        'MarkerEdgeColor', colors(k,:));

    xline(V_est(k), '--', ...
        'Color', colors(k,:), ...
        'LineWidth', 1.4);

    text(V_est(k), velocity_spectrum(idx) + 2, ...
        sprintf('%.2f m/s', V_est(k)), ...
        'Color', colors(k,:), ...
        'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center');

    legendText{end+1} = ...
        sprintf('Target %d: %.2f m/s', k, V_est(k));
end

xlabel('Velocity (m/s)');
ylabel('Magnitude (dB)');
title('Velocity vs Magnitude (Paired RD Targets)');
legend(legendText, 'Location', 'best');
end