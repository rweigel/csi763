clear;
%t  = [0:1023]';
t = [1:1024]';
T = [2:2:32];
x = 0;

for i = 1:length(T)
    x = x + sin(2*pi*t/(t(end)/T(i)));
end
x = x/max(abs(x));
dx = diff(x);
dx = [dx(1);dx];
dx = dx/max(abs(dx));

figure(1);clf
    %plot(x,'marker','.','markersize',1,'markeredgecolor','k','linestyle','-','LineWidth',3);hold on;
    plot(x,'b','LineWidth',2);hold on;
    plot(dx,'g','LineWidth',2);
    %plot(x,'marker','.','markersize',1,'markeredgecolor','k','linestyle','-','LineWidth',3);hold on;
    legend(' x',' dx');
    plot(x,'k.','MarkerSize',3);
    plot(dx,'k.','MarkerSize',3)
    set(gca,'XTick',[0:128:1024]);
    grid on;
    axis([-16,1040 -1.1 1.1]);
    lh = legend(' x',' dx');
    xlabel('t');
    legend boxoff
    plotcmds('./figures/diff_filter_timeseries');

    
figure(2);clf
    [I,f] = periodogramraw(x,'fast');
    plot(f,I,'marker','.','markersize',20,'linestyle','-','linewidth',2);hold on;
    [dI,f] = periodogramraw(dx,'fast');
    plot(f,dI,'marker','.','markersize',20,'linestyle','-','linewidth',2,'color','g');
    xlabel('T');
    legend(' I of x',' I of dx','Location','NorthWest');
    set(gca,'XTick',[1/512,1/128,2/128,4/128,8/128,16/128]);
    xt = get(gca,'XTick');
    set(gca,'XTickLabel',1./xt);
    grid on;
    axis([0 0.04 0 8])
    plotcmds('./figures/diff_filter_periodogram');




    

