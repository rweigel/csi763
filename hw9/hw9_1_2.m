clear;
addpath('../lec8');

N  = 10^3;
t  = [0:N-1]';
f1 = (N/10)/N;
f2 = (N/5)/N;
x  = 2*randn(N,1)+sin(2*pi*f1*t)+sin(2*pi*f2*t);
dx = [0;diff(x)];

figure(1);clf
plot(t,x);hold on;
grid on;
title(sprintf('x(t) = 2*rand(%d,1)+sin(2\\pi%.1f t)+sin(2\\pi%.1f t)',N,f1,f2));
xlabel('t (time step)');
ylabel('x(t)');
plotcmds('./figures/hw9_1_2_timeseries');

figure(2);clf;
[I,f] = periodogramraw(x);
plot(f,I);hold on;grid on;
botlim = 2*I/7.38; % 
toplim = 2*I/0.0505;
%errorbar(f,I,botlim,toplim);
title('Raw Periodogram of x');
xlabel('frequency');
ylabel('I(f)');
plotcmds('./figures/hw9_1_2_periodogram_x');


figure(3);clf;
[I,f] = periodogramraw(dx);
plot(f,I);hold on;
grid on;
title('Raw Periodogram of x(t+1)-x(t)');
xlabel('frequency');
ylabel('I(f)');
plotcmds('./figures/hw9_1_2_periodogram_dx');

