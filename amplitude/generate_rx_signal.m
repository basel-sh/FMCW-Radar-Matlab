function rx_targets = generate_rx_signal( ...
    t_total, t_chirp, fmin, slope, PRI, Nc, ...
    R_true, c, fD_true)

% GENERATE_RX_SIGNAL  RX FMCW signal per target

    L  = length(R_true);
    Nt = length(t_total);
    rx_targets = zeros(L, Nt);

    Tchirp = t_chirp(end) + (t_chirp(2)-t_chirp(1));

    for l = 1:L
        Rtt = 2*R_true(l)/c;

        for n = 0:Nc-1
            t0 = n*PRI;
            idx = (t_total >= t0 + Rtt) & ...
                  (t_total <  t0 + Rtt + Tchirp);

            t_local = t_total(idx) - t0 - Rtt;

            phase_rx = 2*pi * ...
                (fmin*t_local + 0.5*slope*t_local.^2);

            phase_doppler = exp(1j*2*pi*fD_true(l)*n*PRI);

            rx_targets(l,idx) = exp(1j*phase_rx) .* phase_doppler;
        end
    end
end
