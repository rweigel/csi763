% [x1,y1]=[0.1,1.0];
% [x2,y2]=[0.2,2.0];

x = [0.1;0.2];
y = [1.0;2.0];
A = [x(1) 1;x(2) 1];

% 6.1.1
p_polyfit = polyfit(x,y,1)';

% 6.1.2
p_inv     = inv(A)*y;
p_slash   = A\y; % See help slash for definition of "\" operator

% Answer is [10;0]
p_polyfit

% Difference between polyfit and matrix methods
sum(p_polyfit-p_inv)/eps % 6.8820
sum(p_inv-p_slash)/eps   % 0

% 6.1.3
x = [x;0.3];
y = [y;3.1];
A = [x(1) 1;x(2) 1;x(3) 1];

p_polyfit  = polyfit(x,y,1)';
p_slash    = A\y;

% Answer is [10.5;-0.667]
p_polyfit

% Difference between polyfit and slash
sum(p_polyfit-p_slash)/eps % -13.56
