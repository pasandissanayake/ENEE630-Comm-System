function out=onestagepp_tx(sig_in, H0, H1)
    h0_mid = floor(length(H0)/2);
    h1_mid = floor(length(H1)/2);

    int_0=filter(H0(1,:),H0(2,:),[sig_in zeros(1,h0_mid)]);
    int_1=filter(H1(1,:),H1(2,:),[sig_in zeros(1,h1_mid)]);
    
    out_0=downsample(int_0(h0_mid+1:end),2);
    out_1=downsample(int_1(h1_mid+1:end),2);

%     int_0=filter(H0(1,:),H0(2,:),[sig_in zeros(1,length(H0))]);
%     int_1=filter(H1(1,:),H1(2,:),[sig_in zeros(1,length(H1))]);
%     
%     out_0=downsample(int_0(length(H0)+1:end),2);
%     out_1=downsample(int_1(length(H1)+1:end),2);
    
    out=[out_0;out_1];
end