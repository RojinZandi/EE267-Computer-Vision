close all
clear,clc;
I = imread('Lenna.png');
I = (rgb2gray(I));


P = imnoise(I,'poisson');               %Apply possion noise
SP = imnoise(I,'salt & pepper',0.02);   %Apply Salt & pepper noise

%figure(1)                               %Showcase the differences of images
%imshowpair(I,P,'montage')
%title('Left: Grayscaled image     Right: Possion noise added');

%figure(2)                               %Showcase the differences of images
%imshowpair(I,SP,'montage')
%title('Left: Grayscaled image     Right: Salt and pepper noise added');

SP = double(SP);
I = double(P);

%imshow(Gs)
N = 3;
sigma_d = 10;
sigma_r = 1.3;
d = -N:1:N;
weights_d= exp(-d.*d/(2*sigma_d*sigma_d));% Repeat for all pixels in one image row
I_output= I;

for i=1+N:length(I)-N, % Be careful with the borders; do not exceed the dimensions.
    pixels = I(i-N:i+N);
    weights = weights_d.* exp(-(pixels-I(i)).*(pixels-I(i))/(2*sigma_r*sigma_r)) + 0.0001;
    weights = weights./sum(weights);
    I_output(i) = sum(weights.*pixels);
end
figure; 
imshow(uint8(I_output));



%%
BF = imbilatfilt(P,1000,5);
imshowpair(P,BF,'montage');