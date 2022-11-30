function [H0,H1,F0,F1] = filter_def()
% OUTPUTS:    Filters for the polyphase filter bank. Each filter is a 2xN array 
%             with denominator and numerator in each row (N = filter order-1)
    
% H0, H1 as given in the specification
H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;

% Option II
F0 = H0;
F1 = H1; 

% For option I, uncomment below line
% F1(1,:) = -F1(1,:);
end