function tx_sig = generate_tx_signal( ...
    t_total, t_chirp, fmin, BW, Tchirp, PRI, Nc)

% GENERATE_TX_SIGNAL  TX FMCW complex signal

    tx_sig = zeros(size(t_total));
    slope = BW / Tchirp;

    for n = 0:Nc-1
        t0 = n * PRI;
        idx = (t_total >= t0) & (t_total < t0 + Tchirp);
        t_local = t_total(idx) - t0;

        tx_sig(idx) = exp(1j*2*pi * ...
            (fmin*t_local + 0.5*slope*t_local.^2));
    end
end
