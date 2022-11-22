DIRECTORY = 'C:\Users\pasan\Desktop\ENEE630_F2022_TXsim';
FILE_SUFFIX = 'GroupID_1A_FreqID_10_SNR_10.000000_Foff_234.375000_Nframe_5_Nstart_1.txt';

FREQ_ID = 10;
GROUP_ID = 0x1A;
FRAME_START = 1;
DFT_BINS = 128;

global H0 H1 F0 F1
H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;
F0 = H0;
F1 = H1; %F1(1,:) = -F1(1,:);

decoded_data = read_file(strcat(DIRECTORY,'\Rn_',FILE_SUFFIX),FREQ_ID,GROUP_ID,FRAME_START,DFT_BINS,F0,F1);

original_data = [];
for k=1:length(decoded_data)/1024
    [~,e] = read_block(strcat(DIRECTORY,'\Input_',FILE_SUFFIX),k,1);
    original_data = [original_data e'];
end

figure;
plot(1:length(decoded_data),decoded_data,'r-',1:length(original_data),original_data,'b--');
title('decoded and original data - time domain');
legend('decoded data','original data');

figure;
sgtitle('decoded and original data - frequency domain');
subplot(2,1,1);
plot(abs(fft(decoded_data,128))/5120,'r-');
title('decoded data - dft');
subplot(2,1,2);
plot(abs(fft(original_data,128))/5120,'r-');
title('original data - dft');

fprintf('test MSE: %f\n',MSE(decoded_data,original_data,0,0,0))

