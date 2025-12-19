% This function generates the transmitted frequency, 
% showing the concept of the LFM

function f_tx = generate_ftx(fmin, s, t_pri, t_chirp, Nc) 

    f_tx_pri = fmin * ones(size(t_pri));
    f_tx_pri(1:length(t_chirp)) = fmin + s*t_chirp;

    f_tx = repmat(f_tx_pri, 1, Nc);
end