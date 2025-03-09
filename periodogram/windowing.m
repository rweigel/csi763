clear;
addpath('../Lecture5');  % For plotcmds.m 

A = 2;
a = 1;
T = 10;
t = [0:0.1:10.0*T]';
N = length(t);
x = A*sin(2*pi*t/T) + a*rand(N,1);
eqstr = sprintf('A*sin(2*pi*t/T) + a*rand(N,1)');
%y = 0.05*A*sin(2*pi*t/(T*0.6));
%x = x+y;
%x = y;
%x = x.*x;

% 1 (MATLAB FFT)
Im = (2/N^2)*(fft(x).*conj(fft(x)));
fm = [0:N-1]'/N;

% 2 Bartlett's method
m  = 100;
L  = floor(length(t)/m);
xr = reshape(x(1:m*L),m,L);
Ib = (2/m^2)*(fft(xr).*conj(fft(xr)));
Ib = mean(Ib,2);
fb = [0:m-1]'/m;

% 3 Hann window
M = length(x);
t = [0:M-1]';
w = 0.5*(1-cos(2*pi*t/(M-1)));
xh = x.*w;
Ih = (2/N^2)*(fft(xh).*conj(fft(xh)));
fh = [0:N-1]'/N;

% Figure 1
figure(1);clf;grid on;box on;hold on;
plot(t,x,'r');hold on;
plot(t,xh,'b');
legend(['x = ',eqstr],'x Hann windowed')
xlabel('t')
plotcmds('./figures/HW7_P2_tseries');

% Figure 2
figure(2);clf;orient tall;
bm = find(fm>0.019,1,'first');
bb = find(fb>0.019,1,'first');
subplot(2,1,1);grid on;box on;hold on;
plot(fm(1:bm),Im(1:bm),'r.-','MarkerSize',25);
plot(fb(1:bb),Ib(1:bb),'g.-','MarkerSize',20);
plot(fm(1:bm),Ih(1:bm),'b.-','MarkerSize',15);
xlabel('Frequency (1/[unit of t])');
ylabel('Spectrum Estimate of x');
legend('FFT',sprintf('Bartlett L=%d',L),sprintf('Hann'))
subplot(2,1,2);grid on;box on;hold on;
plot(fm(1:bm),log10(Im(1:bm)),'r.-','MarkerSize',25);
plot(fb(1:bb),log10(Ib(1:bb)),'g.-','MarkerSize',20);
plot(fm(1:bm),log10(Ih(1:bm)),'b.-','MarkerSize',15);
axis([0 0.02 -7 1])
xlabel('Frequency (1/[unit of t])');
ylabel('log of Spectrum Estimate of x');
legend('FFT',sprintf('Bartlett L=%d',L),sprintf('Hann'))
plotcmds('./figures/HW7_P2_spectrum');
