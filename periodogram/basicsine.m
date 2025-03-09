addpath('../lec8'); % For PERIODOGRAMRAW
addpath('../m');    % For PLOTCMDS

y = [0 1 0 -1]';

[I,f,a,b,a0] = periodogramraw(y);
I
f
a0
a
b


figure(1);
plot(y,'.','MarkerSize',30);grid on;
ylabel('y');
xlabel('t');
plotcmds('./figures/basicsine_timeseries');

figure(2);
stem(f,I,'filled');grid on;
text(0.05,2.5,sprintf('a_0=%.1f, a_1=%.1f, a_2=%.1f',a0,a'));
text(0.05,2.75,sprintf('b_1=%.1f, b_2\\equiv %.1f',b'));
axis([-0.1 0.6 0 3]);
ylabel('I (Raw Periodogram)');
xlabel('f');
plotcmds('./figures/basicsine_periodogram');


