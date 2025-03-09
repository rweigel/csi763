clear;
%y = [0 1 0 -1 0 1 0 -1 0]';
%y = [0 1 0 -1 0 1 0 -2]';
%y =  [2 0 -1 0 1 0 -1 0]';
y = [0 1 0 -1]';
y = 1+[1 0 -1 0]';
[If,f,af,bf,a0] = periodogramraw(y,'fast');
[Is,f,as,bs,a0] = periodogramraw(y);
[af,as]
[bf,bs]
[If,Is]
z = [3.4,4.5,4.3,8.7,13.3,13.8,16.1,15.5,14.1,8.9,7.4,3.6]';
[Iz,fz,az,bz,a0z] = periodogramraw(z)
[Iz,fz,az,bz,a0z] = periodogramraw(z,'fast')
break
max(abs(If-Is))

for N = 4:100
  y = randn(N,1);
  [If,f] = periodogramraw(y,'fast');
  
  [Is,f,a,b,a0] = periodogramraw(y);
  max(abs(If-Is))
end

