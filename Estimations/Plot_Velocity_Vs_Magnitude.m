function Plot_Velocity_Vs_Magnitude(RD_map_dB, range_axis, velocity_axis, R_est, R_true, V_true, Processing_time)

disp('---------------- Target Velocity Estimation ----------------');

% The Figure
figure; hold on; grid on;
xlabel('Velocity (m/s)');
ylabel('Magnitude (dB)');
title('Velocity Vs Magnitude');
xlim([-150 150]);


colors = lines(length(R_est)); % Colors for each target 


global_max = -inf; % Store max magnitude for Y-axis scaling

for k = 1:length(R_est) % Each Target

    
    [~, r_bin] = min(abs(range_axis - R_est(k))); % Find closest range bin
    vel_slice = RD_map_dB(:, r_bin);  % Doppler slice at this range as the Doctor Explained

    
    [~, idx] = max(vel_slice); % Peak detection (velocity estimate)
    v_est = velocity_axis(idx);
    fprintf('Target %d: R = %.2f m | V = %.2f m/s\n', k, R_est(k), v_est); % Printing the Results

    % Plot Doppler spectrum
    plot(velocity_axis, vel_slice, 'LineWidth', 1.5, 'Color', colors(k,:), 'DisplayName', sprintf('Target @ %.1f m', R_est(k)));

    % Mark detected velocity peak
    plot(v_est, vel_slice(idx), 'o', 'Color', colors(k,:), 'MarkerFaceColor', colors(k,:));

    % Annotate estimated velocity
    text(v_est, vel_slice(idx) + 2, sprintf('%.1f m/s', v_est), ...
         'Color', colors(k,:), ...
         'FontSize', 10, ...
         'FontWeight', 'bold', ...
         'HorizontalAlignment', 'center');

    % True velocity reference (vertical line) So that we cann see it
    [~, id] = min(abs(R_true - R_est(k)));
    xline(V_true(id), '--', ...
          'Color', colors(k,:), ...
          'LineWidth', 1.5, ...
          'HandleVisibility', 'off');

    % Track maximum magnitude So I can limit the y-axis Automaticly in Plot
    global_max = max(global_max, max(vel_slice));
end

% ---- Auto Y-axis scaling ----
ylim([min(vel_slice)-5, global_max + 10]);

legend('Location', 'best');

disp('------------------------------------------------------------');
fprintf('Processing Time: %.6f s\n', Processing_time);

end
