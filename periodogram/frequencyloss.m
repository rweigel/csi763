clear;

t  = [1:1024]';
T1 = 15;
T2 = 16;
T3 = 17;

Nt = 100;
f1 = 1/(t(end)/T1);
f2 = 1/(t(end)/T2);
f3 = 1/(t(end)/T3);

%xo = 2*sind(360*f1*t) + 2*sind(360*f2*t);
xo = (1/3)*(sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t));
x  = sin(2*pi*f2*t);
    
t  = [0:1023]';
T1 = 16;
Nt = 100;
f1 = 1/(t(end)/T1);
x = sin(2*pi*f1*t);

I  = fft(x);
xi = ifft(I);

I1  = I(2:512);
I2  = flipud(I(513:end));
Ia1 = filter([1,1,1]/3,1,I1);    
Ia2 = filter([1,1,1]/3,1,I2);    

%Ia1 = filter([0.25,1,0.25],1,I1);    
%Ia2 = filter([0.25,1,0.25],1,I2);    


figure(1);clf;hold on;
    plot(t,x,'LineWidth',3)
    plot(t,xo,'k-.','LineWidth',2)
    
figure(2);clf;
    plot(real(I1),'b','MarkerSize',20);hold on;
    plot(real(I2),'r','MarkerSize',10);
    plot(real(Ia1),'b.','MarkerSize',20);hold on;
    plot(real(Ia2),'r.','MarkerSize',10);
    
figure(3);clf;
    Ia1 = [Ia1(2:end);Ia1(end)];
    Ia2 = [Ia2(2:end);Ia2(end)];
    plot(real(I1),'b','MarkerSize',20);hold on;
    plot(real(I2),'r','MarkerSize',10);
    plot(real(Ia1),'b.','MarkerSize',20);hold on;
    plot(real(Ia2),'r.','MarkerSize',10);

Ia = [I(1);Ia1;flipud(Ia2)];
xa = ifft(Ia);

figure(1);
    plot(t,real(xa),'g','LineWidth',1);
    lh = legend(' x = sin(2 \pi f_2t); f_2 = 16/1023, t = [0:1023]',' (1/3)(sin(2 \pi f_1t) + sin(2 \pi f_2t) + sin(2 \pi f_3t))',' From 3-point box car smoothed periodogram of x ','Location','NorthOutside');
    legend boxoff
    xlabel('t');
    plot([0 1024],[0 0],'k-');
    set(gca,'XTick',[0:128:1024]);
    grid on;
    axis([0,1024 -1.1 1.1])
    plotcmds('./figures/frequencyloss_timeseries.png');
    %axis([0 128 -1.1 1.1]);
    %plotcmds('./figures/frequencyloss_timeseries_zoom.png');
    