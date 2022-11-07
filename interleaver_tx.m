function out=interleaver_tx(sig_in)
interleaver_order=[1,4,2,4,3,4,3,4];

V0_size=sig_in(1,1);
V1_size=sig_in(2,1);
V2_size=sig_in(3,1);
V3_size=sig_in(4,1);

V0=sig_in(1,2:V0_size+1);
V1=sig_in(2,2:V1_size+1);
V2=sig_in(3,2:V2_size+1);
V3=sig_in(4,2:V3_size+1);

V0_ptr=1;
V1_ptr=1;
V2_ptr=1;
V3_ptr=1;

out_ptr=1;
for i=1:V0_size
    for j=1:8
        switch interleaver_order(j)
            case 1
                out(out_ptr)=V0(V0_ptr);
                V0_ptr=V0_ptr+1;
            case 2
                out(out_ptr)=V1(V1_ptr);
                V1_ptr=V1_ptr+1;
            case 3
                out(out_ptr)=V2(V2_ptr);
                V2_ptr=V2_ptr+1;
            case 4
                out(out_ptr)=V3(V3_ptr);
                V3_ptr=V3_ptr+1;
        end
        out_ptr=out_ptr+1;
    end
end
end