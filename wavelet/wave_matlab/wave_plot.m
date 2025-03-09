%------------------------------------------------------ Plotting

%--- Plot time series
subplot('position',[0.1 0.75 0.65 0.2])
plot(time,sst_o)
set(gca,'XTick',xlim(:))
set(gca,'XTickLabel',xlim(:))
set(gca,'XLim',[xlim(1),xlim(end)])
grid on;
xlabel(x_label)
ylabel(sprintf('%s [%s]',data_name,data_unit))
title(title_a)
hold off

%--- Contour plot wavelet power spectrum
subplot('position',[0.1 0.37 0.65 0.28])
% cone-of-influence, anything "below" is dubious
plot(time,log2(coi),'k')
set(gca,'XTick',xlim(:))
set(gca,'XTickLabel',xlim(:));
set(gca,'XLim',[xlim(1),xlim(end)])
hold on;
levels = [0.0625,0.125,0.25,0.5,1,2,4,8,16] ;
Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));
%contour(time,log2(period),log2(power),log2(levels));  %*** or use 'contourfill'
imagesc(time,log2(period),log2(power));  %*** uncomment for 'image' plot
xlabel(x_label)
ylabel(sprintf('Period [%s]',time_unit));
title(title_b)
set(gca,'YLim',log2([min(period),max(period)]), ...
	'YDir','reverse', ...
	'YTick',log2(Yticks(:)), ...
	'YTickLabel',Yticks)
% 95% significance contour, levels at -99 (fake) and 1 (95% signif)
hold on
contour(time,log2(period),sig95,[-99,1],'k');
hold on
hold off

%--- Plot global wavelet spectrum
subplot('position',[0.77 0.37 0.2 0.28])
plot(global_ws,log2(period))
hold on
plot(global_signif,log2(period),'--')
hold off
xlabel(sprintf('Power [%s^2]',data_unit));
title('c) Global Wavelet Spectrum')
set(gca,'YLim',log2([min(period),max(period)]), ...
	'YDir','reverse', ...
	'YTick',log2(Yticks(:)), ...
	'YTickLabel','')
set(gca,'XLim',[0,1.25*max(global_ws)])

%--- Plot 2--8 yr scale-average time series
subplot('position',[0.1 0.07 0.65 0.2])
plot(time,scale_avg)
set(gca,'XLim',[xlim(1),xlim(end)])
set(gca,'XTick',xlim(:))
set(gca,'XTickLabel',xlim(:));

hold on
xlabel(x_label)
ylabel(sprintf('Avg variance [%s^2]',data_unit))
title(title_d)
plot([time(1),time(end)],scaleavg_signif+[0,0],'--')
hold off

% end of code
orient landscape;
plotcmds(figname);
