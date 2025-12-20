function [RD_map_dB, range_axis, velocity_axis] = Compute_Doppler_FFT(beat_targets, T_total, Tchirp,PRI, Ts, Nc, Fs, c, fc, slope)
% -------------------------------------------------------------
% compute_range_doppler_fft
% Performs:
%   1) Fast-time FFT  → Range processing
%   2) Slow-time FFT  → Doppler (velocity) processing
% Output is the full Range–Doppler map (NO plotting)
% -------------------------------------------------------------

% ---- Active fast-time samples (inside chirp only) ----
i_range = (T_total >= 0) & (T_total < Tchirp);

% ---- Combine beat signals from all targets ----
beat_sum = sum(beat_targets, 1);

% ---- Build data cube: [chirps × fast-time] ----
N_PRI    = round(PRI / Ts);
N_active = sum(i_range);
beat_cut = beat_sum(1:Nc * N_PRI);

cube = reshape(beat_cut, N_PRI, Nc);
cube = cube(1:N_active, :).';      % [Nc × N_active]

% ---- FFT sizes ----
Nfft_r = 2^nextpow2(N_active);     % Range FFT
Nfft_d = 2^nextpow2(Nc);           % Doppler FFT

% ================= RANGE FFT (FAST TIME) =================
range_fft = fft(cube, Nfft_r, 2);
range_fft = range_fft(:, 1:Nfft_r/2);

% ================= DOPPLER FFT (SLOW TIME) =================
win = hann(Nc);
range_fft = range_fft .* win;
RD_map = fftshift(fft(range_fft, Nfft_d, 1), 1);

% ---- Axes ----
f_range = (0:Nfft_r/2-1) * Fs / Nfft_r;
range_axis = c * f_range / (2 * slope);

v_max = c / (4 * fc * PRI);
velocity_axis = linspace(-v_max, v_max, Nfft_d);

% ---- Convert to dB ----
RD_map_dB = 20 * log10(abs(RD_map));

end
