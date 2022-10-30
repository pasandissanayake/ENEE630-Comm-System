function out=polyphase_rx(sig_in, F0, F1)
% input: NxP complex array - signal to filter
% h0, h1: Mx2 real arrays (M=order, Hi(1)=numerator, Hi(2)=denominator) - analysis filters
out_0=filter(F0(1,:),F0(2,:),upsample(sig_in(1,:),2));
out_1=filter(F1(1,:),F1(2,:),upsample(sig_in(2,:),2));
out=2 * (out_0 + out_1);
end