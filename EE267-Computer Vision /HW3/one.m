close all;
clear all;
clc;

N=input('Enter the value of N:');  %size of f
disp('N=');
disp(N);
x=input('Enter the f matrix:');   %the matrix (f)
disp('the input matrix is:');
disp(x);
lx=length(x);
X=[x zeros(1,N-lx)];
%computing rows and columns of P
P=zeros(N);
for n=0:N-1
    for k=0:N-1
        if k==0
            P(k+1,n+1)=sqrt(1/N);
        else
            P(k+1,n+1)=sqrt(2/N)*cos(pi*(n+0.5)*k/N);
        end;
    end;
end;
b=P.';      %computing P transpose
r=b*X;
p=P*X*b;    %computing DCT
c=b*p*P;    %computing IDCT
disp('The P matrix is');
disp(P);
disp('After DCT:');
disp(p);
disp('After IDCT: ');
disp(c);

