DIRECTORY = 'C:\Users\pasan\Desktop\ENEE630_F2022_TXsim';
FILE_SUFFIX = 'GroupID_1A_FreqID_10_SNR_-7.000000_Foff_0.000000_Nframe_5_Nstart_1_0.txt';

GROUP_ID = 0x1A;

[H0,H1,F0,F1] = filter_def();

oin = []; ooo = []; bbb = [];
for k=1:5
    [~,a] = read_block(strcat(DIRECTORY,'\Rn_',FILE_SUFFIX),k,0);
    ooo = [ooo; a];
    bbb = [bbb; a-mean(a)];
    [~,b] = read_block(strcat(DIRECTORY,'\Input_',FILE_SUFFIX),k,1);
    txi = interleaver_tx(scrambler(polyphase_tx(b',H0,H1),GROUP_ID,k));
    oin = [oin; txi'];
end

figure;
plot(1:length(oin),(oin),'r-',1:length(ooo),(ooo),'b--',1:length(bbb),bbb,'g--');
legend('our tx','simulator tx','mean corrected sim tx');