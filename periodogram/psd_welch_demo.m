%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
t    = [0:1:95]';
N    = floor(length(t)/2);

f1  = 1/24; % 24 hour period
f2  = 2*f1; % 12 hour period

w1  = 2*pi*f1;
w2  = 2*pi*f2;

A   = [1, 1, 1]
X   = A(1) + A(2)*sin(w1*t) + A(3)*sin(w2*t);
N   = floor(length(X)/2);
f   = [0:N-1]'/(2*N);

temp = fft(X);

% Basic check:
% DC component should equal length(t)*mean(X)
temp(1) - length(t)*mean(X)

psd  = temp.*conj(temp);

% Check frequency axis:
% Expect peaks at f = [0, f1, f2] = [0, .041667, 0.83333]
[psd(1),psd(1+4),psd(1+8)]
[f(1)  ,f(1+4)  ,f(1+8)]

close
xlabel('t');
xlabel('X');
plot(X);

input('Continue?')

close
xlabel('f');
ylabel('PSD of X');
plot(f,psd(1:N));

input('Continue?')

close
xlabel('T');
ylabel('PSD of X');
plot(1.0./f(2:end),psd(2:N)); % T is Inf for f = 0, so don't plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
