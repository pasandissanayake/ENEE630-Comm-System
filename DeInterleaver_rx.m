function out=DeInterleaver_rx(sig_in)
deinterleaver_order=[1,4,2,4,3,4,3,4];


V0=zeros(1,513);
V1=zeros(1,513);
V2=zeros(1,513);
V3=zeros(1,513);

V0_ptr=2;
V1_ptr=2;
V2_ptr=2;
V3_ptr=2;

in_ptr=1;
for i=1:length(sig_in)/8
    for j=1:8
        switch deinterleaver_order(j)
            case 1
                V0(V0_ptr)=sig_in(in_ptr);
                V0_ptr=V0_ptr+1;
            case 2
                V1(V1_ptr)=sig_in(in_ptr);
                V1_ptr=V1_ptr+1;
            case 3
                V2(V2_ptr)=sig_in(in_ptr);
                V2_ptr=V2_ptr+1;
            case 4
                V3(V3_ptr)=sig_in(in_ptr);
                V3_ptr=V3_ptr+1;
        end
        in_ptr=in_ptr+1;
    end
end
V0(1,1)=V0_ptr-2;
V1(1,1)=V1_ptr-2;
V2(1,1)=V2_ptr-2;
V3(1,1)=V3_ptr-2;

out=[V0;V1;V2;V3];
end