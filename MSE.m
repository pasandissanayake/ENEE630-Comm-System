function out = MSE(synthesis_fun,in_sig,show_plot,n,sig_len)
% output: Mean square error (MSE) averaged over 'n' bursts (each of size sig_len)
% inputs: 
%   n       - number of bursts
%   sig_len - size of each burst

%% Calculating avg. MSE over 'n' bursts

MSE_burst_sum = 0;

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
        x = randn(1,sig_len,"like",1i);
    else
        x = in_sig;
    end

    % synthesized signal - x_h
    if isa(synthesis_fun,'function_handle')
        [x, x_h] = synthesis_fun(x);
    else
        x_h = synthesis_fun;
    
    % MSE calculation
    x_abs_diff_2 = abs(x-x_h).^2;
    x_2 = abs(x).^2;

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