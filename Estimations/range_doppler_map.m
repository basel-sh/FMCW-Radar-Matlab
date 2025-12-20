% This function builds and plots the range-doppler map

function [RD_map_dB, range_axis, velocity_axis] = range_doppler_map(beat_targets, T_total, Tchirp, PRI, Ts, Nc, Fs, c, fc, slope)
    
    i_range = (T_total >= 0) & (T_total < Tchirp);       % Extracting active fast-time samples
    beat_sum_all = sum(beat_targets, 1);                 % Sum beat signals over targets

    % Reshaping into data cube
    N_PRI        = round(PRI / Ts);
    N_Active     = sum(i_range);
    expected_len = Nc * N_PRI;

    beat_cut = beat_sum_all(1:expected_len);
    Matrix_PRI = reshape(beat_cut, [N_PRI, Nc]);
    Matrix_Active = Matrix_PRI(1:N_Active, :);
    data_cube = Matrix_Active.';                         % Nc × N_Active

    % FFT sizes
    Nfft_r = 2^nextpow2(N_Active);
    Nfft_d = 2^nextpow2(Nc);

    % Range FFT 
    Range_FFT_Map = fft(data_cube, Nfft_r, 2);
    Range_FFT_Map = Range_FFT_Map(:, 1:Nfft_r/2);

    % Doppler FFT
    win_doppler = hann(Nc);
    Range_FFT_Map_Windowed = Range_FFT_Map .* win_doppler;
    RD_map = fftshift(fft(Range_FFT_Map_Windowed, Nfft_d, 1), 1);

    % Axes
    f_range = (0:Nfft_r/2-1) * (Fs / Nfft_r);
    range_axis = c * f_range / (2 * slope);

    v_max = c / (4 * fc * PRI);     % correct Doppler limit
    velocity_axis = linspace(-v_max, v_max, Nfft_d);

    % Convert to dB
    RD_map_dB = 20 * log10(abs(RD_map));
    max_val = max(RD_map_dB(:));

    figure;
    imagesc(range_axis, velocity_axis, RD_map_dB);
    axis xy;
    colormap jet;
    colorbar;
    clim([max_val-60, max_val]);

    xlabel('Range (m)');
    ylabel('Velocity (m/s)');
    title('Range–Doppler Map');
end
