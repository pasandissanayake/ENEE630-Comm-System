function out = MSE(synthesis_fun,in_sig,show_plot,n,sig_len)
% output: Mean square error (MSE)
% inputs: 
%   synthesis_fun - a function handle which outputs [original signal,
%   decoded signal] by taking original signal as the input
%   in_sig - original signal either a Mx1 array of samples or 1 (for sin) or 0 (for random)
%   show_plot - 1 (to show a plot) or 0 (not to show plot)
%   n - if in_sig=1 or 0, the number of bursts
%   sig_len = if in_sig=1 or 0, the length of the original signal


MSE_burst_sum = 0;

% if in_sig is a vector, consider it as the original signal
if ~isscalar(in_sig)
    n = 1;
end

for burst_no = 1:n
    if (isscalar(in_sig) && in_sig == 1)
        % sinusoid input
        T =1; w = pi/100;
        t =1:T:sig_len;
        x =1*cos(w*t/T) + 0*1.5*cos(10*w*t/T);
    elseif isscalar(in_sig)
        % random input
        x = randn(1,sig_len,"like",1i) * 2^15;
    else
        x = in_sig;
    end

    % synthesized signal - x_h
    if isa(synthesis_fun,'function_handle')
        [x, x_h] = synthesis_fun(x);
    else
        x_h = synthesis_fun;
    end
    
    % MSE calculation
    x_abs_diff_2 = abs(x-x_h).^2;
    x_2 = abs(x).^2;

    % neglect error for very small denominators
    idx=(x_2 < 1e-5);
    x_2(idx) = 1e-5;
    x_abs_diff_2(idx) = 0;
    
    MSE_burst_sum = MSE_burst_sum + (sum(x_abs_diff_2./x_2)/(length(x)-sum(idx)));
end
out = MSE_burst_sum/n;

if (show_plot > 0)
    figure;
    t=1:length(x);
    plot(t,x,'r-+',t,x_h,'g+-');
    legend('original','filtered');
    grid on;

    figure;
    subplot(211);
    plot(t,x_abs_diff_2,'r');
    subplot(212);
    plot(t,x_abs_diff_2./x_2,'r');
    grid on;
end

end