% This function prints the received signal 

function plot_Rx(t_plot, rx, N_plot, colors, SNR)

    figure; hold on;
    L = size(rx,1);

    for l = 1:L
        plot(t_plot*1e6, real(rx(l,1:N_plot)), 'LineWidth',1.2,'Color',colors(l,:));
    end

    xlabel('Time (\mus)');
    ylabel('Amplitude');
    title(['RX Signal with Noise (SNR = ', num2str(SNR),' dB)']);
    legend(arrayfun(@(x)sprintf('RX Target %d',x), 1:L,'UniformOutput',false));
    grid on;
end
