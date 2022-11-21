function decoded_data = Top_level_read_file(path, F0, F1)

FREQ_ID=10; GROUP_ID=0; FRAME_START=0;

block_num = 1; frame = FRAME_START;
ddd = [];
n_end = 0;
figure;
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
        fix = exp(-2*pi*1i*50/128*n);
        plot(n,real(fix),'r-',n,imag(fix),'b-');
        hold on
        d_data = data_sig .* fix;
        ddd = [ddd polyphase_rx(scrambler(interleaver_rx(d_data),GROUP_ID,frame),F0,F1);];
        frame = frame + 1;
    else
        owner = 'them';
    end
    fprintf('block: %2d freq. sign: %2d offset: %2d owner: %4s\n',block_num,freq_sign,freq_offset,owner);
    
    block_num = block_num + 1;
end
decoded_data = ddd;
end

