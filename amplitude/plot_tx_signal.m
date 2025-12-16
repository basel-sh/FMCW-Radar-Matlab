function plot_tx_signal(t_plot, tx_sig, N_plot)

% PLOT_TX_SIGNAL  TX FMCW amplitude

    figure;
    plot(t_plot*1e6, real(tx_sig(1:N_plot)), 'b');
    xlabel('Time (\mus)');
    ylabel('Amplitude');
    title('TX FMCW Signal (Amplitude vs Time)');
    grid on;
end
