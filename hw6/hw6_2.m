clear
addpath('../m');

n = 10^3;
N = 10^5;

alpha = 1;
beta  = 1;

ep = randn(N,1);
xp = [1:N]';
%xp = [1:N]'/N; % Problem statement should have been this
yp = alpha+beta*xp+ep;

% 6.2.1
z = randsample(N,n);
xs = xp(z);
ys = yp(z);
  
% 6.2.2
[a,b] = linreg(xs,ys);

% 6.2.3
M = 10000;
for j = 1:M
  z = randsample(N,n,'true');
  xs = xp(z);
  ys = yp(z);
  [a(j),b(j)] = linreg(xs,ys);
end

% 6.2.4
figure(1);clf;
hist(a-alpha,50);grid on;
axis([-0.25 0.25 0 800]);
xlabel('a-\alpha');
ylabel('Number in bin');
title(sprintf('M=%.0e, mean(a-\\alpha)=%.1e, std(a-\\alpha)=%.1e',...
	      M,mean(a-alpha),std(a-alpha)));
plotcmds('./figures/hw6_2_4a');

figure(2);clf
hist(b-beta,50);grid on;
axis([-6e-6 6e-6 0 800]);
xlabel('b-\beta');
ylabel('Number in bin');
title(sprintf('M=%.0e, mean(b-\\beta)=%.1e, std(b-\\beta)=%.1e',...
	      M,mean(b-beta),std(b-beta)));
plotcmds('./figures/hw6_2_4b');

% 6.2.5
figure(3);clf;
I = find(a-alpha>0);
hist(b(I)-beta,50);grid on;
axis([-6e-6 6e-6 0 400]);
xlabel('b-\beta when a-\alpha>0');
ylabel('Number in bin');
plotcmds('./figures/hw6_2_5');




