clear;
addpath('../m');

N = 10000;
y = randn(N,1);

[I,f] = periodogramraw(y); 

figure(1);
plot(y);
title(sprintf('y=randn(%d,1)',N));
xlabel('time step');
ylabel('y');
plotcmds(sprintf('./figures/noisyperiodogram_y_N_%d',N));

figure(2);
plot(f,I);
title(sprintf('Raw periodogram of y=randn(%d,1)',N));
xlabel('frequency');
ylabel('Raw periodogram');
plotcmds(sprintf('./figures/noisyperiodogram_I_N_%d',N));

