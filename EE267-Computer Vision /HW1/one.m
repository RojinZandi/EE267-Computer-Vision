I=imread('Lenna.png'); %Loading the image
G=rgb2gray(I);       %Convering to gray image
GD = im2double(G); % Convert to double
% Corrected masks
b=[-1 -1 -1;0 0 0;1 1 1];
c=[-1 0 1; -1 0 1; -1 0 1];
Gx=abs(conv2(GD,c,'same'));  %Convolution
Gy=abs(conv2(GD,b,'same'));
G = sqrt( Gx.^2 + Gy.^2);
out = G > 0.5;          %Threshold image
%Also show output from edge 
CP=edge(GD,'Prewitt', [], 'both', 'nothinning');
imshowpair(out,CP,'montage')
title('Problem 1')