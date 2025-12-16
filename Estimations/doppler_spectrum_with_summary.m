function doppler_spectrum_with_summary( ...
    RD_map, range_axis, velocity_axis, ...
    R_est, R_true, v_true, range_processing_time)

disp(' ');
disp('---------------- TARGET DETECTION SUMMARY ----------------');

Ndet = numel(R_est);
if Ndet < numel(R_true)
    disp('Warning: Some targets were not detected.');
end

figure; hold on; grid on;
title('Doppler Spectrum (Detected Targets)');
xlabel('Velocity (m/s)');
ylabel('Magnitude (dB)');
xlim([-150 150]);

for k = 1:Ndet
    % Closest range bin
    [~, r_bin] = min(abs(range_axis - R_est(k)));

    % Doppler slice (LINEAR)
    doppler_slice = abs(RD_map(:, r_bin));

    % Velocity estimate
    [~, d_bin] = max(doppler_slice);
    v_est = velocity_axis(d_bin);

    % Print summary
    fprintf('Target %d: R = %.2f m, V = %.2f m/s\n', ...
            k, R_est(k), v_est);

    % Plot spectrum
    plot(velocity_axis, 20*log10(doppler_slice), ...
        'LineWidth', 1.5, ...
        'DisplayName', sprintf('R = %.1f m', R_est(k)));

    % Mark detected velocity
    plot(v_est, 20*log10(doppler_slice(d_bin)), ...
        'ro', 'MarkerFaceColor','r');

    % Mark true velocity
    [~, idx] = min(abs(R_true - R_est(k)));
    xline(v_true(idx), '--g', 'HandleVisibility','off');
end

legend show;
hold off;

disp('----------------------------------------------------------');
fprintf('Range Processing Time: %.6f s\n', range_processing_time);
disp('----------------------------------------------------------');
end
