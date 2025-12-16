function plot_range_spectrum( ...
    f_axis, BeatFFT_all, f_beats, R_est, pks)

% PLOT_RANGE_SPECTRUM
%   Plots combined beat spectrum and detected ranges

    BeatFFT_sum = sum(BeatFFT_all, 1);

    figure;
    plot(f_axis/1e6, BeatFFT_sum, 'k', 'LineWidth', 2);
    hold on; grid on;

    xlabel('Frequency (MHz)');
    ylabel('Magnitude');
    title('Combined Beat Frequency Spectrum (All Targets)');

    for k = 1:length(f_beats)
        xline(f_beats(k)/1e6, '--r', 'LineWidth', 1.5);
        text(f_beats(k)/1e6, pks(k), ...
            sprintf('  %.2f m', R_est(k)), ...
            'Color','r', ...
            'FontSize',10, ...
            'VerticalAlignment','bottom');
    end
end
