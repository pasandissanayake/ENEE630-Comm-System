disp("onestagepp MSE: " + MSE(@onestagepp,1,1,1000,1024));

function [in, out] = onestagepp(x)
    [H0,H1,F0,F1] = filter_def();
    out = onestagepp_rx(onestagepp_tx(x,H0,H1),F0,F1);
    in = x;
end