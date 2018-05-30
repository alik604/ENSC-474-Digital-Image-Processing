function [ output_img_fft ] = set_high_freq_mean( img_fft, peaks )
%SET_HIGH_FREQ_MEAN sets any high-ish frequency that is also a peak to the mean.
%   Detailed explanation goes here
[sizeY,sizeX] = size(img_fft);
deviationY = floor(sizeY/4);
deviationX = floor(sizeX/4);
midpointY = floor(sizeY/2);
midpointX = floor(sizeX/2);
output_img_fft = img_fft;

avg = mean(mean(img_fft));
peak_new = peaks;
peak_new(midpointY-(deviationY/2):midpointY+(deviationY/2),midpointX-(deviationX/2):midpointX+(deviationX/2)) = 0;

output_img_fft(peak_new) = 0;


end

