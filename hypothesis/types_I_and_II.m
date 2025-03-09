rI = randn(10000,1);
rII = 1+randn(10000,1);

dx = 0.1;
[NI,XI]   = hist(rI,[-4:dx:4]);
[NII,XII] = hist(rII,[-4:dx:4]);
figure(1);clf;orient landscape
s = std(rI);
stairs(XI,NI,'r','LineWidth',3);hold on;grid on;
dx = 0.05;
x = [-4:dx:4];
fx = exp(-(x).^2/2);
plot(x,max(NI)*fx/max(fx),'r','LineWidth',2);
ylabel('Number in bin');
xlabel('statistic value');
plot([1 1],[0,600],'k')
legend('Parametric estimation of test statistic histogram',...
       'Nonparametric estimation',...
       'Rejection line','Location','NorthWest');
plotcmds('typeI');
!convert -rotate 90 typeI.png typeIr.png

figure(2);clf;;orient landscape
stairs(XI,NI,'r','LineWidth',3);hold on;grid on;
fx = exp(-(x).^2/2);
plot(x,max(NII)*fx/max(fx),'r','LineWidth',2);
stairs(XII,NII,'g','LineWidth',3);
plot([1 1],[0,600],'k')
legend('Nonparametric estimate of test statistic histogram',...
       'Nonparametric estimation',...
       'Population histogram',...
       'Rejection line','Location','NorthWest');
ylabel('Number in bin');
xlabel('statistic value');
plotcmds('typeII');
!convert -rotate 90 typeII.png typeIIr.png