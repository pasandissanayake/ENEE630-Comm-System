fprintf("interleaver MSE: %f\n",MSE(@interleave,0,0,1000,1024));
function [x, y]=interleave(in_sig)
    x = in_sig;
    y = interleaver_tx(interleaver_rx(in_sig));
end