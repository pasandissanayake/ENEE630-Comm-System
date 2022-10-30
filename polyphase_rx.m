function out=polyphase_rx(sig_in, F0, F1)
% input: Nx4
% F0, F1: Mx2 real arrays (M=order, Fi(1)=numerator, Fi(2)=denominator) - analysis filters
input1=sig_in(1,2:(2+sig_in(1,1)-1));
input2=sig_in(2,2:(2+sig_in(2,1)-1));
input3=sig_in(3,2:(2+sig_in(3,1)-1));
input4=sig_in(4,2:(2+sig_in(4,1)-1));

in_0=upsample(input1,2);
in_1=upsample(input2,2);
in_0=filter(F0(1,:),F0(2,:),in_0);
in_1=filter(F1(1,:),F1(2,:),in_1);
in_01=in_0+in_1;

in_01=upsample(in_01,2);
in_2=upsample(input3,2);
in_01=filter(F0(1,:),F0(2,:),in_01);
in_2=filter(F1(1,:),F1(2,:),in_2);
in_012=in_01+in_2;

in_012=upsample(in_012,2);
in_3=upsample(input4,2);
in_012=filter(F0(1,:),F0(2,:),in_012);
in_3=filter(F1(1,:),F1(2,:),in_3);
out=in_012+in_3;
end