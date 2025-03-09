
% Given an sequence of measurements separated by the same amount of time
% y(1),y(2),y(3),y(4),y(5)

% lag 0 comparsison: compute cc(0) correleation between pairs indicated.
% y(1),y(2),y(3),y(4),y(5)
%  |    |   |
% y(1),y(2),y(3),y(4),y(5)

% lag 1 comparsison: compute cc(1) correleation between pairs indicated.
% y(1),y(2),y(3),y(4)
%  |    |    |    |
% y(2),y(3),y(4),y(5)

% lag 2 comparsison: compute cc(2), correleation between pairs indicated.
% y(1),y(2),y(3)
%  |    |    |
% y(3),y(4),y(5)

% lag 3 comparsison: compute cc(3), correleation between pairs indicated.
% y(1),y(2)
%  |    |  
% y(4),y(5)

% lag 4 comparsison: compute cc(4), correleation between pairs indicated.
% y(1)
%  | 
% y(5)

% The ACF is a plot of cc versus lag.

clear;
N = 100;
y = filter(ones(N,1)/N,[1],randn(1000,1));

figure(1);clf;
 plot(y);hold on;grid on;
 ylabel('y');
 xlabel('t');

 lags = [0:10];
 figure(3);clf;
 for lag = lags
    C = corrcoef(y(1:end-lag),y(lag+1:end));
    c(lag+1) = C(2);
   figure(2);clf;
    plot(y(1:end-lag),y(lag+1:end),'.');
    ylabel('y(t)')
    xlabel(sprintf('y(t+%d)',lag));
    title(sprintf('lag = %d | cc = %.2f',lag,C(2)));
    r = max(abs(y));
    axis([-r r -r r]);axis square;
    grid on;
   figure(3);
    plot(lags(1:lag+1),c(1:lag+1));hold on; grid on;
    plot(lags(1:lag+1),c(1:lag+1),'.','MarkerSize',30);hold on; grid on;
    set(gca,'XTick',[0:10]);
    set(gca,'YTick',[-0.6:0.2:1.0]);
    axis([0 10 -0.6 1.0])
    xlabel('lag');
    ylabel('cc');
    %input('Continue');
 end
 