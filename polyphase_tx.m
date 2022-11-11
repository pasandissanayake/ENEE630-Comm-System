function out=polyphase_tx(sig_in, H0, H1)
% sig_in: Nx1 complex array - signal to filter
% h0, h1: Mx2 real arrays (M=order, Hi(1)=numerator, Hi(2)=denominator) - analysis filters

    % level 0
    out_00=onestagepp_tx(sig_in,H0,H1);
    v3=out_00(2,:);

    out_10=onestagepp_tx(out_00(1,:),H0,H1);
    v2=out_10(2,:);

    out_20=onestagepp_tx(out_10(1,:),H0,H1);
    v1=out_20(2,:);
    v0=out_20(1,:);
    
    % fprintf("output signal sizes: %d %d %d %d\n",length(v0),length(v1),length(v2),length(v3));

    % stack results into a single matrix
    out = zeros(4,length(v0)+1);
    out(1,1:length(v0)+1)=[length(v0) v0];
    out(2,1:length(v1)+1)=[length(v1) v1];
    out(3,1:length(v2)+1)=[length(v2) v2];
    out(4,1:length(v3)+1)=[length(v3) v3];    
end
