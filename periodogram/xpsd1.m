function [I,a,b,a0] = xpsd1(x)
%XPSD1 Compute PSD using standard method
%
%   [I,a,b,a0] = PSD(x)
%
%   See also XPSD2.
  
N  = size(x,1);
a0 = mean(x);
x  = x-a0;
t  = [1:N]';

if (round(N/2) == N/2) % N is even
  q = N/2-1;
  for i = 1:q
    fi = i/N;
    ci = cos(2*pi*fi*t);
    si = sin(2*pi*fi*t);
    a(i,1) = (2/N)*sum(x.*ci);
    b(i,1) = (2/N)*sum(x.*si);
  end
  I = a.*a + b.*b;
  a(i+1) = (1/N)*sum(x.*((-1).^t));
  b(i+1) = 0;
  I = (N/2)*[a0*a0*2*2; I];
end

if (round(N/2) ~= N/2) % N is odd
  q = (N-1)/2;
  for i = 1:q
    fi = i/N;
    ci = cos(2*pi*fi*t);
    si = sin(2*pi*fi*t);
    a(i,1) = (2/N)*sum(x.*ci);
    b(i,1) = (2/N)*sum(x.*si);
  end
  I = a.*a + b.*b;
  I = (N/2)*[a0*a0*2*2; I];
end


