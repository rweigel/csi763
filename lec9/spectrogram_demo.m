% Example from help on MATLAB (7.0) function CHIRP.  (Note that in MATLAB
% version 7.1 SPECGRAM was replaced with SPECTOGRAM, which plots things in a
% more sensible manner).

addpath('../m');

figure(1);clf;
t = 0:0.001:2.0;             % 2 secs @ 1kHz sample rate
y = chirp(t,0,1,150);        % Start @ DC, cross 150Hz at t=1sec
spectrogram(y,256,250,256,1e3,'yaxis'); % Display the spectrogram
title(['Chirp signal; NFFT=256, '...
       'Fs=1e3, WINDOW=256, and NOVERLAP=250']);
ylabel('Frequency [Hz]');
xlabel('Time [s]');
axis([0 2 0 500])
plotcmds('./figures/spectrogram_plot');

figure(2);clf;
plot(t,y);
title('Chirp signal; f=0 at t=0, f=150 Hz at t=1 sec')
ylabel('Amplitude');
xlabel('Time [s]');
axis([0 2 -1 1])
plotcmds('./figures/spectrogram_tseries');
