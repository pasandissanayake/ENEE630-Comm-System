function out = MSE(n, sig_len, synthesis_fun, input_type, show_plot)
% output: Mean square error (MSE) averaged over 'n' bursts (each of size sig_len)
% inputs: 
%   n       - number of bursts
%   sig_len - size of each burst

%% Calculating avg. MSE over 'n' bursts

MSE_burst_sum = 0;

for burst_no = 1:n
    if (input_type == 1)
        % sinusoid input
        T =1; w = pi/100;
        t =1:T:sig_len;
        x =1*cos(w*t/T) + 1.5*cos(50*w*t/T);
    else
        % random input
        x = randn(1,sig_len,"like",1i);
    end

    % synthesized signal - x_h
    [x, x_h] = synthesis_fun(x);
    
    % plot test functions
    %{
    t=1:length(x);
    plot(t,x,'r--',t,x_h,'g--');
    legend('original','filtered');
    %}

    x_abs_diff_2= abs(x-x_h).^2;
    x_2 = abs(x).^2;
    MSE_burst_sum = MSE_burst_sum + sqrt(sum(x_abs_diff_2./x_2)/length(x));
end

if (show_plot > 0)
    t=1:length(x);
    plot(t,x,'r-+',t,x_h,'g--');
    legend('original','filtered');
end

out = MSE_burst_sum/n;
end