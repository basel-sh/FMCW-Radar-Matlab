
% This functions applies CFAR and estimates the range of each target
% by detecting the peaks 

function [CFAR_th, R_est, f_beats, pks] = cfar_range_detection(BeatFFT_all, f_axis, c, slope, L)

    BeatFFT_sum = sum(BeatFFT_all, 1);
    N = length(BeatFFT_sum);

    % CFAR parameters
    Tr = 12;
    Gd = 4;
    Offset_Factor = 4;

    CFAR_th = zeros(1, N);

    for i = 1:N
        i_start = max(1, i - (Tr+Gd));
        id_end   = min(N, i + (Tr+Gd));

        train_left  = BeatFFT_sum(i_start : max(i_start, i-Gd-1));
        train_right = BeatFFT_sum(min(id_end, i+Gd+1) : id_end);

        noise_mean = mean([train_left, train_right]);
        CFAR_th(i) = noise_mean * Offset_Factor;
    end

    
    % Peak detection
    valid = (f_axis > 1e6) & (f_axis < 950e6);
    threshold_val = 0.05 * max(BeatFFT_sum(valid));

    [pks, locs_rel] = findpeaks(BeatFFT_sum(valid), 'SortStr','descend', 'NPeaks', L, 'MinPeakHeight', threshold_val);

    locs_all = find(valid);
    locs = locs_all(locs_rel);

    f_beats = f_axis(locs);
    R_est = (c * f_beats) / (2 * slope);
end
