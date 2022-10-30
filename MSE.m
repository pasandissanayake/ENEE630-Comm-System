function out = MSE(n, sig_len)
% output: Mean square error (MSE) averaged over 'n' bursts (each of size
% sig_len)
% inputs: 
%   n       - number of bursts
%   sig_len - size of each burst

%% Calculating avg. MSE over 'n' bursts

MSE_burst_sum = 0;

for burst_no = 1:n
    % random input - x
    x = rand(1,sig_len,"like",1i);

    % synthesized signal - x_h

    x_h = rand(1,sig_len,"like",1i); % NEED TO GET THIS FROM A FUNCTION

    x_abs_diff_2= abs(x-x_h).^2;
    x_2 = abs(x).^2;
    MSE_burst_sum = MSE_burst_sum + sqrt(sum(x_abs_diff_2./x_2))/sig_len;
end

out = MSE_burst_sum/n;
end