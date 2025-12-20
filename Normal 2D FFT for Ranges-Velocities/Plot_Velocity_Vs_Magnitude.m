function V_est = Plot_Velocity_Vs_Magnitude(RD_map_dB, velocity_axis)

velocity_spectrum = max(RD_map_dB, [], 2);
velocity_spectrum = velocity_spectrum(:);

% Ploting the Graph
figure; hold on; grid on;
plot(velocity_axis, velocity_spectrum, 'k', 'LineWidth', 1.6, 'DisplayName', 'Velocity Spectrum');

%Process of Finding the Peak Automaticly and Exporting it to the main file
minPeakProm = 6;
[pks, locs] = findpeaks(velocity_spectrum, 'MinPeakProminence', minPeakProm, 'MinPeakDistance', round(length(velocity_axis)/20));
V_est = velocity_axis(locs);
colors = lines(length(V_est));

for k = 1:length(V_est) % Plot For Each Target 
    xline(V_est(k), '--', 'Color', colors(k,:), 'LineWidth', 1.8, 'DisplayName', sprintf('Peak %d: %.2f m/s', k, V_est(k)));
    plot(V_est(k), pks(k), 'o', 'Color', colors(k,:), 'MarkerFaceColor', colors(k,:), 'MarkerSize', 7, 'HandleVisibility','off');
    text(V_est(k), pks(k) + 2, sprintf('%.2f m/s', V_est(k)), 'Color', colors(k,:), 'FontSize', 10, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
end

% the Labels
xlabel('Velocity (m/s)');
ylabel('Magnitude (dB)');
title('Velocity Vs Magnitude');
ylim([min(velocity_spectrum)-5, max(velocity_spectrum)+12]); % Automatic Limit for the Y-axis Magnitude
legend('Location','best');

end
