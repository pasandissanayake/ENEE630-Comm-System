function out=polyphase_tx(sig_in, H0, H1)
% sig_in: Nx1 complex array - signal to filter
% h0, h1: Mx2 real arrays (M=order, Hi(1)=numerator, Hi(2)=denominator) - analysis filters
out_0=filter(H0(1,:),H0(2,:),sig_in);
out_1=filter(H1(1,:),H1(2,:),sig_in);
out_0=downsample(out_0,2);
v3=downsample(out_1,2);
out_00=filter(H0(1,:),H0(2,:),out_0);
out_01=filter(H1(1,:),H1(2,:),out_0);
out_00=downsample(out_00,2);
v2=downsample(out_01,2);
out_000=filter(H0(1,:),H0(2,:),out_00);
out_001=filter(H1(1,:),H1(2,:),out_00);
v0=downsample(out_000,2);
v1=downsample(out_001,2);

out0=[v0 zeros(1,(length(v3)-length(v0)))];
out1=[v1 zeros(1,(length(v3)-length(v1)))];
out2=[v2 zeros(1,(length(v3)-length(v2)))];

out3_final=[length(v3) v3];
out2_final=[length(v2) out2];
out1_final=[length(v1) out1];
out0_final=[length(v0) out0];

out=[out0_final;out1_final;out2_final;out3_final];
end