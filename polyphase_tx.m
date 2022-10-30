function out=polyphase_tx(sig_in, H0, H1)
% input: Nx1 complex array - signal to filter
% h0, h1: Mx2 real arrays (M=order, Hi(1)=numerator, Hi(2)=denominator) - analysis filters
out_0=downsample(filter(H0(1,:),H0(2,:),sig_in),2);
out_1=downsample(filter(H1(1,:),H1(2,:),sig_in),2);
out=[out_0;out_1];
end