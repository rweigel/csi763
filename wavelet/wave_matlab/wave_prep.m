if (tseries_no == 1)
    load 'sst_nino3.dat'   % input SST time series
    figname = 'sst_nino3';
    sst = sst_nino3;
    Year_o = 1871.0;
    Year_f = 2000.0;
    xtics = eeticks([Year_o,Year_f]);
    xlim = [xtics(1):xtics(2):xtics(3)];
    xlim = [1870:10:2000];

    dt = 0.25;

    dj = 0.25;    % this will do 4 sub-octaves per octave
    s0 = 2*dt;    % this says start at a scale of 6 months
    j1 = 7/dj;    % this says do 7 powers-of-two with dj sub-octaves each
    lag1 = 0.72;  % lag-1 autocorrelation for red noise background
    mother = 'Morlet';

    title_a = 'a) NINO3 Sea Surface Temperature (seasonal)';
    title_b = 'b) NINO3 SST Wavelet Power Spectrum';
    title_d = 'd) 2-8 yr Scale-average Time Series';
    time_unit = 'year';
    data_unit = 'degC';
    data_name = 'NINO3 SST';
    x_label = sprintf('Time [%s]',time_unit);
end

if (tseries_no == 2)
    load 'ssn_1749_2007.dat';
    figname = 'ssn_1749_2007';
    sst = ssn_1749_2007(:,3);
    Year_o = 1749;
    Year_f = 2007;
    xtics = eeticks([Year_o,Year_f]);
    xlim = [xtics(1):xtics(2):xtics(3)];
    xlim = [1740:20:2020];

    dt = 1/12;

    dj = 0.25;    % this will do 4 sub-octaves per octave
    s0 = 2*dt;    % this says start at a scale of 2 years
    j1 = 10/dj;    % this says do 7 powers-of-two with dj sub-octaves each
    lag1 = 0.72;  % lag-1 autocorrelation for red noise background
    mother = 'Morlet';

    title_a = 'a) Sunspot number (monthly)';
    title_b = 'b) SSN Wavelet Power Spectrum';
    title_d = 'd) 2-8 yr Scale-average Time Series';
    time_unit = 'year';
    data_unit = '#';
    data_name = 'Sunspot Number';
    x_label = sprintf('Time [%s]',time_unit);
end

if (tseries_no == 3)
    load 'ssn_1749_2007.dat';
    figname = 'ssn_1749_2007';
    sst = ssn_1749_2007(:,3);
    Year_o = 1749;
    Year_f = 2007;
    xtics = eeticks([Year_o,Year_f]);
    xlim = [xtics(1):xtics(2):xtics(3)];
    xlim = [1740:20:2020];

    dt = 1/12;

    N  = 10^3;
    t  = [0:N-1]';
    f1 = (N/100)/N;
    f2 = (N/8)/N;

    x1 = 1.0*sin(2*pi*f1*t);
    x2 = 1.0*sin(2*pi*f2*t);

    Iz1     = [1:400,501:N];
    Iz2     = [1:400,409:N];
    x1(Iz1) = 0;
    x2(Iz2) = 0;
    sst = x1+x2;

%    sst = zeros(length(sst),1);
%    sst(12*50+1:12*50+24) = sin(2*pi*[0:23]/24);
    
    dj = 0.25;    % this will do 4 sub-octaves per octave
    s0 = 2*dt;    % this says start at a scale of 2 years
    j1 = 10/dj;    % this says do 7 powers-of-two with dj sub-octaves each
    lag1 = 0.72;  % lag-1 autocorrelation for red noise background
    mother = 'Morlet';
    %mother = 'DOG';
    %mother = 'Paul'
    
    title_a = 'a) Sunspot number (monthly)';
    title_b = 'b) SSN Wavelet Power Spectrum';
    title_d = 'd) 2-8 yr Scale-average Time Series';
    time_unit = 'year';
    data_unit = '#';
    data_name = 'Sunspot Number';
    x_label = sprintf('Time [%s]',time_unit);
end

if (tseries_no == 4)
    load 'ssn_1749_2007.dat';
    figname = 'ssn_1749_2007';
    sst = ssn_1749_2007(:,3);
    Year_o = 1749;
    Year_f = 2007;
    xtics = eeticks([Year_o,Year_f]);
    xlim = [xtics(1):xtics(2):xtics(3)];
    xlim = [1740:20:2020];

    dt = 1/12;

    N  = 10^3;
    t  = [0:N-1]';
    f1 = (N/100)/N;
    f2 = (N/8)/N;

    x1 = 1.0*sin(2*pi*f1*t);
    x2 = 1.0*sin(2*pi*f2*t);
    
    lb = -4; ub = 4; n = 100;
    [psi,x] = morlet(lb,ub,n);
    

    sst = psi;
%    sst = zeros(length(sst),1);
%    sst(12*50+1:12*50+24) = sin(2*pi*[0:23]/24);
    
    dj = 0.25;    % this will do 4 sub-octaves per octave
    s0 = 2*dt;    % this says start at a scale of 2 years
    j1 = 10/dj;    % this says do 7 powers-of-two with dj sub-octaves each
    lag1 = 0.72;  % lag-1 autocorrelation for red noise background
    mother = 'Morlet';
    %mother = 'DOG';
    %mother = 'Paul'
    
    title_a = 'a) Sunspot number (monthly)';
    title_b = 'b) SSN Wavelet Power Spectrum';
    title_d = 'd) 2-8 yr Scale-average Time Series';
    time_unit = 'year';
    data_unit = '#';
    data_name = 'Sunspot Number';
    x_label = sprintf('Time [%s]',time_unit);
end
