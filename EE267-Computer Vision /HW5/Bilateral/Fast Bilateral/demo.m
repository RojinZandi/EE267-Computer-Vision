% Fast Bilateral Filtering using Trigonometric Kernels
clear;
close all force;
tic;
fin  =  double( imread('cameraman.png') ); %input grayscale image
[m, n] = size(fin);
% filter parameters
sigmas = 5;             %width of spatial Gaussian
sigmar = 40;            %width of range Gaussian
% call bilateral filter
[fout, param] = shiftableBF(fin, sigmas, sigmar);
% plots
T = param.T;
t = - T : 0.01 : T;
gexact = exp(-0.5*t.^2/sigmar^2);
g = zeros(1,length(t));
T0 = max(T,ceil(3*sigmar));
w0 = pi/T0;
for n = 1:length(param.coeff)
    g = g + param.coeff(n)*cos((n-1)*w0*t);
end

% results
figure('Units','normalized','Position',[0 0.5 1 0.5]);
colormap gray,
subplot(1,2,1), imshow(uint8(fin)),
title('Input', 'FontSize', 20), axis('image', 'off');
subplot(1,2,2), imshow(uint8(fout)),          %bilateral filter output
title('Output','FontSize', 20), axis('image', 'off');
elapsed_time=toc;
fprintf('Total elapsed time in fast Bilateral filter is: %f seconds \n', elapsed_time); 
