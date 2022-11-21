p = '_GroupID_0_FreqID_10_SNR_100.000000_Foff_234.375000_Nframe_5_Nstart_0.txt';

dd = Top_level_read_file(strcat('C:\Users\pasan\Desktop\ENEE630_F2022_TXsim\Rn', p));

de = [];
for k=1:5
    [~,e] = read_file(strcat('C:\Users\pasan\Desktop\ENEE630_F2022_TXsim\Input', p),k,1);
    de = [de e'];
end

figure;
plot(1:length(dd),abs(dd),'r-',1:length(de),abs(de),'b--');
title('decoded and original data - time domain');
legend('decoded data','original data');

figure;
subplot(2,1,1);
plot(abs(fft(dd,128))/5120,'r-');
title('decoded data - dft');
subplot(2,1,2);
plot(abs(fft(de,128))/5120,'r-');
title('original data - dft');

fprintf('test MSE: %f\n',MSE(dd,de,0,0,0))

