function [RD_map_dB, range_axis, velocity_axis] = Compute_Doppler_FFT(beat_targets, T_total, Tchirp, PRI, Ts, Nc, Fs, c, fc, s)

tic;    % Start timer for range estimation processing time 

i_range = (T_total >= 0) & (T_total < Tchirp); % Active fast-time samples (inside chirp only)
beat_sum = sum(beat_targets, 1);               % Combine beat signals from all targets

% Build data Cube: [chirps × fast-time], That Array in The Doctor's Lecture
N_PRI    = round(PRI / Ts);
N_active = sum(i_range);
beat_cut = beat_sum(1:Nc * N_PRI);
cube = reshape(beat_cut, N_PRI, Nc);
cube = cube(1:N_active, :).';      % [Nc × N_active]

% FFT sizes
Nfft_r = 2^nextpow2(N_active);     % Range FFT
Nfft_d = 2^nextpow2(Nc);           % Doppler FFT

% RANGE FFT (FAST TIME)
range_fft = fft(cube, Nfft_r, 2);
range_fft = range_fft(:, 1:Nfft_r/2);

% DOPPLER FFT (SLOW TIME)
win = hann(Nc);
range_fft = range_fft .* win;
RD_map = fftshift(fft(range_fft, Nfft_d, 1), 1);

% Axes
f_range = (0:Nfft_r/2-1) * Fs / Nfft_r;
range_axis = c * f_range / (2 * s);
v_max = c / (4 * fc * PRI);
velocity_axis = linspace(v_max, -v_max, Nfft_d);
RD_map_dB = 20 * log10(abs(RD_map));    % Converting to dB

end
