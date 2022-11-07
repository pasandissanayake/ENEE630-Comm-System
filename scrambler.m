function out = scrambler(sig_in,group_id,frame_no)
%       sig_in (complex)            - (4,513) matrix (channel,samples)
%       group_id (hex)              - group ID to generate the key (0x1A)
%       frame_no (int)              - current frame number to generate the key

% Get pn sequences for each channel
[v0_pn_re , v0_pn_im] = pn_sequence(0,group_id,frame_no);
[v1_pn_re , v1_pn_im] = pn_sequence(1,group_id,frame_no);
[v2_pn_re , v2_pn_im] = pn_sequence(2,group_id,frame_no);
[v3_pn_re , v3_pn_im]= pn_sequence(3,group_id,frame_no);

v0 = sig_in(1,2:end);
v1 = sig_in(2,2:end);
v2 = sig_in(3,2:end);
v3 = sig_in(4,2:end);

% Apply scrambling sequence
v0 = real(v0).*v0_pn_re + 1j*imag(v0).*v0_pn_im;
v1 = real(v1).*v1_pn_re + 1j*imag(v1).*v1_pn_im;
v2 = real(v2).*v2_pn_re + 1j*imag(v2).*v2_pn_im;
v3 = real(v3).*v3_pn_re + 1j*imag(v3).*v3_pn_im;

out = [[128 v0];[128 v1];[256 v2];[512 v3]];
end