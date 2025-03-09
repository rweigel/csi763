clear;
N  = 10^3;
t  = [0:N-1]';
f1 = (N/10)/N;

run = 1;
Np  = 50;
d   = 3;

for i = 1:Np
  x = randn(N,1);
  if run == 2
    x = x + 0.1*sin(2*pi*f1*t);
  end
  [I,f,a,b,a0] = periodogramraw(x);
  Iall(:,i) = I'; % 
end

ifr   = setdiff([1:size(Iall,1)],[101-d:101+d,201-d:201+d]);
ifr   = [2:length(I)-1]';
fr    = f(ifr);
Iallr = Iall(ifr,:);

figure(1);clf;
plot(x);grid on;
xlabel('t (time step)')
ylabel('x');
if (run == 1)
  title(sprintf('x = randn(%d,1)',N));
else
  title(sprintf('x = randn(%d,1) + 0.1*sin(2\\pi*%.2f t)',N,f1));
end
plotcmds(sprintf('figures/uncertainty_run_%d_tseries',run));

if (0)
figure(2);clf
[n,xn] = hist(x,[-4:0.2:4]);
bar(xn,n);grid on;
xlabel('x')
ylabel('Number in bin');
end

figure(3);clf
Iallrm = mean(Iallr,2);
plot(fr,Iallr(:,1));grid on;hold on;
plot(fr,Iallrm,'k','LineWidth',3);
xlabel('frequency');
ylabel('I(f)');
if (run == 1)
legend(sprintf('Periodogram of single batch (std=%.2f)',std(Iallr(:,1))),...
       sprintf('Average of %d batches (std=%.1f)',Np,std(Iallrm)));
else
legend(sprintf('Periodogram of single batch'),...
       sprintf('Average of %d batches',Np));
end  
plotcmds(sprintf('figures/uncertainty_run_%d_periodogram',run));

figure(4);clf;
xb = [0.5:1:15]';
[n,xn] = hist(Iallr(:,1),xb); % First periodogram
%[n,xn] = hist(Iall(2,:),xb);
bar(xn,n/sum(n));hold on;grid on;
x2 = chi2pdf(xb,2);
plot(xb,x2,'k','LineWidth',3);
legend('All I values','\chi^2_{[2]}');
plot(xb,x2,'k.','MarkerSize',26);
ylabel('Probability');
xlabel('I(f) for all f and batches')
% Technically the sampling distribution of the first and last frequencies
% is not chi-squared, so they should be removed.
pu = length(find(Iallr(:) > 7.38))/length(Iallr(:));
pl = length(find(Iallr(:) < 0.0505))/length(Iallr(:));
text(5,0.10,sprintf('%.2f%% above \\chi^2_{[2]}(1-0.05/2)=7.38',pu*100));
text(5,0.20,sprintf('%.2f%% below \\chi^2_{[2]}(0.05/2)=0.505',pl*100));
plotcmds(sprintf('figures/uncertainty_run_%d_periodogram_hist',run));


