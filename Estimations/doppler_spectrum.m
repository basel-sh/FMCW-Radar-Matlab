function doppler_spectrum(RD_map, range_axis, velocity_axis, R, range, velocity, Processing_time)

disp(' ');
disp('---------------- TARGET DETECTION SUMMARY ----------------');

Ndet = numel(R);
if Ndet < numel(range)
    disp('Warning: Some targets were not detected.');
end

figure; hold on; grid on;
title('Doppler Spectrum');
xlabel('Velocity (m/s)');
ylabel('Magnitude (dB)');
xlim([-150 150]);

for k = 1:Ndet
    
    [~, r_bin] = min(abs(range_axis - R(k)));       % Closest range bin
    doppler_slice = abs(RD_map(:, r_bin));          % Doppler slice (LINEAR)

    % Velocity estimate
    [~, d_bin] = max(doppler_slice);
    v_est = velocity_axis(d_bin);

    fprintf('Target %d: R = %.2f m, V = %.2f m/s\n', k, R(k), v_est);       % Display the estimated velocities and ranges for each target

    plot(velocity_axis, 20*log10(doppler_slice), 'LineWidth', 1.5, 'DisplayName', sprintf('R = %.1f m', R(k)));     % Plot spectrum

    plot(v_est, 20*log10(doppler_slice(d_bin)), 'ro', 'MarkerFaceColor','r');       % Mark detected velocity

    % Mark true velocity
    [~, idx] = min(abs(range - R(k)));
    xline(velocity(idx), '--g', 'HandleVisibility','off');
end

legend show;
hold off;

disp('----------------------------------------------------------');
fprintf('Range Processing Time: %.6f s\n', Processing_time);
disp('----------------------------------------------------------');
end
