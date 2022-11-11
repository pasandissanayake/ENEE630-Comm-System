function out=polyphase_rx(sig_in, F0, F1)
% input: Nx4
% F0, F1: Mx2 real arrays (M=order, Fi(1)=numerator, Fi(2)=denominator) - analysis filters
    v0=sig_in(1,2:(2+sig_in(1,1)-1));
    v1=sig_in(2,2:(2+sig_in(2,1)-1));
    v2=sig_in(3,2:(2+sig_in(3,1)-1));
    v3=sig_in(4,2:(2+sig_in(4,1)-1));
    
    % fprintf("input sizes: %d %d %d %d\n",length(v0),length(v1),length(v2),length(v3))

    in_20=onestagepp_rx([v0; v1], F0, F1);
    in_10=onestagepp_rx([in_20; v2], F0, F1);
    in_00=onestagepp_rx([in_10; v3], F0, F1);

    out=in_00;
end