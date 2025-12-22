function [R, V, Tprocessing] = detect_targets_RD(RD_map_dB, range_axis, velocity_axis, L)

    RD_lin = RD_map_dB / max(RD_map_dB(:));

    thresh = 0.6;  % adjust if needed
    BW = imregionalmax(RD_lin) & (RD_lin > thresh);

    [v_idx, r_idx] = find(BW);

    % Sort strongest peaks
    power = RD_lin(sub2ind(size(RD_lin), v_idx, r_idx));
    [~, i] = sort(power, 'descend');

    i = i(1:L);
    r_idx = r_idx(i);
    Tprocessing = toc;
    v_idx = v_idx(i);

    R = range_axis(r_idx);
    V = velocity_axis(v_idx);
end