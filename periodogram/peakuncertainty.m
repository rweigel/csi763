clear;

t  = [1:1024]';
T1 = 32;
T2 = 64;
Nt = 5000;
f1 = 1/(t(end)/T1);
f2 = 1/(t(end)/T2);

xo = 2*sin(2*pi*f1*t) + 2*sin(2*pi*f2*t);

figure(1);clf
    plot(xo);
    xlabel('t')
    ylabel('x_o');
    title('x_o = 2sin(2\pif_1t) + 2sin(2\pif_2t)');
    axis tight;
    plotcmds('./figures/peakuncertainty_timeseries');
    
figure(2);clf;
    [Io,fo] = periodogramraw(xo,'fast');
    plot(fo,Io,'.','MarkerSize',15);hold on;
    xlabel('f');
    ylabel('I');
    axis([0.02,0.075,0,2500]);

    for i = 1:Nt
        x = xo+1.0*randn(length(t),1);
        [I,f] = periodogramraw(x,'fast');
        a = [T1+1,T2+1];
        plot(f(a),I(a),'k.','MarkerSize',1);
        hold on;grid on;
        Ia(i,:) = I(a)';
    end
    legend('I of x_o',sprintf('I of x_o+\\eta(0,1); %d trials',Nt),'Location','South');
    
    th = text(f(a(1)),100,'f_1');
    th = text(f(a(2)),100,'f_2');

    plot([f(a(1)),f(a(1))],[0,50],'k-');
    plot([f(a(2)),f(a(2))],[0,50],'k-');

    plotcmds('./figures/peakuncertainty_periodogram');

figure(3);clf
    [N1,X1] = hist(Ia(:,1),20);
    [N2,X2] = hist(Ia(:,2),20);
    stairs(X1,N1/sum(N1),'r','LineWidth',3);hold on;grid on;
    stairs(X2,N2/sum(N2),'b','LineWidth',3);
    xlabel('I')
    ylabel('Probability');
    legend('I(f_1)','I(f_2)')
    plotcmds('./figures/peakuncertainty_histogram');
    