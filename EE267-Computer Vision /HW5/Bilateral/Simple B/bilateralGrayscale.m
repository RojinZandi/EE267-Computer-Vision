function [ output ] = bilateralGrayscale( inputImg,sigma_s,sigma_r,noise )
%% BILATERAL FILTERING ON GRAYSCALE IMAGES

% Illustrates the use of bilateral filtering on grayscale images.
% Bilateral filtering is a technique to smooth images while preserving edges, 
% by means of a nonlinear combination of nearby
% image values. The method is noniterative, local, and simple.
% The bilateral filter is controlled by two parameters.

% parameters:
% inputImg    = input image
% sigma_s  = domain parameter for spatial kernel
% sigma_r  = range parmeter for intensity kernel
% noise     = Gaussian noise intensity

%%

imwrite(inputImg,'cameraman.png');
% create noisy image adding white Gaussian noise
noisy_image=imnoise(inputImg,'gaussian',noise);
imwrite(noisy_image,'noisyImg.jpg');
[row col d]=size(noisy_image);

%check if the image is RGB (depth is more than 2)
if d>2
noisy_image=rgb2gray(noisy_image);
end

% image=double(image)/255;
window_size=9; 

%transforms the domain specified by vectors from -window_size to window_size into arrays X and Y 
[x y]=meshgrid(-window_size:window_size,-window_size:window_size);

%% Domain filter 
%The weights depend on the spatial distance (to the center pixel x) only; therefore, it is calculated once and saved.
domain_filter=exp(-(x.^2+y.^2)/(2*sigma_s^2));  

%% Repeat for all pixels
[r c]=size(noisy_image);
output=zeros(size(noisy_image));

% Create waitbar.
h = waitbar(0,'Wait...');
set(h,'Name','Bilateral Fiter Processing');

for i=1:r
    for j=1:c
        
        %Adjusting the window size
        imin=max(i-window_size,1);
        imax=min(i+window_size,r);
        jmin=max(j-window_size,1);
        jmax=min(j+window_size,c);
        I=noisy_image(imin:imax,jmin:jmax);
        
        range_filter=exp(-double(I-noisy_image(i,j)).^2/(2*sigma_r^2)); % Range filter
        
        %Taking the product of the range and domain filter.The combination is refered to as Bilater Filter
        BilateralFilter=range_filter.*domain_filter((imin:imax)-i+window_size+1,(jmin:jmax)-j+window_size+1);
        
        Fnorm=sum(BilateralFilter(:));
        output(i,j)=sum(sum(BilateralFilter.*double(I)))/Fnorm; %normalize the output
    end
    waitbar(i/(r-sigma_s));
end
close(h)

clc;
imwrite(output,'outputImg.png');

end