function P = radar_params()
% RADAR_PARAMS  FMCW radar constants and parameters

P.c  = 3e8;           % Speed of light (m/s)
P.fc = 76.5e9;        % Carrier frequency (Hz)
P.BW = 1e9;           % Chirp bandwidth (Hz)
P.Tchirp = 2.1e-6;    % Chirp duration (s)
P.PRI = 8.4e-6;       % Pulse Repetition Interval
P.Tidle = P.PRI - P.Tchirp;
P.slope = P.BW / P.Tchirp;

P.Ts = 0.5e-9;        % Sampling period
P.Fs = 1 / P.Ts;      % Sampling frequency

P.fmin = 76e9;        % Start frequency
P.fmax = 77e9;        % End frequency

P.Nc = 512;           % Number of PRIs

end
