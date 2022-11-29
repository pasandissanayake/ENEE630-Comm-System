%%%%%%%%%%%%%% parameters %%%%%%%%%%%%%%%%%%

% Rn file path + name
RECEIVED_DATA_FILE = 'C:\Users\pasan\Desktop\ENEE630_F2022_TXsim\Rn_GroupID_1A_FreqID_10_SNR_-5.000000_Foff_0.000000_Nframe_5_Nstart_1.txt';

% output file path + name (to save decoded data)
DECODED_DATA_FILE = 'C:\Users\pasan\Desktop\ENEE630_F2022_TXsim\decoded_data.txt';

GROUP_ID = 0x1A;    % group id
FREQ_ID = 10;       % frequency id
FRAME_START = 1;    % starting frame number

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[H0,H1,F0,F1] = filter_def();
decoded_data = read_file(RECEIVED_DATA_FILE,FREQ_ID,GROUP_ID,FRAME_START,128,F0,F1);
write_file(DECODED_DATA_FILE,decoded_data);