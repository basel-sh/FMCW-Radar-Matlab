function beat_targets = beat_signal_with_lpf(tx_sig, rx_targets, Fs,T_plot, N_plot, Colors)
    f_cut = 850e6;
    L = size(rx_targets,1);
    N_time = length(tx_sig);

    beat_targets = zeros(L, N_time);

   % -------- Beat Signal Generation --------
    for l = 1:L
        beat_targets(l,:) = tx_sig .* conj(rx_targets(l,:));  % Mixer
    end

    % -------- Low Pass Filter --------
    [b_lpf, a_lpf] = butter(5, f_cut/(Fs/2));
    for l = 1:L
        beat_targets(l,:) = filtfilt(b_lpf, a_lpf, beat_targets(l,:));
    end

    % -------- Plot Beat Signals --------
    for l = 1:L
        figure;
        plot(T_plot*1e6, real(beat_targets(l,1:N_plot)), ...
             'LineWidth',1.2, 'Color', Colors(l,:));
        xlabel('Time (\mus)');
        ylabel('Amplitude');
        title(['Beat Signal Z_l(t) = TX(t) · conj(RX Target ', num2str(l), ')']);
        grid on;
    end
end
