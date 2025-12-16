%% ===============================================================
%  FMCW Radar – TX & RX Instantaneous Frequency vs Time
%  Author's : Basel Shrief Hemaid , Mariam Ahmed Mohammed Ali Reda
%  Codes    : 91240202            , 91240733
%  ===============================================================

% Parameters and time axis for the Main simulation system

clear; close all; clc;

% the Folders in my Whole Project
addpath('frequency');
addpath('amplitude');
addpath('BeatSignal and FFT for Range Estimation\');
addpath('Estimations\');

% Calling Parameters Function
Parameters = radar_params();
c      = Parameters.c;
Fc     = Parameters.fc;
BW     = Parameters.BW;
Tchirp = Parameters.Tchirp;
PRI    = Parameters.PRI;
Tidle  = Parameters.Tidle;
slope  = Parameters.slope;
Ts     = Parameters.Ts;
Fs     = Parameters.Fs;
Fmin   = Parameters.fmin;
Fmax   = Parameters.fmax;
Nc     = Parameters.Nc;

Range = [50 , 250]; % Ranges  
Velocity = [-100 , 100]; % Velocities
Fdopplr = 2 * Velocity * Fc / c; % Fdoppler
L = length(Range); % Number of Detected Elements

SNR_dB = 15; % Signal to Noise Ratio

% ---------------- Time ----------------
T_PRI   = 0:Ts:PRI-Ts;
T_chirp = 0:Ts:Tchirp-Ts;
T_total = 0:Ts:(Nc*PRI - Ts);
N_time = length(T_total);
Colors = lines(L);        % Colors for targets
N_plot = min(N_time, 40000); 
T_plot = T_total(1:N_plot);

%% Frequencies
f_tx = generate_tx_frequency(Fmin, slope, T_PRI, T_chirp, Nc);
f_rx_targets = generate_rx_frequency(Fmin, slope, T_PRI, T_chirp, Range, c, Ts, Nc);
plot_tx_rx_frequency(T_plot, f_tx, f_rx_targets, N_plot, L, Colors);

%% Amplitudes
tx_sig = generate_tx_signal(T_total, T_chirp, Fmin, BW, Tchirp, PRI, Nc);
rx_targets = generate_rx_signal(T_total, T_chirp, Fmin, slope, PRI, Nc, Range, c, Fdopplr);
rx_targets = awgn(rx_targets, SNR_dB, 'measured');
plot_tx_signal(T_plot, tx_sig, N_plot);
plot_rx_signal(T_plot, rx_targets, N_plot, Colors, SNR_dB);


%% Beat Frequency with its LOW Pass Filter then
beat_targets = beat_signal_with_lpf(tx_sig, rx_targets, Fs,T_plot, N_plot, Colors);

% ================= Range FFT =================
[BeatFFT_all, f_axis, range_processing_time] = range_fft_one_chirp(beat_targets, T_total, Tchirp, Fs);
% ================= CFAR + Detection =================
[CFAR_threshold, R_est, f_beats, pks] = cfar_range_detection(BeatFFT_all, f_axis, c, slope, L);
% ================= Plot =================
plot_range_spectrum(f_axis, BeatFFT_all, f_beats, R_est, pks);

fprintf('Range Processing Time: %.6f seconds\n', range_processing_time);


%% Ranges and Velocities Estimations
plot_range_spectrum_with_cfar(BeatFFT_all, f_axis, CFAR_threshold,R_est, pks, Range, c, slope);
[RD_map_dB, range_axis, velocity_axis] = range_velocity_map_with_plot(beat_targets, T_total, Tchirp, PRI, Ts, Nc, Fs, c, Fc, slope);
doppler_spectrum_with_summary(abs(RD_map_dB), range_axis, velocity_axis,R_est, Range, Velocity, range_processing_time);
