% This function generates the beat signal by mixing
% the transmitted signal with the conjugate of the received signal

function Z_t = Beat_mixer(tx, rx, L)

    Nt = length(tx);      % Signal length

    Z_t = zeros(L, Nt);   % Initializing 

    % Mixer (Mixes the transmitted signal and the received signal to get the frequency difference that represents the beat and doppler frequencies)
    for l = 1:L
        Z_t(l, :) = tx .* conj(rx(l, :));
    end

end
