% Exercise 2: Denoising using Filtering (50pts)
clear all;
% (1) Download the gray-scale image pool.jpg from the eClass Lab website and read it into MATLAB
% (1) Denote the image as x
x = imread('pool.jpg');
% (1) This will be the first subplot
subplot(2,2,1);
% (1) Determine the size of the image matrix 
[rows columns numberOfColorChannels] = size(x);
% (1) Use this to calculate the uncompressed image size
sizeim = size(x);
s = dir('pool.jpg');
imshow(x);
title ('pool.jpg');
% (1) Denote the size of the image by M x N
N = columns;
M = rows;
% (3) Calculate the 2-D DFT of the matrix using the fft2 function
y = fft2 (x,M,N);
% (3) plot the Fourier amplitude spectrum 
% (3) In order to have better visualization
% (3) shift the origin to the center of the plot using the fftshift MATLAB function
% (3) Also, use logscale2bytes to scale the coefficients before displaying.
h = fftshift (y);
g = logscale2bytes(h,100); %calculate the 2D DFT of the matrix h
subplot(2,2,2);
imshow (g);
title ('Fourier amplitude spectrum |X(u,v)|');
% (4) use the imtool function to determine the frequency location
% u = imtool(g,[-1,1]);
% (5) use the spec_est function
pabs = spec_est(double(x),300,0,512,2);
imtool (logscale2bytes(pabs,100));% log10(pabs), []
% (6) Plot the bandstop zonal maskbs(u,v)
lowpass_zonal_mask_noise_1 = maskgen(M,N,334,558,3,3) ;
lowpass_zonal_mask_noise_2 = maskgen(M,N,466,652,3,3) ;
noise = 1- (lowpass_zonal_mask_noise_1 + lowpass_zonal_mask_noise_2);
subplot(2,2,3);
imshow (noise);
title ('Plot the lowpass zonal mask');
% (7) Using the zonal mask, filter the image. Plot the amplitude spectrum |X_BS(u,v)|
y = fft2 (x,M,N);
v = fftshift(y).* noise;
subplot(2,2,4);
imshow (logscale2bytes(v,100) );
title ('Fourier amplitude spectrum |X[BS(u,v)]|');
% (7) Calculate the inverse DFT of Xh(u,v) using the ifft2 function
% (7) obtain the filtered image 𝑥̂BS
figure;
b = ifftshift(noise).* y;
u = ifft2(b);
imshow (uint8(abs(u)));
title ('The filtered image X(BS)');

                                                                %[END]

                                                                









