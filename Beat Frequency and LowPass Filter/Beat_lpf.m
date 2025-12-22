% This function applies a low-pass filter to the beat signal
% and plots the filtered beat signals for each target

function Beat_signal_filter = Beat_lpf(Beat_signal, Fs, T_plot, N_plot, Colors, L)

    fcut = 950e6; % LPF cutoff frequency

    Beat_signal_filter = zeros(size(Beat_signal));  %initializing

    % Low Pass Filter (LPF) working as Anti-Aliasing filter
    [b_lpf, a_lpf] = butter(5, fcut / (Fs/2));

    for l = 1:L
        Beat_signal_filter(l, :) = filtfilt(b_lpf, a_lpf, Beat_signal(l, :));
        figure;
        plot(T_plot * 1e6, real(Beat_signal_filter(l, 1:N_plot)), 'LineWidth', 1.2, 'Color', Colors(l, :));
        xlabel('Time (\mus)');
        ylabel('Amplitude');
        title(['Beat Signal for target (', num2str(l), ')']);
        grid on;
    end
end
