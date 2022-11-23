function [freq_sign, freq_offset] = detector(burst_sig, fix_any)
% INPUT :   burst_sig (complex)   - burst signal in the begining of the frame 
%           fix_any (0/1)         - fix any frequency offset (1 to fix any)
% OUTPUTS:
%       freq_sign               - group freq signature
%       freq_offset             - (group freq signature -
%       128*(burst_sig_freq/(2*pi)) (i.e. Delta_omega)
    
group_bins = [10 20 30 40 50 60 70 80 90 100 110];

% Get the fft
dft_out = abs(fft(burst_sig,128))./128;

% Detect burst freq
[max_fft, max_bin] = max(dft_out);
fprintf('max bin: %f\n', max_bin-1);
% Compensate for any freq offset
 if fix_any == 1
     ya = dft_out(max_bin-2);
     yb = dft_out(max_bin-1);
     yd = dft_out(max_bin+1);
     ye = dft_out(max_bin+2);
%     max_fft_m1 = dft_out(max_bin-1)^0.5;
%     max_fft_p1 = dft_out(max_bin+1)^0.5;
%     denom = 2*(max_fft_m1+max_fft_p1-2*(max_fft)^0.5);
%     if denom~=0
%         delta = (max_fft_m1 - max_fft_p1)/denom;
%     end
end

% Calculate freq signature and freq offset
max_bin = max_bin - 1;
dist_arr = abs(group_bins - max_bin);
[min_dist, min_dist_idx] = min(dist_arr);

freq_sign = group_bins(min_dist_idx);

if fix_any == 1
%     true_freq = (max_bin + delta);
    true_freq = fudge(ya,yb,yd,ye,max_bin);
    freq_offset = true_freq - freq_sign;
else
    freq_offset = max_bin - freq_sign;
end

end