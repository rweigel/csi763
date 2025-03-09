
Based on the fact that the autocovariance is very low, and nearly equal, at lags of 7 and 17, I expect both scatter plots to show low and nearly equal correlation.

figure(5)
r = acf(Npd);
plot(r/r(1),'LineWidth',1);
ylabel('Autocovariance function');
xlabel('Lag [days]');
axis([0 1500 -1 1]);
grid on;
plotcmds('Weigel_HW2_P3_ACF1');

figure(4)
plot([1:29],r(2:30)/r(1),'LineWidth',3);hold on
plot([1:29],r(2:30)/r(1),'.','MarkerSize',15);
ylabel('Autocovariance function');
xlabel('Lag [days]');
set(gca(),'XTick',[1:2:30]);
axis([0 30 -0.03 0.5]);
grid on;
plotcmds('Weigel_HW2_P3_ACF2');

figure(3)
stairs(x,cumsum(n/sum(n)),'LineWidth',2);
ylabel('Cumulative probability');
xlabel('# of solar flares measured in a day');
axis([-1 27 -0.05 1.05])
set(gca(),'XTick',[0:2:26]);
set(gca(),'YTick',[0:0.1:1]);
grid on;
plotcmds('Weigel_HW2_P3_CumulativeFreqDist');
{| class="wikitable collapsible collapsed"
! align="left" | Figure 3
|-
|
[[Image:Weigel_HW2_P3_CumulativeFreqDist.png]]
|}
{| class="wikitable collapsible collapsed"
! align="left" | Figure 4
|-
|
[[Image:Weigel_HW2_P3_ACF1.png]]
|}
{| class="wikitable collapsible collapsed"
! align="left" | Figure 5
|-
|
[[Image:Weigel_HW2_P3_ACF2.png]]
|}

figure(2)
[n,x] = hist(Npd,[0:1:26]);
bar(x,n);grid on;
set(gca(),'XTick',[0:2:26]);
axis([-1 27 0 170])
set(gca(),'YTick',[0:20:180]);
ylabel('Number in bin');
xlabel('# of solar flares measured in a day');
plotcmds('Weigel_HW2_P3_Histogram');

figure(1)
plot(Npd);
grid on;
xlabel('Days since Jan. 1, 2000');
ylabel('# of solar flares measured per day');
plotcmds('Weigel_HW2_P3_TimeSeries');


