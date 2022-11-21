function decoded_data = Top_level_read_file(path)

FREQ_ID=10; GROUP_ID=0; FRAME_START=0; DFT_BINS = 128;

global H0 H1 F0 F1
H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;

F0 = H0;
F1 = H1; %F1(1,:) = -F1(1,:);

block_num = 1; frame = FRAME_START;
decoded_data = [];
n_end = 0;
while true
    [id_sig,data_sig]=read_file(path,block_num,0);

    if isempty(data_sig)
        break
    end

    [freq_sign,freq_offset]=detector(id_sig);
    
    if freq_sign==FREQ_ID
        owner = 'us';
        n = 0:1:(length(data_sig)-1);
        n = n' + n_end;
        n_end = n(end) + 1;
        freq_adjust = exp(-1i*2*pi*freq_offset*n/DFT_BINS);
        d_data = data_sig .* freq_adjust;
        decoded_data = [decoded_data polyphase_rx(scrambler(interleaver_rx(d_data),GROUP_ID,frame),F0,F1);];
        frame = frame + 1;
    else
        owner = 'them';
    end
    fprintf('block: %2d freq. sign: %2d offset: %2d owner: %4s\n',block_num,freq_sign,freq_offset,owner);
    
    block_num = block_num + 1;
end
end

