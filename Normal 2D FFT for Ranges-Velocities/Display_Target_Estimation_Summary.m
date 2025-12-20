function Display_Target_Estimation_Summary(R_est, V_est, Processing_time)
% Bonusssssssssss
% Display Target Estimation Results (Ranges & Velocities)
% For Summary and Fast Debuging Without Looking at the Graphs

disp(' ');
disp('---------------- Target Estimation Summary ----------------');

numTargets = min(length(R_est), length(V_est)); % Each Target for R and V

for k = 1:numTargets
    fprintf('Target %d:  R = %.2f m   |   V = %.2f m/s\n', k, R_est(k), V_est(k)); % Printing Each Computed Target
end

disp('------------------------------------------------------------');
fprintf('Processing Time: %.6f s\n', Processing_time);
disp('------------------------------------------------------------');
disp(' ');

end
