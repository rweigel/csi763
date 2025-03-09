% Compare methods of computing PSD

z = randn(10,1);

I1 = xpsd1(z);
I2 = xpsd2(z);
q  = length(z)/2;

fprintf('Two methods of computing spectrum\n');
I = [I1(1:q),I2(1:q)]

for i = 2:size(I,2)
  d(1,i) = max(abs(I(:,1)-I(:,i)))/eps;
end
fprintf('max(abs(diff))/eps in coefficients from first column.\n');
d
