clear;clc;

diary('irf.log');

N = 1000;
u = randn(N,1);
b = [0,1,1];
a = [1];

% Two methods of generating data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method 1 (u is assumed to be zero when t<=0).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z(1,1) = b(1)*u(1);
z(2,1) = b(1)*u(2) + b(2)*u(1);
for t=3:N
    z(t,1) = b(1)*u(t)+b(2)*u(t-1)+b(3)*u(t-2);
end
z1 = z;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method 2
z = filter(b,a,u);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('max(difference in z between method 1 and 2)/eps %f\n',...
	max(diff(z-z1))/eps);

fprintf('\n');
fprintf('Coefficients to estimate:');
b

% Assume a model of the form
% z(t) = b(1)*u(t)+b(2)*u(t-1)
% and solve for the unknown coefficients b(1) and b(2)

% z = U*b
U = [u(2:end),u(1:end-1)];
b = U\z(2:end);
zm = filter(b',a,u);

cc = corrcoef(zm,z);

mstr = 'z(t) = b(1)*u(t)+b(2)*u(t-1)';
fprintf('Coefficients for model (cc=%.2f): %s',cc(2),mstr);
b'

% Assume a model of the form
% z(t) = b(1)*u(t)+b(2)*u(t-1)+b(3)*u(t-2)
% and solve for the unknown coefficients b(1), b(2), and b(3)

% z = U*b
U = [u(3:end),u(2:end-1),u(1:end-2)];
b = U\z(3:end);
zm = filter(b,a,u);
cc = corrcoef(zm,z);

mstr = 'z(t) = b(1)*u(t)+b(2)*u(t-1)+b(3)*u(t-2)';
fprintf('Coefficients for model (cc=%.2f): %s',cc(2),mstr);
b'

% Assume a model of the form
% z(t) = b(1)*u(t)+b(2)*u(t-1)+b(3)*u(t-2)
% and solve for the unknown coefficients b(1), b(2), and b(3)

% z = U*b
U = [u(4:end),u(3:end-1),u(2:end-2),u(1:end-3)];
b = U\z(4:end);
zm = filter(b,a,u);
cc = corrcoef(zm,z);

mstr = 'z(t) = b(1)*u(t)+b(2)*u(t-1)+b(3)*u(t-2)';
fprintf('Coefficients for model (cc=%.2f): %s',cc(2),mstr);
b'

diary off



