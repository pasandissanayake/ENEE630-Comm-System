global H0 H1 F0 F1
H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;

F0 = H0;
F1 = H1; %F1(1,:) = -F1(1,:);

dd = Top_level_read_file('C:\Users\pasan\Desktop\ENEE630_F2022_TXsim\Rn_GroupID_0_FreqID_10_SNR_100.000000_Foff_0.000000_Nframe_5_Nstart_0.txt',F0,F1);

de = [];
for k=1:5
    [a,e] = read_file('C:\Users\pasan\Desktop\ENEE630_F2022_TXsim\Input_GroupID_0_FreqID_10_SNR_100.000000_Foff_0.000000_Nframe_5_Nstart_0.txt',k,1);
    de = [de e'];
end

plot(1:length(dd),abs(dd),'r-',1:length(de),abs(de),'b--')

figure;
subplot(2,1,1);
plot(abs(fft(dd,2^13))/5120,'r-');
subplot(2,1,2);
plot(abs(fft(de,2^13))/5120,'r-');



fprintf('test MSE: %f\n',MSE(dd,de,0,0,0))