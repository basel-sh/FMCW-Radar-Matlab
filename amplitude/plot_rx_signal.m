function plot_rx_signal( ...
    t_plot, rx_targets, N_plot, colors, target_SNR_dB)

% PLOT_RX_SIGNAL  RX FMCW signal (REAL PART only)

    figure; hold on;
    L = size(rx_targets,1);

    for l = 1:L
        plot(t_plot*1e6, real(rx_targets(l,1:N_plot)), ...
            'LineWidth',1.2,'Color',colors(l,:));
    end

    xlabel('Time (\mus)');
    ylabel('Amplitude');
    title(['RX FMCW Signal (Real Part) with Noise (SNR = ', ...
           num2str(target_SNR_dB),' dB)']);
    legend(arrayfun(@(x)sprintf('RX Target %d',x), ...
           1:L,'UniformOutput',false));
    grid on;
end
