clear;
addpath('../m');
addpath('../lec8');

N  = 10^3;
t  = [0:N-1]';
f1 = (N/100)/N;
f2 = (N/8)/N;

x1 = 1.0*sin(2*pi*f1*t);
x2 = 1.0*sin(2*pi*f2*t);

Iz1     = [1:400,501:N];
Iz2     = [1:400,409:N];
x1(Iz1) = 0;
x2(Iz2) = 0;
x = x1+x2;

figure(1);clf
plot(t,x+4,'b','LineWidth',1);hold on;grid on;
plot(t,x1,'r','LineWidth',2);
plot(t,x2,'k','LineWidth',1);
legend('Signal 1+2','Signal 1 (T=100)','Signal 2 (T=8)');
grid on;
xlabel('t (time step)');
ylabel('x (Amplitude)');
axis([0 1000 -2 8])
plotcmds(sprintf('./figures/lec12_sin_blip_twofreq'));

figure(2);clf
plot(t,x+4,'b','LineWidth',1);hold on;grid on;
plot(t,x1,'r','LineWidth',2);
plot(t,x2,'k','LineWidth',1);
legend('Signal 1+2','Signal 1 (T=100)','Signal 2 (T=8)');
grid on;
xlabel('t (time step)');
ylabel('x (Amplitude)');
axis([350 550 -2 8])
plotcmds(sprintf('./figures/lec12_sin_blip_twofreq_zoom'));

figure(3);clf
[I,f] = periodogramraw(x);hold on;grid on;
[Ir,fr] = periodogramraw(x(401:500)); 
plot(f,I,'b');
plot(fr,Ir,'r','LineWidth',2);
legend('All data','x(401:500) only')
xlabel('frequency');
ylabel('Raw periodogram');
plotcmds(sprintf('./figures/lec12_sin_blip_twofreq_periodogram'));

figure(4);clf
[I,f] = periodogramraw(x);hold on;grid on;
[Ir,fr] = periodogramraw(x(401:500)); 
plot(f,I,'b');
plot(fr,Ir,'r','LineWidth',2);
legend('All data','x(401:500) only')
xlabel('frequency');
ylabel('Raw periodogram');
axis([0 0.5 0 0.5])
plotcmds(sprintf('./figures/lec12_sin_blip_twofreq_periodogram_zoom'));

figure(5);clf
[I,f] = periodogramraw(x);hold on;grid on;
[Ir,fr] = periodogramraw(x(401:408)); 
plot(f,I,'b');
plot(fr,Ir,'k','LineWidth',2);
legend('All data','x(401:408) only')
xlabel('frequency');
ylabel('Raw periodogram');
plotcmds(sprintf('./figures/lec12_sin_blip_twofreq_periodogram2'));

figure(6);clf
[I,f] = periodogramraw(x);hold on;grid on;
[Ir,fr] = periodogramraw(x(401:408)); 
plot(f,I,'b');
plot(fr,Ir,'k','LineWidth',2);
legend('All data','x(401:408) only')
xlabel('frequency');
ylabel('Raw periodogram');
axis([0 0.5 0 0.5])
plotcmds(sprintf('./figures/lec12_sin_blip_twofreq_periodogram2_zoom'));

for i = 1:10
  a = 1+100*(i-1);
  b = a+99;
  tr(i) = a+50-1;
  [Ir,fr] = periodogramraw(x(a:b)); 
  Sr(:,i) = Ir;
end

figure(7);clf;
pcolor(tr,fr,log10(Sr));   
axis xy; axis tight; colormap(jet);
ylabel('Frequency');
xlabel('t (time step)');
colorbar;caxis([-2 1]);
title('log_{10} of raw spectrogram amplitudes for all data')
plotcmds(sprintf('./figures/lec12_sin_blip_twofreq_spectrogram'));
