clear;

z = ones(11,1);
z = rand(12,1);
z = sin(2*pi*[0:0.1:1]');   % (A)
z = sin(2*pi*[0.1:0.1:1]'); % (B)
% Question: Why is there a difference between (A) and (B)
% Answer: (A) is not symmetric.

% Data from Table 2.3, Box, Jenkins, and Reinsel, 1994
z = [3.4,4.5,4.3,8.7,13.3,13.8,16.1,15.5,14.1,8.9,7.4,3.6]';
zbar = mean(z);
N    = length(z);
t    = [1:N]';
c    = xautocovariance(z);

I1 = xpsd1(z);
I2 = xpsd2(c,zbar);
I3 = (2/N)*(fft(z).*conj(fft(z)));

% Notice the change in parenthesis placement results in complex I4 (whereas
% I3 is real).
I4 = (2/N)*fft(z).*conj(fft(z)); 

if (round(N/2) == N/2) % N is even
  q = N/2-1;
else
  q = (N-1)/2;
end
f = [0:q]'/N;

fprintf('Three methods of computing spectrum\n');
I = [I1(1:q+1),I2(1:q+1),I3(1:q+1)]

for i = 2:size(I,2)
  d(1,i) = max(abs(I(:,1)-I(:,i)))/eps;
end
fprintf('max(abs(diff))/eps in coefficients from first column.\n');
d
