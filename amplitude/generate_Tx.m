% This function generates the transmitted signal

function tx = generate_Tx(t_pri, fmin, Tchirp, Nc, s)

% Transmitted signal generation for a single chirp
tx_pri = zeros(size(t_pri));
i = t_pri < Tchirp;
t_local = t_pri(i);
tx_pri(i) = exp(1j*2*pi*(fmin*t_local + 0.5*s*t_local.^2));

tx = repmat(tx_pri, 1, Nc);         % Repeating over all chirps

%    tx = zeros(size(t_total));
 %   s = BW / Tchirp;

  %  for n = 0:Nc-1   % For Each Chirp
   %     t0 = n * PRI;
    %    i = (t_total >= t0) & (t_total < t0 + Tchirp);
     %   t_local = t_total(i) - t0;
      %  tx(i) = exp(1j*2*pi*(fmin*t_local + 0.5*s*t_local.^2));
    %end
%end