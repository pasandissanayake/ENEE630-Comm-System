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
        x =1*cos(w*t/T) + 0*1.5*cos(10*w*t/T);
    else
        % random input
        x = randn(1,sig_len,"like",1i);
    end

    % synthesized signal - x_h
    [x, x_h] = synthesis_fun(x);
    
    % x = x(100:end-100);
    % x_h = x_h(100:end-100);
    % MSE calculation
    x_abs_diff_2 = abs(x-x_h).^2;
    x_2 = abs(x).^2;

    idx=(x_2 < 1e-5);
    x_2(idx) = 1e-5;
    x_abs_diff_2(idx) = 0;
    
    MSE_burst_sum = MSE_burst_sum + (sum(x_abs_diff_2./x_2)/(length(x)-sum(idx)));
end

out = MSE_burst_sum/n;
fprintf("x: %d, value: %d\n",x_2(50), x_abs_diff_2(50));
fprintf('sum idx: %f\n', sum(idx));
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