% This function applies a low-pass filter to the beat signal
% and plots the filtered beat signals for each target

function Beat_signal_filt = Beat_lpf(Beat_signal, Fs, T_plot, N_plot, Colors)

    fcut = 850e6;                 % LPF cutoff frequency
    L = size(Beat_signal, 1);

    Beat_signal_filt = zeros(size(Beat_signal));

    % -------- Low Pass Filter --------
    [b_lpf, a_lpf] = butter(5, fcut / (Fs/2));

    for l = 1:L
        Beat_signal_filt(l, :) = filtfilt(b_lpf, a_lpf, Beat_signal(l, :));
    end

    % -------- Plot filtered beat signals --------
    for l = 1:L
        figure;
        plot(T_plot * 1e6, real(Beat_signal_filt(l, 1:N_plot)), ...
             'LineWidth', 1.2, ...
             'Color', Colors(l, :));

        xlabel('Time (\mus)');
        ylabel('Amplitude');
        title(['Beat Signal for target (', num2str(l), ')']);
        grid on;
    end

end
