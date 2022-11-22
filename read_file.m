function decoded_data = read_file(file_path,freq_id,group_id,frame_start,dft_bins,F0,F1)

    current_block = 1; current_frame = frame_start;
    decoded_data = [];
    n_end = 0;
    while true
        [id_sig,data_sig]=read_block(file_path,current_block,0);
    
        if isempty(data_sig)
            break
        end
    
        [freq_sign,freq_offset]=detector(id_sig);
        
        if freq_sign==freq_id
            owner = 'us';
            n = 0:1:(length(data_sig)-1);
            n = n' + n_end;
            n_end = n(end) + 1;
            freq_adjust = exp(-1i*2*pi*freq_offset*n/dft_bins);
            raw_data = data_sig .* freq_adjust;
            decoded_data = [decoded_data polyphase_rx(scrambler(interleaver_rx(raw_data),group_id,current_frame),F0,F1);];
            current_frame = current_frame + 1;
        else
            owner = 'them';
        end
        fprintf('block: %2d   freq. sign: %2d   offset: %2d   owner: %4s\n',current_block,freq_sign,freq_offset,owner);
        current_block = current_block + 1;
    end
end

