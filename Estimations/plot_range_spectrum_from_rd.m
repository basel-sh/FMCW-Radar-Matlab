function plot_range_spectrum_from_rd(RD_map_dB, range_axis, R_true)
% -------------------------------------------------------------
% Extracts Range spectrum from Range–Doppler map
% Uses MAX over Doppler axis
% -------------------------------------------------------------

range_spectrum = max(RD_map_dB, [], 1);

figure;
plot(range_axis, range_spectrum, 'b', 'LineWidth', 1.5);
grid on; hold on;

for k = 1:length(R_true)
    xline(R_true(k), '--k', 'HandleVisibility','off');
end

xlabel('Range (m)');
ylabel('Magnitude (dB)');
title('Range Spectrum (from Range–Doppler FFT)');
xlim([0 350]);

end
