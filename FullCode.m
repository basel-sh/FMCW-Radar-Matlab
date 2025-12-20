% FMCW Radar Project
% Team : Basel Shrief Hemaid , Mariam Ahmed Mohammed Ali Reda
% Codes: 91240202            , 91240733

%% Project

clear; close all; clc;

% Project Folders
addpath('frequency');
addpath('amplitude');
addpath('BeatSignal and FFT for Range Estimation\');
addpath('Estimations\');

% Radar parameters
Parameters = radar_params();
c      = Parameters.c;      % Speed of Light
Fc     = Parameters.fc;     % Carrier Frequency 
BW     = Parameters.BW;     % Band Width
Tchirp = Parameters.Tchirp; % Chirp Time
PRI    = Parameters.PRI;    % Pulse Repetition Interval
Tidle  = Parameters.Tidle;  % Idle Time
s      = Parameters.slope;  % Slope
Ts     = Parameters.Ts;     % Sampling Time
Fs     = Parameters.Fs;     % Sampling Frequency (1/Ts)
Fmin   = Parameters.fmin;   % Minimum Frequency
Fmax   = Parameters.fmax;   % Maximum Frequency
Nc     = Parameters.Nc;     % Number of Chirps

%% Target Scenario

Range = [50 , 250];                 % Ranges  
Velocity = [-100 , 100];            % Velocities
Fdoppler = 2 * Velocity * Fc / c;   % Doppler Frequency 
L = length(Range);                  % Number of Detected Elements

% Signal to Noise Ratio values 
SNR = [5 10 15];  
SNR_length = length(SNR);
SNR_index = 2;     % Random switching between SNR values for testing

% Time parameters for plotting and figures
T_PRI   = 0:Ts:PRI-Ts;
T_chirp = 0:Ts:Tchirp-Ts;
T_total = 0:Ts:(Nc*PRI - Ts);
N_time = length(T_total);
Colors = lines(L);                  % Colors for targets
N_plot = min(N_time, 40000); 
T_plot = T_total(1:N_plot);

%% Signals and frequencies 

% Linear Frequency Modulation (LFM) Plots for Understanding and Analyzing 
f_Tx = generate_ftx(Fmin, s, T_PRI, T_chirp, Nc);
f_Rx = generate_frx(Fmin, s, T_PRI, T_chirp, Range, c, Ts, Nc);
plot_frequency(T_plot, f_Tx, f_Rx, N_plot, L, Colors);

% Signals Generation and simulation (Transmitted signal and Received signal)
Tx = generate_Tx(T_total, Fmin, BW, Tchirp, PRI, Nc);                        % Generating the Transmitted Signal of the radar
Rx = generate_Rx(T_total, T_chirp, Fmin, s, PRI, Nc, Range, c, Fdoppler);    % Generating the Received Signal from objects
Rx = awgn(Rx, SNR(SNR_index), 'measured');                                   % Adding noise to the received signal
plot_Tx(T_plot, Tx, N_plot);                                                 % Plotting the transmitted signal
plot_Rx(T_plot, Rx, N_plot, Colors, SNR(SNR_index));                         % Plotting the received signal


%% Beat Frequency with its LOW Pass Filter

Beat_signal = Beat_lpf(Tx, Rx, Fs,T_plot, N_plot, Colors);                                        % Estimating and Plotting the beat signal for each target 
[FFT_beat, f_axis, Processing_time] = range_fft_one_chirp(Beat_signal, T_total, Tchirp, Fs);      % FFT for fast-axis
[CFAR_th, R, f_beats, pks] = cfar_range_detection(FFT_beat, f_axis, c, s, L);                     % Range detection and applying Constant False Alarm Rate (CFAR) concept
plot_fbeat(f_axis, FFT_beat, f_beats, R, pks);                                                    % Plotting the result of the FFT showing the detected beat frequency for each target


%% Velocity and Range final estimation and plotting the results

range_spectrum_cfar(FFT_beat, f_axis, CFAR_th,R, pks, Range, c, s);                                                                 % Plotting the detected ranges of each target
[RD_map_dB, range_axis, velocity_axis] = range_doppler_map(Beat_signal, T_total, Tchirp, PRI, Ts, Nc, Fs, c, Fc, s);                % Plotting the Range-Doppler Map
doppler_spectrum(abs(RD_map_dB), range_axis, velocity_axis,R, Range, Velocity, Processing_time);                                    % Plotting the detected velocities of each target