function out=onestagepp_rx(sig_in, F0, F1)

f0_mid = floor(length(F0)/2);
f1_mid = floor(length(F1)/2);

int_0 = [upsample(sig_in(1,:),2) zeros(1,f0_mid)];
int_1 = [upsample(sig_in(2,:),2) zeros(1,f1_mid)];

in_0=filter(F0(1,:),F0(2,:),int_0);
in_1=filter(F1(1,:),F1(2,:),int_1);

out=2 * (in_0(f0_mid+1:end)+in_1(f1_mid+1:end));
end