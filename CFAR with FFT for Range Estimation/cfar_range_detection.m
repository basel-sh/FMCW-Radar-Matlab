function [CFAR_th, R, f_beats, pks] = cfar_range_detection(BeatFFT_all, f_axis, c, slope, L)

    % Combine FFT magnitudes across chirps
    BeatFFT_sum = sum(BeatFFT_all, 1);
    N = length(BeatFFT_sum);

    % CFAR parameters
    Tr = 12;            % Number of training cells on each side
    Gd = 4;             % Number of guard cells on each side
    Offset_Factor = 4;  % Threshold scaling factor (CFAR offset)

    % Initialize CFAR threshold vector
    CFAR_th = zeros(1, N);

    % CFAR threshold calculation for each frequency bin
    for i = 1:N

        % Define training window limits
        i_start = max(1, i - (Tr + Gd));
        id_end  = min(N, i + (Tr + Gd));

        % Exclude guard cells around CUT (Cell Under Test)
        train_left  = BeatFFT_sum(i_start : max(i_start, i - Gd - 1));
        train_right = BeatFFT_sum(min(id_end, i + Gd + 1) : id_end);

        % Estimate noise level from training cells
        noise_mean = mean([train_left, train_right]);

        % Compute adaptive CFAR threshold
        CFAR_th(i) = noise_mean * Offset_Factor;
    end

    % Limit detection to valid beat-frequency range
    valid = (f_axis > 1e6) & (f_axis < 850e6);

    % Peak detection threshold based on maximum spectrum value
    threshold_val = 0.05 * max(BeatFFT_sum(valid));

    % Bonussssssssssssssssssssssssssssssss for Auto Detection of the Peaks
    [pks, locs_rel] = findpeaks( BeatFFT_sum(valid), 'SortStr', 'descend', 'NPeaks',  L, 'MinPeakHeight', threshold_val);

    % Convert relative indices to absolute frequency-bin indices
    locs_all = find(valid);
    locs = locs_all(locs_rel);

    % Extract beat frequencies and estimate ranges
    f_beats = f_axis(locs);
    R = (c * f_beats) / (2 * slope);

end
