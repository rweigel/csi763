clear;
addpath('../lec8');

N  = 10^3;
t  = [0:N-1]';
f1 = (N/100)/N;
x  = randn(N,1)+0.5*sin(2*pi*f1*t)+5*t/N;
x  = (x-mean(x))/std(x);
dx = [0;diff(x)];

figure(1);clf
plot(t,x);hold on;
grid on;
title(sprintf('x(t) = rand(%d,1)+1*t/%d+0.1*sin(2\\pi%.2f t)',N,N,f1));
xlabel('t (time step)');
ylabel('x(t)');
plotcmds('./figures/lec9_prewhiten_tseries_x');

figure(2);clf
plot(t,dx);hold on;
grid on;
title(sprintf('dx(t)=x(t+1)-x(t)'));
xlabel('t (time step)');
ylabel('dx(t)');
plotcmds('./figures/lec9_prewhiten_tseries_dx');

figure(3);clf;
[I,f] = periodogramraw(x);
plot(f(1:end),I(1:end));hold on;grid on;
title('Raw Periodogram of x(t)');
xlabel('frequency');
ylabel('I(f)');
axis([0 0.1 0 500]);
plotcmds('./figures/lec9_prewhiten_periodogram_x');

figure(4);clf;
[I,f] = periodogramraw(x);
plot(f(1:end),I(1:end));hold on;grid on;
title('Raw Periodogram of x');
xlabel('frequency');
ylabel('I(f)');
axis([0.005 0.015 0 30]);
plotcmds('./figures/lec9_prewhiten_periodogram_zoom_x');

figure(5);clf;
[I,f] = periodogramraw(dx);
plot(f,I);hold on;
grid on;
title('Raw Periodogram of dx(t)=x(t+1)-x(t)');
xlabel('frequency');
ylabel('I(f)');
axis([0 0.1 0 0.5]);
plotcmds('./figures/lec9_prewhiten_periodogram_dx');

figure(6);clf;
[I,f] = periodogramraw(dx);
plot(f,I);hold on;
grid on;
title('Raw Periodogram of dx(t)=x(t+1)-x(t)');
xlabel('frequency');
ylabel('I(f)');
axis([0.005 0.025 0 0.30]);
plotcmds('./figures/lec9_prewhiten_periodogram_zoom_dx');

