y = [0 1 0 -1 0 1 0 -1 0]';
[If,f] = periodogramraw(y,'fast');
[Is,f,a,b,a0] = periodogramraw(y);
max(abs(If-Is))

for N = 4:100
  y = randn(N,1);
  [If,f] = periodogramraw(y,'fast');
  
  [Is,f,a,b,a0] = periodogramraw(y);
  max(abs(If-Is))
end

