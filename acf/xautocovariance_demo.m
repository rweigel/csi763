clear
N = 100;
x = randn(N,1);
x = x-mean(x); % Wilks' formula requires this, so need for comparison.

% For large N, answers are close for small lags.

c1 = xautocovariance(x); % Re-implementation of MATLAB formula w/o using
                         % FFT to speed up calculation.
c2 = xcorr(x);
c3 = acf(x);
c2 = c2(N:end);

% Wilks' formula requires at least two points (to compute last standard
% deviation in denominator).
c1 = c1(1:end-1);
c2 = c2(1:end-1);

% Normalize
c1 = c1/c1(1);
c2 = c2/c2(1);

% Compare results after making vectors the same length
l = [0:length(c3)-1];
figure(1);clf
plot(l,c1,'r.','MarkerSize',20);
hold on;
plot(l,c2,'g','LineWidth',3);
grid on;
plot(l,c3,'b','LineWidth',2);
legend('Re-implementation of MATLAB XCORR',...
    'MATLAB XCORR','Wilks formula');
xlabel('Lag');
ylabel('ACF');
print -dpng xautocovariance_demo1.png
print -depsc xautocovariance_demo1.png

fprintf('max(abs(error of reimplementation - XCORR))/eps: %.1f\n',max(abs(c1-c2))/eps);
% Typical value is less than 1.0

break

figure(2);clf
plot(l,c3-c2,'b','LineWidth',3);
hold on;
grid on;
plot(l,c1-c2,'r','LineWidth',2);
legend('Wilks ACF - ACF based on MATLAB XCORR',...
        'ACF based on re-implementation of MATLAB XCORR - ACF based on MATLAB XCORR');
xlabel('Lag')
print -dpng xautocovariance_demo2.png
print -depsc xautocovariance_demo2.png
