DIRECTORY = 'D:\UMD\Academics\Fall 22\ENEE 630 - ADSP\Project\simulator';
FILE_SUFFIX = 'GroupID_1A_FreqID_10_SNR_100.000000_Foff_0.000000_Nframe_1_Nstart_1.txt';

GROUP_ID = 0x1A;
FREQ_ID = 10;
FRAME_START = 1;
DFT_BINS = 128;

SNR = -10;

[H0,H1,F0,F1] = filter_def();

decoded_data = read_file(strcat(DIRECTORY,'\Rn_',FILE_SUFFIX),FREQ_ID,GROUP_ID,FRAME_START,DFT_BINS,F0,F1,SNR);

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

fprintf('test MSE: %.10f\n',MSE(decoded_data(15:end-15),original_data(15:end-15),0,0,0))

