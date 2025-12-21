function [R_est, V_est, Processing_time] = detect_targets_RD(RD_map_dB, range_axis, velocity_axis, L)

    RD_lin = abs(RD_map_dB);
    RD_lin = RD_lin / max(RD_lin(:));

    thresh = 0.6;  % adjust if needed
    BW = imregionalmax(RD_lin) & (RD_lin > thresh);

    [v_idx, r_idx] = find(BW);

    % Sort strongest peaks
    power = RD_lin(sub2ind(size(RD_lin), v_idx, r_idx));
    [~, idx] = sort(power, 'descend');

    idx = idx(1:L);
    r_idx = r_idx(idx);
    Processing_time = toc;
    v_idx = v_idx(idx);

    R_est = range_axis(r_idx);
    V_est = velocity_axis(v_idx);
end
