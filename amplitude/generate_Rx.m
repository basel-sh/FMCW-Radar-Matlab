% This function generates the received signal from different objects
% No Noise added in this function

function rx = generate_Rx(t_total, t_chirp, fmin, s, PRI, Nc, range, c, fD)

    L  = length(range);
    Nt = length(t_total);
    rx = zeros(L, Nt);
    Tchirp = t_chirp(end) + (t_chirp(2)-t_chirp(1));

    for l = 1:L
        RTT = 2*range(l)/c;

        for n = 0:Nc-1
            t0 = n*PRI;
            i = (t_total >= t0 + RTT) & (t_total <  t0 + RTT + Tchirp);
            t_local = t_total(i) - t0 - RTT;
            phase_rx = 2*pi*(fmin*t_local + 0.5*s*t_local.^2);
            phase_doppler = exp(1j*2*pi*fD(l)*n*PRI);
            rx(l,i) = exp(1j*phase_rx) .* phase_doppler;
        end
    end
end
