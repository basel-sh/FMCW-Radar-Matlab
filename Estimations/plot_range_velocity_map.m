function plot_range_velocity_map(RD_map_dB, range_axis, velocity_axis)

figure;
imagesc(range_axis, velocity_axis, RD_map_dB);
axis xy;
colormap jet;
colorbar;
xlabel('Range (m)');
ylabel('Velocity (m/s)');
title('Range–Velocity Map');

end
