function out=polyphase_rx(input, F0, F1)
% input: Nx4
% F0, F1: Mx2 real arrays (M=order, Fi(1)=numerator, Fi(2)=denominator) - analysis filters
input1=input(1,2:(2+input(1,1)-1));
input2=input(2,2:(2+input(2,1)-1));
input3=input(3,2:(2+input(3,1)-1));
input4=input(4,2:(2+input(4,1)-1));

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