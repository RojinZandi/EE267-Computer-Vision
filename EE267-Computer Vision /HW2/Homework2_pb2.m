close all;
format long
clear,clc;

I = imread('Lenna.png');            %Read inn the Lena image
info = imfinfo('Lenna.png');
Gs = rgb2gray(I);                   %Convert the image to grayscale
%figure(1)       
%imshow(Gs)                          %Show grayscaled image
    
w=fspecial('log',10,0.5);           %Generate Laplacian of Gaussian filter
                                    % size 10x10 and sigma 0.5
img = imfilter(Gs,w,'replicate');   %Apply the filter onto grayscaled img
img = imbinarize(img);              %Binarize the img
figure
imshowpair(Gs,img,'montage');       %showcase the result
title('Left: Grayscaled image of Lena       Right: LoG filter applied'); 

