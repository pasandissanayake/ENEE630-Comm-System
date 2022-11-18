function [id_sig, data] = read_file(path)
    ID_SIG_LEN = 128; DATA_LEN = 1024;

    m = readmatrix(path);
    L = length(m(:,1));
    n_frames = L / (ID_SIG_LEN + DATA_LEN);

    id_sig = [];
    data = [];

    for j=1:n_frames
        id_sig = [id_sig m(1152*(j-1)+1:1152*(j-1)+128,1) + 1i*m(1152*(j-1)+1:1152*(j-1)+128,2)];
        data = [data m(1152*(j-1)+129:1152*j,1) + 1i*m(1152*(j-1)+129:1152*j,2)];
    end
end
