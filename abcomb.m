fprintf("combined MSE: %f\n",MSE(@comb,0,0,5000,1024));

function [in_sig, rx_sig] = comb(x)
    [H0,H1,F0,F1] = filter_def();
    
    id = 0x1A;
    frame = 1;
    tx_sig = interleaver_tx(scrambler(polyphase_tx(x,H0,H1),id,frame));
    rx_sig = polyphase_rx(scrambler(interleaver_rx(tx_sig),id,frame),F0,F1);
    in_sig = x;
end