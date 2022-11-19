function [freq_sign, freq_offset] = detector(burst_sig)
% INPUT : burst_sig (complex)   - burst signal in the begining of the frame 
% OUTPUTS:
%       freq_sign               - group freq signature
%       freq_offset             - (group freq signature -
%       128*(burst_sig_freq/(2*pi)) (i.e. Delta_omega)
    
group_bins = [10 20 30 40 50 60 70 80 90 100 110];

% Get the fft
dft_out = abs(fft(burst_sig));

% Detect burst freq
[max_fft, max_bin] = max(dft_out(1:64));

% Calculate freq signature and freq offset
max_bin = max_bin -1;
dist_arr = abs(group_bins - max_bin);
[min_dist, min_dist_idx] = min(dist_arr);

freq_sign = group_bins(min_dist_idx);
freq_offset = max_bin - freq_sign;

end