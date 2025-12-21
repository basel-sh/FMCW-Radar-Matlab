%Just Ploting the Range ,Veloicty Axis that got from the Compute Function.

function Plot_Range_Velocity_Map(RD_map_dB, range_axis, velocity_axis)

figure;
imagesc(range_axis, velocity_axis, RD_map_dB);
axis xy;
colormap jet;
colorbar;
xlabel('Range (m)');
ylabel('Velocity (m/s)');
title('Range–Velocity Map');
xlim([0 300]);
end
