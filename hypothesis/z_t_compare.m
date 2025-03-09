clear;
N  = 100;
Nr = 100;
for i = 1:Nr
  x    = randn(N,1);
  t(i) = mean(x)/(std(x)/sqrt(N));
end

figure(1);
z     = [-6:0.5:6]';
[n,x] = hist(t,z);
clf;grid on;hold on;
bar(z,n/sum(n))
p = (0.5/sqrt(2*pi))*exp(-(z.^2)/2);
plot(z,p,'k.','MarkerSize',20)
legend(sprintf(' t (N=%d)',Nr),' gaussian pdf');
title(sprintf('Distribution of t computed using %d samples from gaussian',N));
xlabel('t');
ylabel('p(t)');
plot(z,p,'k');
plotcmds(sprintf('z_t_compare_N-%d_Nr-%d',N,Nr));
