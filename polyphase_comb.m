clear all;

global H0 H1 F0 F1
H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;

F0 = H0;
F1 = H1; % F1(1,:) = -F1(1,:);

fprintf("polyphase MSE sine: %f\n",MSE(1000,1024,@polyphase,1,1));
fprintf("polyphase MSE rand: %f\n",MSE(1000,1024,@polyphase,0,0));

function [in_sig, out_sig] = polyphase(x)
    global H0 H1 F0 F1

    out_sig = polyphase_rx(polyphase_tx(x,H0,H1),F0,F1);
    in_sig = x;
end