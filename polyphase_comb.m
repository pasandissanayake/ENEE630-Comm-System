clear all;

fprintf("polyphase MSE sine: %f\n",MSE(@polyphase,1,0,5000,1024));
fprintf("polyphase MSE rand: %f\n",MSE(@polyphase,0,1,5000,1024));

function [in_sig, out_sig] = polyphase(x)
    [H0 H1 F0 F1] = filter_def();

    out_sig = polyphase_rx(polyphase_tx(x,H0,H1),F0,F1);
    in_sig = x;
end