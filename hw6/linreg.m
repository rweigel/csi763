function [a,b] = linreg(x,y)
  
ym = mean(y);
xm = mean(x);

b = sum( (x-xm).*(y-ym) ) / sum( (x-xm).^2 );
a = ym - b*xm;
