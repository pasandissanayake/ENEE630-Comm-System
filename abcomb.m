global H0 H1 F0 F1
H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;

F0 = H0;
F1 = H1; %F1(1,:) = -F1(1,:);

fprintf("combined MSE: %f\n",MSE(1000,1024,@comb,0,0));

function [in_sig, rx_sig] = comb(x)
    global H0 H1 F0 F1
    
    id = 0x1A;
    frame = 1;
    tx_sig = interleaver_tx(scrambler(polyphase_tx(x,H0,H1),id,frame));
    rx_sig = polyphase_rx(scrambler(interleaver_rx(tx_sig),id,frame),F0,F1);
    in_sig = x(1:814);
end