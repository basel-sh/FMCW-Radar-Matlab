% This function generates the beat signal by mixing
% the transmitted signal with the conjugate of the received signal

function Beat_signal = Beat_mixer(tx, rx)

    L = size(rx, 1);          % Number of targets
    N_time = length(tx);      % Signal length

    Beat_signal = zeros(L, N_time);

    % Mixer (Mixes the transmitted signal and the received signal to get the frequency difference that represents the beat and doppler frequencies)
    for l = 1:L
        Beat_signal(l, :) = tx .* conj(rx(l, :));
    end

end
