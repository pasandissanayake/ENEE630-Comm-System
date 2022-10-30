function [in, out] = polyphase_comb(x)
    H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
    H0 = [H0; [2048 zeros(1,30)]];
    H1 = H0; H1(1,16) = -1024;
    
    F0 = H0;
    F1 = H1;

    out = polyphase_rx(polyphase_tx(x,H0,H1),F0,F1);

    in = x(62:end-30);
    out = out(62+30:end);
end