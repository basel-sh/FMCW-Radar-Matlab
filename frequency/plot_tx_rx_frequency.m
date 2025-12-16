function plot_tx_rx_frequency( ...
    t_plot, f_tx, f_rx_targets, N_plot, L, colors)

% PLOT_TX_RX_FREQUENCY  Plot TX & RX instantaneous frequency

    figure; hold on;
    plot(t_plot*1e6, f_tx(1:N_plot)/1e9, 'k', 'LineWidth', 2);

    for l = 1:L
        plot(t_plot*1e6, f_rx_targets(l,1:N_plot)/1e9, ...
            'LineWidth', 2, 'Color', colors(l,:));
    end

    xlabel('Time (\mus)');
    ylabel('Frequency (GHz)');
    title('TX and RX FMCW Instantaneous Frequency (Zoomed)');
    legend(['TX', arrayfun(@(x)sprintf('RX Target %d',x), ...
           1:L,'UniformOutput',false)]);
    ylim([75 78]);
    grid on;
end
