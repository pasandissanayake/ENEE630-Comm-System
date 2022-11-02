clear all;

T=1; w = pi/100;
t=0:T:1023;
xsig=cos(w*t/T) + 1.5*cos(3*w*t/T);
%%

H0 = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 -45 0 21 0 -8 0 3 0 -1];
H0 = [H0; [2048 zeros(1,30)]];
H1 = H0; H1(1,16) = -1024;
figure;
freqz(H0(1,:),H0(2,:));
hold on;
freqz(H1(1,:),H1(2,:));
ysigs=polyphase_tx(xsig, H0, H1);

F0 = H0;
F1 = H1;
%F1(1,:) = -F1(1,:);
wsig = polyphase_rx(ysigs, F0, F1);

figure;
TZ = dfilt.parallel(dfilt.cascade(dfilt.df1(H0(1,:),H0(2,:)), dfilt.df1(F0(1,:),F0(2,:))), dfilt.cascade(dfilt.df1(H1(1,:),H1(2,:)), dfilt.df1(F1(1,:),F1(2,:))));
[p, q] = TZ.tf;
freqz(p,q*2,'whole');

%%

AZ = dfilt.cascade(dfilt.df1(H0(1,:),H0(2,:)), dfilt.df1(H1(1,:),H1(2,:)));
[p, q] = AZ.tf;
freqz(p,q*2,'whole');


%%
figure;

Lsig=length(xsig);
Lfft=2^ceil(log2(Lsig)+1);
Fmax=1;
Faxis=linspace(-Fmax,Fmax,Lfft);
Xsig=fftshift(fft(xsig,Lfft)) / Lsig;
plot(Faxis,abs(Xsig));
hold on;

Ysig1=fftshift(fft(ysigs(1,:),128))/length(ysigs(1,:));
plot(linspace(-Fmax,Fmax,128),abs(Ysig1)/1,'r--');
hold on;

Ysig2=fftshift(fft(ysigs(2,:),128))/length(ysigs(2,:));
plot(linspace(-Fmax,Fmax,128),abs(Ysig2)/1,'g--');
hold off;

figure;
plot(Faxis,abs(Xsig),'k-');
hold on;
Wsig=fftshift(fft(wsig,Lfft))/length(wsig);
plot(Faxis,abs(Wsig),'r--');
hold off;

%%
figure;
plot(t,xsig,'k',t,wsig,'r--');
