
clear
fname = 'OMNI_OMNI2_merged_20130927-v1.mat';
if ~exist(fname)
    fprintf('Downloading %s',fname);
    [f,s] = urlwrite(['ftp://virbo.org/OMNI/OMNI2/merged/',fname],fname);
    if (length(s) > 0)
        fprintf('Error downloading file');
    end
end
load(fname)

E = Plasma_bulk_speed.*(abs(Bz_GSM)-Bz_GSM)/2;

figure(1);clf
    plot(-Dst_index,'k');hold on;
    plot(E/50);hold on
    xlabel('Hours after 1963-01-01T00:00:00');
    grid on;
    legend('-D_{st} [nT]','E_{sw}');

Ic = {[314289:314300]',[138018:138028]',[334640:334650]',[340985:341015]'};

for i = 1:length(Ic)
    I = Ic{i};
    % y = Aexp(t/tau)
    % ln(y) = t/tau + ln(A)    
    P = polyfit(I-I(1),log(-Dst_index(I)),1);
    tau = -1/P(1);
    y = exp(P(2))*exp((I-I(1))*P(1));
    fprintf('tau = %.1f\n',tau);
    figure(2);clf;
        plot(-Dst_index,'k','LineWidth',2);hold on;
        plot(E/50,'LineWidth',2);hold on
        plot(I,-Dst_index(I),'k','LineWidth',3);
        plot(I,y,'g','LineWidth',3)    
        xlabel('Hours after 1963-01-01T00:00:00');
        grid on;
        legend('-D_{st} [nT]','E_{sw}/50',sprintf('Fit \\tau = %.1f [hr]',-1/P(1)));
        set(gca,'XLim',[I(1)-10,I(end)+10]);
        plotcmds(sprintf('./figures/Dst_decay_%d',i));
end





