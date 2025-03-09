clear;
addpath('../m');
addpath('../lec8');

N  = 10^3;
t  = [0:N-1]';
f1 = (N/100)/N;

for run = 1:3
if (run == 1)
  x1 = 0.0*randn(N,1);
  x2 = 0.5*sin(2*pi*f1*t);
end
if (run == 2)
  x1 = 1.0*randn(N,1);
  x2 = 0.0*sin(2*pi*f1*t);
end
if (run == 3)
  x1 = 1.0*randn(N,1);
  x2 = 0.5*sin(2*pi*f1*t);
end

x2(1:400) = 0;
x2(501:end) = 0;
x = x1+x2;

figure(1);clf
plot(t,x+4,'b','LineWidth',1);hold on;grid on;
plot(t,x1,'r','LineWidth',1);
plot(t,x2,'k','LineWidth',2);
legend('Signal+Noise (shifted + 4)','Noise','Signal');
grid on;
xlabel('t (time step)');
ylabel('x (Amplitude)');
axis([0 1000 -2 8])
plotcmds(sprintf('./figures/lec12_sin_blip_run_%d',run));

figure(2);clf
[I,f] = periodogramraw(x);hold on;grid on;
[Ir,fr] = periodogramraw(x(401:500)); 
plot(f,I,'r');
plot(fr,Ir,'k','LineWidth',2);
legend('All data','x(401:500) only')
xlabel('frequency');
ylabel('Raw periodogram');
axis([0 0.5 0 14])
plotcmds(sprintf('./figures/lec12_periodogram_run_%d',run));

figure(3);clf
[I,f] = periodogramraw(x);hold on;grid on;
[Ir,fr] = periodogramraw(x(401:500)); 
plot(f,I,'r');
plot(fr,Ir,'k','LineWidth',2);
axis([0 0.03 0 2])
legend('All data','x(401:500) only')
xlabel('frequency');
ylabel('Raw periodogram');
plotcmds(sprintf('./figures/lec12_periodogram_zoom_run_%d',run));

for i = 1:10
  a = 1+100*(i-1);
  b = a+99;
  tr(i) = a+50-1;
  [Ir,fr] = periodogramraw(x(a:b)); 
  Sr(:,i) = Ir;
end
figure(4);clf;
pcolor(tr,fr,Sr);   
axis xy; axis tight; colormap(jet);
ylabel('Frequency');
xlabel('t (time step)');
colorbar;
plotcmds(sprintf('./figures/lec12_spectrogram_run_%d',run));

Nover  = length(find(Sr(:)>9.21));
Ntotal = length(Sr(:));

figure(5);clf;
[nx,x] = hist(Sr(:),[0:1:80]);
bar(x,nx);grid on;
set(gca,'XLim',[-1,20])
ylabel('Number in bin');
xlabel('Amplitude');
title(sprintf('%d of %d (%.2f%%) over 9.21',Nover,Ntotal,100*Nover/Ntotal));
plotcmds(sprintf('./figures/lec12_spectrogram_histogram_run_%d',run));
end

