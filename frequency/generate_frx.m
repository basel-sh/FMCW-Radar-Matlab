% This function generates the transmitted frequency, 
% but without doppler effect for simplicity and clarification
function f_rx = generate_frx(fmin, s, t_pri, t_chirp, range, c, Ts, Nc)
    L = length(range);
    f_rx_pri = fmin * ones(L, length(t_pri));

    for l = 1:L  % For Each Target
        delay_samp = round((2*range(l)/c) / Ts);  % The Delay Time 2R/c  / Ts for the Sampling
        f_rx_pri(l, delay_samp + (1:length(t_chirp))) = fmin + s*t_chirp;
    end

    f_rx = repmat(f_rx_pri, 1, Nc);
end
