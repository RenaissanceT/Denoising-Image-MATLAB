function Pabs = spec_est(x,wsize,overlap,fftsize,wintype)
% x:       2-D image
% wsize:   Window size (in 1-D)
% overlap: Overlap (in 1-D) between two consecutive blocks
% fftsize: Size (in 1-D) of the zero-padded data before DFT
% wintype: Window type (1: rectangular, 2: Hamming, 3: Bartlett, others: Not defined)

%The image is divided into overlapping blocks of wsize x wsize
x = double(x);
x = x - mean(mean(x));     % zero mean image
% Typically, the DC power is too strong compared to the noise component. Therefore,
% estimate the DFT spectrum of the image after subtracting the mean. This will make 
% the DC coefficient zero, and low magnitude noise peaks may be more visible.
[nrow ncol]=size(x);
shift = wsize-overlap;
% 2D Hamming window generation
if wintype==1
    b = rectwin(wsize); % Rectangular window 
elseif wintype==2
    b = hamming(wsize); % Hamming window
elseif wintype==3
    b = bartlett(wsize); % Hamming window
else
    printf('Window type not defined');
end

for m = 1:wsize
	zx(m,:) = b';
	zy(:,m) = b;
end
window2D = zx .* zy;
k = 0;
% calculate power spectrum
P = zeros(fftsize,fftsize);
for m = 1:shift:nrow-wsize
	for n = 1:shift:ncol-wsize
        xsub = x(m:m+wsize-1,n:n+wsize-1).*window2D;
        P = P + fft2(xsub,fftsize,fftsize);
        k = k + 1;
    end
end
P = fftshift(P);
Pabs = (abs(P)/k).^2;
% Mesh plot of normalized power spectrum
%mesh([-fftsize/2:fftsize/2-1]*2/fftsize,[-fftsize/2:fftsize/2-1]*2/fftsize,Pabs/max(max(Pabs)));

