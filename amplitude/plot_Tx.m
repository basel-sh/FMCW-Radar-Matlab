function plot_Tx(t_plot, tx_sig, N_plot)

% PLOT_TX_SIGNAL  TX FMCW amplitude

    figure;
    plot(t_plot*1e6, real(tx_sig(1:N_plot)), 'b');
    xlabel('Time (\mus)');
    ylabel('Amplitude');
    title('TX Signal');
    grid on;
end
