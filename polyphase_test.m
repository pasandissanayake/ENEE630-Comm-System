clear all;

T=1; w = pi/4;
t=[0:T:100];
xsig=cos(w*t/T) + 1.5*cos(3*w*t/T);
%%

H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [1 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;
freqz(H1(1,:),H1(2,:))
ysigs=polyphase_tx(xsig, H0, H1);


%%
figure;

Lsig=length(xsig);
Lfft=2^ceil(log2(Lsig)+1);
Fmax=1;
Faxis=linspace(-Fmax,Fmax,Lfft);
Xsig=fftshift(fft(xsig,Lfft));
plot(Faxis,abs(Xsig));
hold on;

Ysig1=fftshift(fft(ysigs(1,:),Lfft));
plot(Faxis,abs(Ysig1)/1000,'r--');
hold on;

Ysig2=fftshift(fft(ysigs(2,:),Lfft));
plot(Faxis,abs(Ysig2)/1000,'g--');
hold off;

%%
figure;
plot(t,xsig,'k',t,ysigs(1,:)/1000,'r--',t,ysigs(2,:)/1000,'g--');
