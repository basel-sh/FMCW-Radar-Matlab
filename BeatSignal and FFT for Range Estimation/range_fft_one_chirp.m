function [BeatFFT_all, f_axis, range_processing_time] = range_fft_one_chirp(beat_targets, T_total, Tchirp, Fs)

% RANGE_FFT_ONE_CHIRP
%   Performs range FFT on one chirp (fast-time only) for each target

    %% ---- Extract one chirp ----
    idx_range = (T_total >= 0) & (T_total < Tchirp);

    %% ---- Start timer ----
    tic;

    %% ---- FFT parameters ----
    Nfft = 2^nextpow2(sum(idx_range));
    f_axis = (0:Nfft/2-1) * (Fs/Nfft);
   
    L = size(beat_targets,1);
    BeatFFT_all = zeros(L, length(f_axis));

    %% ---- FFT per target ----
    for l = 1:L
        beat_fast = beat_targets(l, idx_range);
        beat_fast = beat_fast - mean(beat_fast);
        beat_fast = beat_fast .* hann(length(beat_fast)).';

        FFT_l = abs(fft(beat_fast, Nfft));
        BeatFFT_all(l,:) = FFT_l(1:Nfft/2);
    end

    %% ---- Stop timer ----
    range_processing_time = toc;
end
