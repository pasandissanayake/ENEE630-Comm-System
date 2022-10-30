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
    x = rand(1,sig_len,"like",1i)*50;

    % sinusoid test function
    %{ 
    T =1; w = pi/100;
    t =[1:T:sig_len];
    x =cos(w*t/T) + 1.5*cos(3*w*t/T);
    %}

    % synthesized signal - x_h
    [x, x_h] = polyphase_comb(x); % NEED TO GET THIS FROM A FUNCTION
    
    % plot test functions
    %{
    t=1:length(x);
    plot(t,x,'r--',t,x_h,'g--');
    %}

    x_abs_diff_2= abs(x-x_h).^2;
    x_2 = abs(x).^2;
    MSE_burst_sum = MSE_burst_sum + sqrt(sum(x_abs_diff_2./x_2)/length(x));
end

out = MSE_burst_sum/n;
end