function f_tx = generate_tx_frequency(fmin, slope, t_pri, t_chirp, Nc)
% GENERATE_TX_FREQUENCY  TX instantaneous frequency (with idle)

    f_tx_pri = fmin * ones(size(t_pri));
    f_tx_pri(1:length(t_chirp)) = fmin + slope*t_chirp;

    f_tx = repmat(f_tx_pri, 1, Nc);
end
