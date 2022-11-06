function out=polyphase_rx(sig_in, F0, F1)
% input: Nx4
% F0, F1: Mx2 real arrays (M=order, Fi(1)=numerator, Fi(2)=denominator) - analysis filters
    DELAY = floor(length(F0(1,:))/2)*2;

    v0=sig_in(1,2:(2+sig_in(1,1)-1));
    v1=sig_in(2,2:(2+sig_in(2,1)-1));
    v2=sig_in(3,2:(2+sig_in(3,1)-1));
    v3=sig_in(4,2:(2+sig_in(4,1)-1));
    
    % fprintf("input sizes: %d %d %d %d\n",length(v0),length(v1),length(v2),length(v3))

    % level 3
    in_20=upsample(v0,2);
    in_20=filter(F0(1,:),F0(2,:),in_20);
    in_21=upsample(v1,2);
    in_21=filter(F1(1,:),F1(2,:),in_21);
    in_10=in_20+in_21;
    in_10=2*in_10(1+DELAY:end);
    % disp("in_10: " + length(in_10));

    % level 2
    in_10=upsample(in_10,2);
    in_10=filter(F0(1,:),F0(2,:),in_10);
    in_11=upsample(v2(1:end-DELAY),2);
    in_11=filter(F1(1,:),F1(2,:),in_11);
    in_00 = in_10 + in_11;
    in_00 = 2*in_00(1+DELAY:end);
    % disp("in_00: " + length(in_00));
    
    % level 1
    in_00=upsample(in_00,2);
    in_00=filter(F0(1,:),F0(2,:),in_00);
    in_01=upsample(v3(1:end-DELAY*3),2);
    in_01=filter(F1(1,:),F1(2,:),in_01);
    out=in_00+in_01;
    out=2*out(1+DELAY:end);
end