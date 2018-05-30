function [ output_img_fft, logged_fft ] = my_filter(img_fft)
%My own adoption of a fiter that filters only the centre frequencies for any image sizes.
%   Ideal filter.
[sizeY,sizeX] = size(img_fft);
deviationY = floor(sizeY/4);
deviationX = floor(sizeX/4);
midpointY = floor(sizeY/2);
midpointX = floor(sizeX/2);
output_img_fft = img_fft;

output_img_fft(1:deviationY,:) = 0;
output_img_fft(midpointY+deviationY:end,:) = 0;
output_img_fft(:,1:deviationX) = 0;
output_img_fft(:,midpointX+deviationX:end) = 0;

log_array_notzeros = (output_img_fft ~= 0);
logged_fft = output_img_fft;
logged_fft(log_array_notzeros) = log10(logged_fft(log_array_notzeros));




end

