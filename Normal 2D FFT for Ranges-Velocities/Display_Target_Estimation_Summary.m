% Bonusssssssssss
% Display Target Estimation Results (Ranges & Velocities)
% For Summary and Fast Debuging Without Looking at the Graphs

function Display_Target_Estimation_Summary(R, V, Tprocessing)

disp(' ');
disp('---------------- Target Estimation Summary ----------------');

numTargets = min(length(R), length(V)); % Each Target for R and V

for k = 1:numTargets
    if V(k) > 0
        target = 'Approaching Target';
    else
        target = 'Receding Target';
    end
    fprintf('Target %d:  R = %.2f m   |   V = %.2f m/s   (%s)\n', k, R(k), abs(V(k)), target);
end


disp('------------------------------------------------------------');
fprintf('Range Processing Time: %.6f s\n', Tprocessing);
disp('------------------------------------------------------------');
disp(' ');

end
