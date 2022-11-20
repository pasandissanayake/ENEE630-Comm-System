global H0 H1 F0 F1
H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;

F0 = H0;
F1 = H1; %F1(1,:) = -F1(1,:);

dd = Top_level_read_file('C:\Users\pasan\Desktop\ENEE630_F2022_TXsim\Rn_GroupID_1A_FreqID_10_SNR_100.000000_Foff_0.000000_Nframe_1_Nstart_1.txt',F0,F1);

de = [];
for k=1:5
    [a,e] = read_file('C:\Users\pasan\Desktop\ENEE630_F2022_TXsim\Input_GroupID_1A_FreqID_10_SNR_100.000000_Foff_0.000000_Nframe_1_Nstart_1.txt',k,1);
    de = [de e'];
end

plot(1:length(dd),dd,'r-',1:length(de),de,'b--')

fprintf('test MSE: %f\n',MSE(dd,de,0,0,0))