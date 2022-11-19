function [id_sig, data] = read_file(path,block_num,data_only)
    ID_SIG_LEN = 128; DATA_LEN = 1024;
    
    if data_only > 0
        block_len = DATA_LEN + 2; % +2 is due to the two emplty lines at the end of each block
    else
        block_len = ID_SIG_LEN + DATA_LEN + 2;
    end

    opts = detectImportOptions(path);
    opts.DataLines = [block_len*(block_num-1)+1 block_len*block_num-2];
    
    m = readmatrix(path,opts);
    
    if data_only > 0
        id_sig = [];
        data = m(1:DATA_LEN,1) + 1i*m(1:DATA_LEN,2);
    else
        id_sig = m(1:ID_SIG_LEN,1) + 1i*m(1:ID_SIG_LEN,2);
        data = m(ID_SIG_LEN+1:ID_SIG_LEN+DATA_LEN,1) + 1i*m(ID_SIG_LEN+1:ID_SIG_LEN+DATA_LEN,2);
    end
end
