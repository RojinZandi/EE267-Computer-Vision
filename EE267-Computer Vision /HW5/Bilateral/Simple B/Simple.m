tic;
inputImg=imread('cameraman.png');
w=9; % window size
sigma_s=1;
sigma_r=30;
noise=0.5;

%applying bilateral filter on each channel (RGB)
[out]=bilateralGrayscale( inputImg,sigma_s,sigma_r,noise );
figure('Units','normalized','Position',[0 0.5 1 0.5]);
colormap gray,
subplot(1,2,1), imshow(uint8(inputImg)),
title('Input', 'FontSize', 20), axis('image', 'off');
subplot(1,2,2), imshow(uint8(out)),          %bilateral filter output
title('Output','FontSize', 20), axis('image', 'off');
elapsed_time=toc;
fprintf('Total elapsed time in simple Bilateral filter is: %f seconds \n', elapsed_time); 
