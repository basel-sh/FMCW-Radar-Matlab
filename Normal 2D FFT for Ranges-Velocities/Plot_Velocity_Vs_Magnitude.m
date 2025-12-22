function Plot_Velocity_Vs_Magnitude(RD_map_dB, velocity_axis, V)

    % Compute velocity spectrum (max over range)
    velocity_spectrum = max(RD_map_dB, [], 2);
    velocity_spectrum = velocity_spectrum(:);

    figure; 
    hold on; 
    grid on;

    % Plot velocity spectrum line and store handle
    h = zeros(1, length(V)+1);  
    h(1) = plot(velocity_axis, velocity_spectrum, 'k', 'LineWidth', 1.6);

    colors = lines(length(V));

    for k = 1:length(V)
        % Find closest velocity bin
        [~, idx] = min(abs(velocity_axis - V(k)));

        % Plot marker for target and store handle
        h(k+1) = plot(V(k), velocity_spectrum(idx), 'o', 'MarkerSize', 7, 'MarkerFaceColor', colors(k,:), 'MarkerEdgeColor', colors(k,:));

        % Plot vertical line (no legend entry)
        xline(V(k), '--', 'Color', colors(k,:), 'LineWidth', 1.4);

        % Add text label
        text(V(k), velocity_spectrum(idx) + 2, sprintf('%.2f m/s', V(k)), 'Color', colors(k,:), 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    end

    % Build legend using handles
    legendText = ['Velocity Spectrum', arrayfun(@(k) sprintf('Target %d: %.2f m/s', k, V(k)), 1:length(V), 'UniformOutput', false)];
    legend(h, legendText, 'Location', 'best');

    xlabel('Velocity (m/s)');
    ylabel('Magnitude (dB)');
    title('Velocity vs Magnitude');
end
