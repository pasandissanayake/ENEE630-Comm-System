global H0 H1 F0 F1
H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;

F0 = H0;
F1 = H1; % F1(1,:) = -F1(1,:);

[a,oin] = read_file('C:\Users\pasan\Desktop\test_vectors\Input_GroupID_1A_FreqID_10_SNR_100.000000_Foff_0.000000_Nframe_5_Nstart_0.txt',1,1);
[b,ooo] = read_file('C:\Users\pasan\Desktop\test_vectors\Rn_GroupID_1A_FreqID_10_SNR_100.000000_Foff_0.000000_Nframe_5_Nstart_0.txt',1,0);
txi = interleaver_tx(scrambler(polyphase_tx(oin',H0,H1),26,0));

figure;
p = (txi-ooo < 1);
stem(1:1:100,p(1:1:100),'r-')

figure
plot(1:length(txi),txi,'r-',1:length(ooo),ooo,'b--')