% Plotting the the transmitted frequency and the received frequency 
% without doppler effect

function plot_frequency(t_plot, f_tx, f_rx, N_plot, L, colors)

    figure; hold on;
    plot(t_plot*1e6, f_tx(1:N_plot)/1e9, 'k', 'LineWidth', 2);

    for l = 1:L
        plot(t_plot*1e6, f_rx(l,1:N_plot)/1e9, 'LineWidth', 2, 'Color', colors(l,:));
    end

    xlabel('Time (\mus)');
    ylabel('Frequency (GHz)');
    title('TX and RX Frequencies');
    legend(['TX', arrayfun(@(x)sprintf('RX Target %d',x), 1:L,'UniformOutput',false)]);
    ylim([75 78]);
    grid on;
end
