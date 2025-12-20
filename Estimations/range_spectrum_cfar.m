%   This funcion plots range spectrum with CFAR threshold and detected peaks

function range_spectrum_cfar(BeatFFT_all, f_axis, CFAR_threshold, R, pks, R_true, c, slope)

    BeatFFT_sum = sum(BeatFFT_all, 1);      % Combining  FFT

    range_axis_fft = (c * f_axis) / (2 * slope);
    
    figure;
    plot(range_axis_fft, BeatFFT_sum, 'b', 'LineWidth', 1.5); 
    hold on; grid on;

    plot(range_axis_fft, CFAR_threshold, 'g--', 'LineWidth', 1.5);
    
    xlabel('Range (m)');
    ylabel('Magnitude');
    title('Range Spectrum with CFAR Noise Analysis (Bonus 1 & 2)');
    xlim([0 350]);

    plot(R, pks, 'ro', 'MarkerFaceColor','r', 'DisplayName','Detected Peak');       % Detected Peaks
    
    for i = 1:length(R_true)
        xline(R_true(i), '--k', 'LineWidth', 1.5, 'Label', sprintf('True %.2f m', R_true(i)), 'HandleVisibility','off');
    end

    legend('Signal Magnitude', 'CFAR Noise Threshold', 'Detected Peaks (findpeaks)');
end
