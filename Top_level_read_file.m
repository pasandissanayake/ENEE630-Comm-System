function decoded_data = Top_level_read_file(path, F0, F1)

FREQ_ID=10; GROUP_ID=0x1A; FRAME_START=0;

block_num = 1; frame = FRAME_START;
decoded_data = [];
while true
    [id_sig,data_sig]=read_file(path,block_num,0);

    if isempty(data_sig)
        break
    end

    [freq_sign,freq_offset]=detector(id_sig);
    
    if freq_sign==FREQ_ID
        owner = 'us';
        decoded_data = [decoded_data polyphase_rx(scrambler(interleaver_rx(data_sig),GROUP_ID,frame),F0,F1)];
    else
        owner = 'them';
    end
    fprintf('block: %2d freq. sign: %2d offset: %2d owner: %4s\n',block_num,freq_sign,freq_offset,owner);
    
    block_num = block_num + 1;
    frame = frame + 1;
end

