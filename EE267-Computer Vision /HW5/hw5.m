ntaps = 24 ;
nsamp = 1000;
ibeta = 8; %2^8; % =1/2^8
amp = 1;
refsig = amp*rand(1,nsamp) - (amp/2);
% generate input signal x(t)
Wn = 0.47;
B = fir1(30,Wn);
x = filter(B,1,refsig);
x = x';
% generate desired signal d(t)
Coeff = fir1(ntaps,0.5);
d = filter(Coeff,1,x);
%%%% by now, we have X and D.
y = zeros(1,nsamp);
e = zeros(1,nsamp);
h(1:ntaps) = 0;
for n=1:nsamp
if n < ntaps
x1 = [x(n:-1:1)' zeros(1,ntaps-n)];
else
x1 = x(n:-1:n-ntaps+1)';
end
y(n) = h * x1';
e(n) = d(n) - y(n);
hh = e(n)*x1/ibeta;
h = h + hh;
end