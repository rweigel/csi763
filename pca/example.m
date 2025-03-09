clear;
%addpath('../m');

% The following script must be in your path:
% http://bobweigel.net/svn/csi763/weigel/m/plotcmds.m

T     = 16;
theta = pi/3;

t  = [0:1:3*T-1]';

plotit = 0;
%for run = 1:4
for z = 1:1000
for run = 4:4
  
  if (run == 1)
    N1 = 1.0;
    N2 = 1.0;
    Ns = length(t);
  end
  if (run == 2)
    N1 = 0.5;
    N2 = 0.5;
    Ns = length(t);
  end
  if (run == 3)
    N1 = 0.1;
    N2 = 0.1;
    Ns = round(length(t)/2);
  end
  if (run == 4)
    N1 = 0.0;
    N2 = 0.0;
    Ns = round(0.9*length(t));
    %Ns = length(t);
    Ns = length(t)-1;
  end

  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*randn(length(t),1);
  x2 = y1*sin(theta) + N2*randn(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = dot(v1,v2);
  ang(z)
  P
  if (plotit)
  figure(1);clf;hold on;grid on;
  plot(t,y1,'b-');
  plot(t,x1,'r-','LineWidth',2);
  plot(t,x2,'g-','LineWidth',2);
  plot(t(S),X(1,:),'r.','MarkerSize',27);
  plot(t(S),X(2,:),'g.','MarkerSize',27);
  legend('y_1','x_1','x_2','Samples of x_1','Samples of x_2')
  xlabel('time step');
  axis([0 t(end) -3 6]);
  plot([0 t(end)],[0 0],'k');
  plotcmds(sprintf('./figures/example2_tseries_run_%d',run));
  
  figure(2);clf;hold on;grid on;
  plot(4*[-1*cos(theta) cos(theta)],4*[-1*sin(theta) sin(theta)],'b');
  text(4.5*cos(theta),4.5*sin(theta),'y_1');
  plot([0 3*P(1,1)],[0 3*P(1,2)],'k','LineWidth',2);
  text(3.5*P(1,1),3.5*P(1,2),'p_1');
  plot([0 3*P(2,1)],[0 3*P(2,2)],'k','LineWidth',2);
  text(3.5*P(2,1),3.5*P(2,2),'p_2');
  plot([-4 4],[0 0],'k');

  plot([0 0],[-4 4],'k');
  plot(X(1,:),X(2,:),'k.','MarkerSize',27);
  xlabel('x_1');
  ylabel('x_2');
  %text(X(1,:),X(2,:),num2str([1:size(X,2)]','%d'));
  axis square
  plotcmds(sprintf('./figures/example2_scatter_run_%d',run));

  Y = P*X;
  
  figure(3);
  hist(Y(1,:),[-1.5:0.1:1.5]);grid on;
  xlabel('y_1');
  ylabel('Number in bin');
  plotcmds(sprintf('./figures/example2_hist1_run_%d',run));  

  figure(4);
  hist(Y(2,:),[-1.5:0.1:1.5]);grid on;
  xlabel('y_2');
  ylabel('Number in bin');
  
  plotcmds(sprintf('./figures/example2_hist2_run_%d',run));  
  end
end
end
