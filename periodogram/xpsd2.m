function [I,f] = xpsd2(z)
%XPSD2 Compute PSD using autocovariance coefficients
%
%
%   See also: XPSD1, XAUTOCOVARIANCE.

c  = xautocovariance(z);
zbar = mean(z);
  
N = size(c,1);
if (round(N/2) == N/2) % N is even
  q = N/2-1;
else
  q = (N-1)/2;
end

for i = 0:q
  tmp = 0;
  f(i+1,1) = i/N;
   for k = 1:N-1
     tmp = tmp + c(k+1,1)*cos(2*pi*f(i+1)*k);
   end
   I(i+1,1)  = 2*c(1,:) + 4*tmp;
end

f(1,1) = 0;
I(1,1) = (2*N)*zbar*zbar;
