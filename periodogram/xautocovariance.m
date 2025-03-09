function c = autocovariance(z)
%AUTOCOVARIANCE
%
%   c = AUTOCOVARIANCE(z)
%
%   See also: XPSD1.
  
z = z-mean(z);
N = length(z);
for k=0:N-1
  tmp = 0;
  for t = 1:N-k
    tmp = tmp + z(t)*z(t+k);
  end
  c(k+1,1) = tmp/N;
end

