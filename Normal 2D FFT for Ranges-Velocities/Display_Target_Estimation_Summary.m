function Display_Target_Estimation_Summary(R_est, V_est, Processing_time)

% =========================================================
% Display Target Estimation Results (Ranges & Velocities)
% =========================================================

disp(' ');
disp('---------------- Target Estimation Summary ----------------');

numTargets = min(length(R_est), length(V_est));

for k = 1:numTargets
    fprintf('Target %d:  R = %.2f m   |   V = %.2f m/s\n', ...
            k, R_est(k), V_est(k));
end

disp('------------------------------------------------------------');
fprintf('Processing Time: %.6f s\n', Processing_time);
disp('------------------------------------------------------------');
disp(' ');

end
