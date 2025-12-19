% This function generates the beat signal that results from mixing the
% transmitted signal with the conjugate of the received signal
% Then uses low pass filter as an anti-aliasing filter

function Beat_signal = Beat_lpf(tx, rx, Fs,T_plot, N_plot, Colors)

    fcut = 850e6;
    L = size(rx,1);
    N_time = length(tx);
    Beat_signal = zeros(L, N_time);

    % Mixer
    for l = 1:L
        Beat_signal(l,:) = tx .* conj(rx(l,:));  
    end

    % Low Pass Filter (LPF)
    [b_lpf, a_lpf] = butter(5, fcut/(Fs/2));
    for l = 1:L
        Beat_signal(l,:) = filtfilt(b_lpf, a_lpf, Beat_signal(l,:));
    end

    % Plot Beat Signals of each target
    for l = 1:L
        figure;
        plot(T_plot*1e6, real(Beat_signal(l,1:N_plot)), ...
             'LineWidth',1.2, 'Color', Colors(l,:));
        xlabel('Time (\mus)');
        ylabel('Amplitude');
        title(['Beat Signal Z_l(t) = TX(t) · conj(RX Target ', num2str(l), ')']);
        grid on;
    end
end
