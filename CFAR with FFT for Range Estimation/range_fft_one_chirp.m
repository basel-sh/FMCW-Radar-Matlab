%   This function performs FFT on one chirp (fast-time  FFT) for each
%   target to obtain the beat-frequency needed for range estimation

function [FFT_beat, f_axis] = range_fft_one_chirp(Beat_signal, T_total, Tchirp, Fs, L)

    i = (T_total >= 0) & (T_total < Tchirp); % Extracting one chirp


    % FFT parameters
    Nfft = 2^nextpow2(sum(i));
    f_axis = (0:Nfft/2-1) * (Fs/Nfft);
    FFT_beat = zeros(L, length(f_axis));

    % Applying FFT for each target
    for l = 1:L
        beat_fast = Beat_signal(l, i);
        beat_fast = beat_fast - mean(beat_fast);
        beat_fast = beat_fast .* hann(length(beat_fast)).';
        FFT_l = abs(fft(beat_fast, Nfft));
        FFT_beat(l,:) = FFT_l(1:Nfft/2);
    end
end
