function [out_pn_re, out_pn_im] = pn_sequence(channel, group_id, frame_no)
% Inputs :
%       channel (int - 0,1,2,3)     - specify channel V0, V1, V2 or V3
%       group_id (hex)              - group ID to generate the key (0x1A)
%       frame_no (int)              - current frame number to generate the key

%% Generating personal key
key = zeros(1,26);

% convert frame_no to binary logical array
frame_no = dec2bin(frame_no);
frame_no = frame_no == '1';

switch channel
    case 0
        shift = 10;
        group_mul = 1;
        frame_size = 128;
    case 1
        shift = 11;
        group_mul = 3;
        frame_size = 128;
    case 2
        shift = 12;
        group_mul = 5;
        frame_size = 256;
    case 3
        shift = 13;
        group_mul = 7;
        frame_size = 512;
    otherwise
        error('Invalid channel ID');
end

% convert group ID to binary logical array
group_id = dec2bin(group_mul * group_id);
group_id = group_id == '1';

% construct key
key(end+1-(length(frame_no)+shift):end-shift) = frame_no;
key(end+1-length(group_id):end) = group_id;

re_key = key;
im_key = key;

out_pn_re = zeros(1,512);
out_pn_im = zeros(1,512);

%% Generating PN sequences
for i = 1:frame_size
    % real pn sequence
    re_pn_bit = xor(xor(re_key(26-25),re_key(26-3)),re_key(26-0));
    out_pn_re(i) = 1 - 2*(re_pn_bit);
    re_key = [re_key(2:end) re_pn_bit];
    
    % imag pn sequence
    im_pn_bit = xor(xor(xor(xor(im_key(26-25),im_key(26-3)),im_key(26-2)),im_key(26-1)),im_key(26-0));
    out_pn_im(i) = 1 - 2*(im_pn_bit);
    im_key = [im_key(2:end) im_pn_bit];
end


end