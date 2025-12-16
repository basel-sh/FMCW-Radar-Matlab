function f_rx_targets = generate_rx_frequency( ...
    fmin, slope, t_pri, t_chirp, R_true, c, Ts, Nc)

% GENERATE_RX_FREQUENCY  RX instantaneous frequency per target (with delay)

    L = length(R_true);
    f_rx_pri = fmin * ones(L, length(t_pri));

    for l = 1:L
        delay_samp = round((2*R_true(l)/c) / Ts);
        f_rx_pri(l, delay_samp + (1:length(t_chirp))) = ...
            fmin + slope*t_chirp;
    end

    f_rx_targets = repmat(f_rx_pri, 1, Nc);
end
