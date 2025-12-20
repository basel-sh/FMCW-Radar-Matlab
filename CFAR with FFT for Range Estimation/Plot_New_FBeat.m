% This function plots the beak frequencies of each target with a cursor
% showing the estimated range for each corresponding target

function Plot_New_FBeat(f_axis, FFT_beat, f_beats, R, pks)

    BeatFFT_sum = sum(FFT_beat, 1);

    figure;
    plot(f_axis/1e6, BeatFFT_sum, 'k', 'LineWidth', 2);
    hold on; grid on;

    xlabel('Frequency (MHz)');
    ylabel('Magnitude');
    title('Beat Frequency using CFAR for Range Detection from Noise');

    for k = 1:length(f_beats)
        xline(f_beats(k)/1e6, '--r', 'LineWidth', 1.5);
        text(f_beats(k)/1e6, pks(k), sprintf('  %.2f m', R(k)), 'Color','r', 'FontSize',10, 'VerticalAlignment','bottom');
    end
end
