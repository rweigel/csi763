clear;
addpath('../m');    % For PLOTCMDS
No   = 1e2;
k = 1;

for i = 1:10:1000

  N(k) = i*No;
  x   = randn(N(k),1);
  
  I = periodogramraw(x,'fast');

  Na = length(find(I(2:end-1)>9.21));
  
  R(k) = 1-Na/N(k);
  fprintf('N=%.2e, Fraction above = %.8d\n',N(k),R(k));
  
  k = k+1;
end

figure(1);clf;
plot(log10(N),R);grid on;hold on;
ylabel('Fraction below 9.21');
xlabel('log10(length of time series)');
plotcmds('./figures/periodogramdist');