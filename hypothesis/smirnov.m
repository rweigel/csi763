x = randn(100,1);
y = 3*randn(100,1);

[Nx,xb] = hist(x,[-4:0.01:4]);
[Ny,yb] = hist(y,[-4:0.01:4]);

clf;
Cx = cumsum(Nx/sum(Nx));
Cy = cumsum(Ny/sum(Ny));
plot(xb,Cx,'.');hold on;
plot(yb,Cy,'.');

D = max(abs(Cx-Cy))

Dc = (-0.5*(1/100+1/100)*log(0.1/2))^0.5

x = randn(1000,1);
y = 3*randn(1000,1);

%[h,p,Dc] = kstest2(x,y,0.1,'unequal')
[h,p,Dc] = kstest2(x,y,0.1)