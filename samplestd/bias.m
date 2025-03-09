clear;
% The population is the numbers 1 through 100.
X = [1:100];                 
% The test statistic computed using population
a = (1/100)*sum((X-mean(X)).^2);
% A sample
x = randsample(100,10,true); 
% The test statistic computed using sample
b = (1/10)*sum((x-mean(x)).^2);

fprintf('a = %.2f, b = %.2f\n',a,b);

n = 4;
for i = 1:10^n
  x = randsample(100,10,true);    % A sample
  b = (1/10)*sum((x-mean(x)).^2); % un-biased estimate
  bu = (1/9)*sum((x-mean(x)).^2); % biased estimate
  B(i) = b;
  Bu(i) = bu;
end
figure(1);clf
 hist(B,100);hold on;grid on;
 yt = get(gca,'YTick');
 plot([a,a],[0,yt(end)+100],'k-.','LineWidth',4);hold on;
 plot([mean(Bu),mean(Bu)],[0,yt(end)+100],'g-','LineWidth',2);
 plot([mean(B),mean(B)],[0,yt(end)+100],'b-','LineWidth',2);

 %title(sprintf('Histogram of biased for 10^%d batches',n));
 xlabel('statistic value')
 ylabel('Number in bin')
 legend('s_b^2','\sigma^2',...
	'ave of s^2',...
	'ave of s_b^2');
 grid on;
 plotcmds('bias');
 mean(B)/mean(Bu)
