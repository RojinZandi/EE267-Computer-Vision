clear,clc
I = imread('Lenna.png');                %Read inn the image
info = imfinfo('Lenna.png');            %Image info
I = rgb2gray(I);                        %Grayscale the image
P = imnoise(I,'poisson');               %Apply possion noise
SP = imnoise(I,'salt & pepper',0.02);   %Apply Salt & pepper noise

figure(1)                               %Showcase the differences of images
imshowpair(I,P,'montage')
title('Left: Grayscaled image     Right: Possion noise added');

figure(2)                               %Showcase the differences of images
imshowpair(I,SP,'montage')
title('Left: Grayscaled image     Right: Salt and pepper noise added');

N=10;                                   %Size of filter will be 2*N+1
[X,Y]=meshgrid(-N:N,-N:N);              %Create X and Y vectors for mask 
sigma =(N)/4;                           %Controlls the strength of the mask
G=1/(2*pi*sigma^2)*exp(-(X.^2+Y.^2)/(2*sigma^2));   %Defining mask
%G=G./sum(G(:)); %for normalization                 %Normalize G
%sigma
%sum(G(:))
%max(max(G(:)))
%figure(1)
%surfc(G)

%Apply filter to showcase the result and compare
FD = imfilter(SP,G);                    
figure(3)
imshowpair(SP,FD,'montage');
title('Left: Salt and pepper noise added     Right: Gaussian Smoothing filter applied ');

FD = imfilter(P,G);
figure(4)
imshowpair(P,FD,'montage');
title('Left: Possion noise added     Right: Gaussian Smoothing filter applied ');

