addpath('../acf'); % For xautocovariance.m

N = 10^3;

phi1 = 0.7;
phi2 = -0.2;
x(1) = 0;
x(2) = 0;

for t = 2:N-1
  x(t+1) = phi1*x(t) + phi2*x(t-1) + randn(1);
end

if exist('xcorr')
  ac = xautocovariance(x); % Slow method
  r1 = ac(2)/ac(1)
  r2 = ac(3)/ac(1)

  AC = xcorr(x-mean(x),x-mean(x),'biased'); % Fast method
  r1 = AC(N+1)/AC(N)
  r2 = AC(N+2)/AC(N)
else
  ac = xautocovariance(x); % Slow method
  r1 = ac(2)/ac(1)
  r2 = ac(3)/ac(1)
end

phi1e = (r1*(1-r2))/(1-r1*r1)
phi2e = (r2-r1*r1)/(1-r1*r1)

