function mask = maskgen(M,N,centerX,centerY,widX,widY)
%Input Parameters:
% M = # of rows in the Image
% N = # of cols in the Image
% centerX = X coordinate(row) of the mask
% centerY = Y coordinate(col) of the mask
% WidX = X-Width of the mask (in %); 100=entire axis
% WidY = Y-Width of the mask (in %);100=entire axis
%Output Parameters:
% mask = Generated mask (same size as the image)
%
[y,x]=meshgrid(-(N/2-1):(N/2),-(M/2-1):(M/2));
xn=2*x/M;  %Normalized x axis [-1,1]
yn=2*y/N;  %Normalized y axis [-1,1]
cxn=2*centerX/M-1;cyn=2*centerY/N-1;   % Centre coordinate of mask
wxn = widX/100; 
wyn = widY/100; 
mask = ((((xn-cxn)/wxn).^2+((yn-cyn)/wyn).^2)<=1);
return
