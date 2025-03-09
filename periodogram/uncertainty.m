clear;
N  = 10^3;
t  = [0:N-1]';
f1 = (N/10)/N;


A   = 30;   % Periodic signal amplitude
run = 1;    % Noise only, no signal
run = 2;    % Signal at 0.1 Hz with amplitude A/100
Np  = 1000; % Length of time series.
d   = 3;    % d frequencies to left and right of 0.1 Hz

for i = 1:Np
  x = randn(N,1);
  if run == 2
    x = x + (A/100)*sin(2*pi*f1*t);
  end
  [I,f,a,b,a0] = periodogramraw(x,'fast');
  Iall(:,i) = I';
end

ifr   = setdiff([1:size(Iall,1)],[101-d:101+d,201-d:201+d]);

ifr   = [2:length(I)-1]'; % Remove DC component.
fr    = f(ifr);
Iallr = Iall(ifr,:);

figure(1);clf;
    plot(x);grid on;
    xlabel('t (time step)')
    ylabel('x');
    if (run == 1)
      title(sprintf('x = randn(%d,1)',N));
    else
      title(sprintf('x = randn(%d,1) + (%d/100)*sin(2\\pi*%.2f t)',N,A,f1));
    end
    plotcmds(sprintf('figures/uncertainty_N_%d_A_%d_run_%d_tseries',N,A,run));

    
fk = [1:99,101:size(Iall,1)];
[Nx,x] = hist(mean(Iall(fk,1))./Iall(fk,1),[0.01:0.01:40]);
%hist(2./Iall(100,:),logspace(0,3));
hold on;grid on;
y = cumsum(Nx)/sum(Nx);
a = find(y-0.025 > 0);
b = find(y-0.975 > 0);
lbt = Iallr(100,1)/3.69;
lb = Iallr(100,1)*x(a(1));
Ix = length(find(Iallr(:,1)>lb))/size(Iallr,1)

figure(2);clf
    Iallrm = mean(Iallr,2);
    plot(fr,Iallrm,'k','LineWidth',3);hold on;
    plot(fr,Iallr(:,1));grid on;
    plot(fr(100),Iallr(100,1),'.','MarkerSize',20);
    plot([fr(1) fr(end)],[lbt,lbt],'g-');
    plot([fr(1) fr(end)],[lb,lb],'k-');
    xlabel('frequency');
    ylabel('I(f)');
    title(sprintf('x = randn(%d,1) + (%d/100)*sin(2\\pi*%.2f t)',N,A,f1));

    if (run == 1)
        legend(sprintf('Average of %d batches (std=%.1f)',Np,std(Iallrm)),...
               sprintf('Periodogram of single batch (std=%.1f)',std(Iallr(:,1))),...
               'Peak of single batch at 0.1 Hz');
    else
        legend(sprintf('Average of %d batches',Np),...
               sprintf('Periodogram of single batch'),...
               'Peak of single batch at 0.1 Hz',...
               'Lower bound on error bar (using formula)',...
               'Lower bound on error bar (empirically derived)');
    end  
    plotcmds(sprintf('figures/uncertainty_N_%d_A_%d_run_%d_periodogram',N,A,run));


break
figure(3);clf;
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

break

figure(5);clf
[N,x] = hist(mean(Iall(101,:))./Iall(101,:),[0.01:0.01:40]);
%hist(2./Iall(100,:),logspace(0,3));
hold on;grid on;
y = cumsum(N)/sum(N);
a = find(y-0.025 > 0);
b = find(y-0.975 > 0);
x(a(1))
x(b(1))

plot(x,y);grid on;
plot([x(1),x(end)],[0.025,0.025],'k-');
plot([x(1),x(end)],[0.975,0.975],'k-');
xlabel('I(f=0.1)');
ylabel('Number in bin');

