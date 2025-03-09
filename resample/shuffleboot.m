clear;
addpath('../m');
delta    = 0.1;     % Mean of second batch
Nsamples = 1000;    % Number of samples per batch
Nresamps = 100;     % Number of resampling operations
 
% Create two batches
x = randn(Nsamples,1);        % Array of normally distributed random numbers
                              % with mean of zero and std of 1.
y = randn(Nsamples,1)+delta;  % Same as x, but with population mean of x. 
z = [x;y];                    % Concatenate arrays
 
ym_observed = mean(y);    
xm_observed = mean(x);
dm_observed = ym_observed-xm_observed;  % Sample statistic
orient portrait
figure(1);clf;
 hist(x,[-5:0.1:5]);grid on;hold on;
 xlabel('x');
 ylabel('# in bin');
 plot([xm_observed,xm_observed],[0 60],'k-','LineWidth',3);
 text(xm_observed,55,sprintf(' mean x= %.2f',xm_observed));
 plotcmds('shufflebootx');
orient portrait
figure(2);clf;
 hist(y,[-5:0.1:5]);grid on;hold on;
 plot([ym_observed,ym_observed],[0 60],'k-','LineWidth',3);
 text(ym_observed,55,sprintf(' mean y= %.2f',ym_observed));
 xlabel('y');
 ylabel('# in bin');
 plotcmds('shufflebooty');

for j = 1:2
  if (j == 1)
    method = 'bootstrap';
  else
    method = 'shuffle';
  end
  for i = 1:Nresamps
    if strmatch(method,'bootstrap','exact')
      xb           = randsample(x,length(x),'true'); % Sample w/replacement
      yb           = randsample(y,length(y),'true'); % Sample w/replacement
      xm_resamp(i) = mean(xb); 
      ym_resamp(i) = mean(yb);
    end
    if strmatch(method,'shuffle','exact')
      z            = z(randperm(length(z))); % Shuffle elements of z
      xm_resamp(i) = mean(z(1:Nsamples)); 
      ym_resamp(i) = mean(z(Nsamples+1:2*Nsamples));
      zm(i)        = mean(z);
    end
  end
  dm_resamp = ym_resamp-xm_resamp;
  if strmatch(method,'shuffle','exact')
    fprintf('Mean of z = %f.  Mean of dm_resamp = %f.\n',...
	    mean(z),mean(dm_resamp));
  end
  N_larger = length(find(dm_resamp > dm_observed));
  f_larger = 100*N_larger/length(dm_resamp);
  
  figure(j+2);clf;hold on;grid on;
   plot(dm_observed,0,'.','MarkerSize',10);
   [nn,xx] = hist(dm_resamp,Nresamps/10);hold on;
   bar(xx,nn,0.99);
   text(dm_observed,28,...
	sprintf('d_{observed} = %.2f ',...
		dm_observed),'HorizontalAlignment','right');
   plot([dm_observed,dm_observed],[0 30],'k-','LineWidth',3);
   axis([-0.3 0.3 0 30])
   xlabel(sprintf('d_{%s}',method));
   ylabel('# in bin');
   tmp = sprintf(['%.0f%% of %s replicas had mean(x) -' ...
		  'mean(y) = d > d_{observed}'],f_larger,method);
   title(tmp);
  
  if strmatch(method,'shuffle','exact')
    plotcmds('shuffleboot_shuffle');
  else
    plotcmds('shuffleboot_bootstrap');  
  end
end