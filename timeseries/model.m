%!wget ftp://virbo.org/OMNI/OMNI2/merged/OMNI_OMNI2_merged_20130927-v1.mat

load OMNI_OMNI2_merged_20130927-v1.mat

D = Dst_index;

E = Plasma_bulk_speed.*(abs(Bz_GSM)-Bz_GSM)/2;

figure(1);clf
plot(Time,D);
hold on;
plot(Time,E/100,'r');
axis([730680 730685 -310 500]);
datetick(gca,'keepticks');
grid on;
legend('D_{st} [nT]','E_{sw}/100');
print -dpng model.png
print -depsc model.eps

I = [730680 730685];

figure(2);clf;