function Plot_Range_Vs_Magnitude(RD_map_dB, range_axis, R)

    % Compute range spectrum (max over Doppler)
    range_spectrum = max(RD_map_dB, [], 1);

    figure; 
    hold on; 
    grid on;

    % Plot range spectrum line and store handle
    h = zeros(1, length(R)+1);  
    h(1) = plot(range_axis, range_spectrum, 'k', 'LineWidth', 1.6);

    colors = lines(length(R));

    for k = 1:length(R)
        % Find closest range bin
        [~, idx] = min(abs(range_axis - R(k)));

        % Plot marker for target and store handle
        h(k+1) = plot(R(k), range_spectrum(idx), 'o', 'MarkerSize', 7, 'MarkerFaceColor', colors(k,:), 'MarkerEdgeColor', colors(k,:));

        % Plot vertical line (no legend entry)
        xline(R(k), '--', 'Color', colors(k,:), 'LineWidth', 1.4);

        % Add text label
        text(R(k), range_spectrum(idx) + 2, sprintf('%.2f m', R(k)), 'Color', colors(k,:), 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    end

    % Build legend using handles
    legendText = ['Range Spectrum', arrayfun(@(k) sprintf('Target %d: %.2f m', k, R(k)), 1:length(R), 'UniformOutput', false)];
    legend(h, legendText, 'Location', 'best');

    xlabel('Range (m)');
    ylabel('Magnitude (dB)');
    title('Range vs Magnitude');
    xlim([0 max(range_axis)]);
end
