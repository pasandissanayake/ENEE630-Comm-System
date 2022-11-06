function out=polyphase_tx(sig_in, H0, H1)
% sig_in: Nx1 complex array - signal to filter
% h0, h1: Mx2 real arrays (M=order, Hi(1)=numerator, Hi(2)=denominator) - analysis filters

    % level 0
    out_00=filter(H0(1,:),H0(2,:),sig_in);
    out_00=downsample(out_00,2);
    out_01=filter(H1(1,:),H1(2,:),sig_in);
    v3=downsample(out_01,2);

    % level 1
    out_10=filter(H0(1,:),H0(2,:),out_00);
    out_10=downsample(out_10,2);
    out_11=filter(H1(1,:),H1(2,:),out_00);
    v2=downsample(out_11,2);

    % level 2
    out_20=filter(H0(1,:),H0(2,:),out_10);
    v0=downsample(out_20,2);
    out_21=filter(H1(1,:),H1(2,:),out_10);
    v1=downsample(out_21,2);
    
    % fprintf("output signal sizes: %d %d %d %d\n",length(v0),length(v1),length(v2),length(v3));

    % stack results into a single matrix
    out = zeros(4,length(v0)+1);
    out(1,1:length(v0)+1)=[length(v0) v0];
    out(2,1:length(v1)+1)=[length(v1) v1];
    out(3,1:length(v2)+1)=[length(v2) v2];
    out(4,1:length(v3)+1)=[length(v3) v3];    
end
