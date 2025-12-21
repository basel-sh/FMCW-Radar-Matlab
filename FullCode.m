% FMCW Radar Project
% Team : Basel Shrief Hemaid , Mariam Ahmed Mohammed Ali Reda
% Codes: 91240202            , 91240733

%% Project

clear; close all; clc;

% Project Folders
addpath('frequency');
addpath('amplitude');
addpath('Beat Frequency and LowPass Filter\')
addpath('CFAR with FFT for Range Estimation\');
addpath('Normal 2D FFT for Ranges-Velocities\');


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
Range = [10, 50 , 250 , 125];                 % Ranges  
Velocity = [70 , -100 , 25, 100];            % Velocities
Fdoppler = 2 * Velocity * Fc / c;   % Doppler Frequency 
L = length(Range);                  % Number of Detected Elements

% Signal to Noise Ratio values 
SNR = [5 10 15];  
SNR_length = length(SNR);
SNR_index = 1;     % Random switching between SNR values for testing

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
F_TX = generate_ftx(Fmin, s, T_PRI, T_chirp, Nc);
F_RX = generate_frx(Fmin, s, T_PRI, T_chirp, Range, c, Ts, Nc);
plot_frequency(T_plot, F_TX, F_RX, N_plot, L, Colors);

% Signals Generation and simulation (Transmitted signal and Received signal)
Tx = generate_Tx(T_total, Fmin, BW, Tchirp, PRI, Nc);                        % Generating the Transmitted Signal of the radar
Rx = generate_Rx(T_total, T_chirp, Fmin, s, PRI, Nc, Range, c, Fdoppler);    % Generating the Received Signal from objects
Rx = awgn(Rx, SNR(SNR_index), 'measured');                                   % Adding noise to the received signal
plot_Tx(T_plot, Tx, N_plot);                                                 % Plotting the transmitted signal
plot_Rx(T_plot, Rx, N_plot, Colors, SNR(SNR_index));                         % Plotting the received signal


%% Beat Frequency with Mixer and LOW Pass Filter
Beat_raw    = Beat_mixer(Tx, Rx); % Mixer to Get Beat Frequency                     
Beat_signal = Beat_lpf(Beat_raw, Fs, T_plot, N_plot, Colors); % Low Pass Filter for Better Data

%% Final Estimation and Visualizations
[RD_map_dB, range_axis, velocity_axis] = Compute_Doppler_FFT(Beat_signal, T_total, Tchirp, PRI, Ts, Nc, Fs, c, Fc, s); % Compute 2D Doppler FFT ONCE for Fast Time and Slow Time
[R_est, V_est, Processing_time] = detect_targets_RD(RD_map_dB, range_axis, velocity_axis, L);
Plot_Range_Vs_Magnitude(RD_map_dB, range_axis, R_est); % Range Vs Magnitude Plot
Plot_Velocity_Vs_Magnitude(RD_map_dB, velocity_axis, V_est); % Velocity Vs Magnitude Plot
Plot_Range_Velocity_Map(RD_map_dB, range_axis, velocity_axis); %Range–Velocity Map Plot
Display_Target_Estimation_Summary(R_est, V_est, Processing_time); % Summarizing the Results

%% Bonussssssssssssss Testing CFAR for Range Detection
[FFT_beat, f_axis] = range_fft_one_chirp(Beat_signal, T_total, Tchirp, Fs);      % FFT for fast-axis
[CFAR_th, R, f_beats, pks] = cfar_range_detection(FFT_beat, f_axis, c, s, L);     % Range detection and applying Constant False Alarm Rate (CFAR) concept
Plot_New_FBeat(f_axis, FFT_beat, f_beats, R, pks);     % Plotting the result of the FFT showing the detected beat frequency for each target
