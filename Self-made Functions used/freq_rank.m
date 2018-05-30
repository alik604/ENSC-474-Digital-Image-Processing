function [ percentage ] = freq_rank( img_fft )
%FREQ_RANK calculate the % of low freq to high freq of an image, low being
% high freq will be 100, low frequecy is 0. input_fft being the logged low freq
% centred image.
%   Detailed explanation goes here

%% first step is to get the values of the two different ffts. 
%get low freq values.

[sizeY,sizeX] = size(img_fft);
deviationY = floor(sizeY/4);
deviationX = floor(sizeX/4);
midpointY = floor(sizeY/2);
midpointX = floor(sizeX/2);
output_img_fft = img_fft;

sizeofborders = 4.*deviationY.*deviationX;

avg_low_freq = abs(sum(sum(img_fft(...
    midpointY-deviationY:midpointY+deviationY,...
    midpointX-deviationX:midpointX+deviationX)))./sizeofborders);

highfreq = fftshift(img_fft);

avg_high_freq = abs(sum(sum(highfreq(...
    midpointY-deviationY:midpointY+deviationY,...
    midpointX-deviationX:midpointX+deviationX)))./sizeofborders);
%% now calc the percentage
    percentage = (avg_high_freq/(avg_low_freq+avg_high_freq)) .* 100;
end

