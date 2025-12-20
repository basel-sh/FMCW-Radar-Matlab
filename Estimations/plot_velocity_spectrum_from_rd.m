function plot_velocity_spectrum_from_rd(RD_map_dB, range_axis, velocity_axis, ...
                                        R_est, R_true, V_true, Processing_time)
% -------------------------------------------------------------
% Extracts Doppler spectrum at detected ranges
% -------------------------------------------------------------

disp('---------------- TARGET VELOCITY ESTIMATION ----------------');

figure; hold on; grid on;
xlabel('Velocity (m/s)');
ylabel('Magnitude (dB)');
title('Velocity Spectrum (from Range–Doppler FFT)');
xlim([-150 150]);

for k = 1:length(R_est)

    % Closest range bin
    [~, r_bin] = min(abs(range_axis - R_est(k)));

    % Doppler slice
    vel_slice = RD_map_dB(:, r_bin);

    % Peak velocity
    [~, idx] = max(vel_slice);
    v_est = velocity_axis(idx);

    fprintf('Target %d: R = %.2f m | V = %.2f m/s\n', k, R_est(k), v_est);

    plot(velocity_axis, vel_slice, 'LineWidth', 1.5);
    plot(v_est, vel_slice(idx), 'ro', 'MarkerFaceColor','r');

    % True velocity
    [~, id] = min(abs(R_true - R_est(k)));
    xline(V_true(id), '--g', 'HandleVisibility','off');
end

disp('------------------------------------------------------------');
fprintf('Processing Time: %.6f s\n', Processing_time);

end
