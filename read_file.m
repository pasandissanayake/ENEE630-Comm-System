function [id_sig, data_sig] = read_file(path,block_num,data_only)
% path - file path + name
% block_num - block number to read
% data_only - to read Rx file put 0, to read input data file put 1
% id_sig - group frequency id samples vector (empty if data_only = 0)
% data_sig - data vector
    ID_SIG_LEN = 128; DATA_SIG_LEN = 1024; I_COL = 1; Q_COL = 2;
    
    if data_only > 0
        block_len = DATA_SIG_LEN + 2; % +2 is due to the two emplty lines at the end of each block
    else
        block_len = ID_SIG_LEN + DATA_SIG_LEN + 2;
    end

    opts = detectImportOptions(path);
    opts.DataLines = [block_len*(block_num-1)+1 block_len*block_num-2];
    
    m = readmatrix(path,opts);
    
    if (data_only == 0 && length(m) < ID_SIG_LEN + DATA_SIG_LEN) || (data_only > 0 && length(m) < DATA_SIG_LEN)
        fprintf('read_file: block number %d does not contain valid data\n',block_num);
        id_sig = [];
        data_sig = [];
        return
    end
    
    if data_only > 0
        id_sig = [];
        data_sig = m(1:DATA_SIG_LEN,I_COL) + 1i*m(1:DATA_SIG_LEN,Q_COL);
    else
        id_sig = m(1:ID_SIG_LEN,I_COL) + 1i*m(1:ID_SIG_LEN,Q_COL);
        data_sig = m(ID_SIG_LEN+1:ID_SIG_LEN+DATA_SIG_LEN,I_COL) + 1i*m(ID_SIG_LEN+1:ID_SIG_LEN+DATA_SIG_LEN,Q_COL);
    end
end
