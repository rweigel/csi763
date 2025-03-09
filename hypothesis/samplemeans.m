function samplemeans()
N1 = 100;
N2 = 100; 

% (a)
y1 = randn(N1,1);
y2 = randn(N2,1);

% (b)
% Yes, as given by the MATLAB Help, the data are created by a process
% with mean of zero and standard deviation of 1.  (There are many
% processes that can create such data.  This is a topic covered in the
% field of random number generation).

% (c)
y1m = mean(y1);
y2m = mean(y2);

% (d) 
sy1 = std(y1);
sy2 = std(y2); 

% (e)
D = y2-y1;

% (f)
% Yes, the sum of normally distributed variables is also normally distributed.

% (g)
sD = (1/(N1+N2-2))*(sy1^2 + sy2^2);

% (h)
M = 1000;
for i = 1:M
  y1 = randn(N1,1);
  y2 = randn(N2,1);
  y1m = mean(y1);
  y2m = mean(y2);

  sy1 = std(y1);
  sy2 = std(y2);

  D = y2-y1;
  nD(i) = sum(D>2);
  mD(i) = mean(D);
end
% How often?
sum(nD)/(M*N1)

% Expected
erfc(1)/2

% (i) Create 1000 bootstrap vectors y1b and y2b by resampling y1 and y2
% _with_ replacement.  For each bootstrap vector b, compute D =
% y2b-y1b.   
for b = 1:M
  y1b = randsample(y1,100,'true');
  y2b = randsample(y2,100,'true'); 
  Db = y2b-y1b;
  nD(b) = sum(Db>2);
end

sum(nD)/(M*N1)
