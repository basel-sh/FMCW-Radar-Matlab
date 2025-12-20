% This function generates the transmitted signal

function tx = generate_Tx(t_total, fmin, BW, Tchirp, PRI, Nc)

    tx = zeros(size(t_total));
    slope = BW / Tchirp;

    for n = 0:Nc-1   % For Each Chirp
        t0 = n * PRI;
        i = (t_total >= t0) & (t_total < t0 + Tchirp);
        t_local = t_total(i) - t0;
        tx(i) = exp(1j*2*pi*(fmin*t_local + 0.5*slope*t_local.^2));
    end
end
