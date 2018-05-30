%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 7
% Date       : March 10, 2017
% MATLAB Ver : R2016b

% Details    : Run via 'main' function
%           Exploration of noisy image enhancement. 
% Credits : 

function main
%% Reading in the images.
close all;
clear all;
photo1 = read_photos('1grey.jpg');
photo2 = read_photos('2grey.jpg');
photo3 = read_photos('3grey.jpg');

[ysize1, xsize1] = size(photo1);
[ysize2, xsize2] = size(photo2);
[ysize3, xsize3] = size(photo3);


%% 1.1 Generate periodic noise of a M by N image.

% Case 1 : xweight = 0, yweight = 0;
[noisyimg1_1, imgnoise1_1] = gen_period_noise(photo1,0,0,0.2);
[noisyimg2_1, imgnoise2_1] = gen_period_noise(photo2,0,0,0.2);
[noisyimg3_1, imgnoise3_1] = gen_period_noise(photo3,0,0,0.2);
% Case 2 : xweight = M/4, yweight = 0;
[noisyimg1_2, imgnoise1_2] = gen_period_noise(photo1,(xsize1)/4,0,0.2);
[noisyimg2_2, imgnoise2_2] = gen_period_noise(photo2,(xsize2)/4,0,0.2);
[noisyimg3_2, imgnoise3_2] = gen_period_noise(photo3,(xsize3)/4,0,0.2);
% Case 3 : xweight = 0, yweight = N/2;
[noisyimg1_3, imgnoise1_3] = gen_period_noise(photo1,0,(ysize1)/2,0.2);
[noisyimg2_3, imgnoise2_3] = gen_period_noise(photo2,0,(ysize2)/2,0.2);
[noisyimg3_3, imgnoise3_3] = gen_period_noise(photo3,0,(ysize3)/2,0.2);
% Case 4 : xweight = M/2, yweight = N/4;
[noisyimg1_4, imgnoise1_4] = gen_period_noise(photo1,(xsize1)/2,(ysize1)/4,0.2);
[noisyimg2_4, imgnoise2_4] = gen_period_noise(photo2,(xsize2)/4,(ysize2)/4,0.2);
[noisyimg3_4, imgnoise3_4] = gen_period_noise(photo3,(xsize3)/4,(ysize3)/4,0.2);

%display noise profile
figure('Name', 'Periodic Noises');
subplot(1,4,1);
imshow(imgnoise1_1); title('Case 1, u0= 0, v0 = 0');
subplot(1,4,2); 
imshow(imgnoise1_2); title('Case2, u0 = M/4, v0 = 0');
subplot(1,4,3); 
imshow(imgnoise1_3); title('Case 3, u0 = 0, v0 = N/2');
subplot(1,4,4); 
imshow(imgnoise1_4); title('Case 4,u0 = M/2, v0 = N/4');
%% 1.2 Taking the 2D FFT for noise.
imgnoise1_1_fft = log10(fftshift(fft2(imgnoise1_1)));
imgnoise1_2_fft = log10(fftshift(fft2(imgnoise1_2)));
imgnoise1_3_fft = log10(fftshift(fft2(imgnoise1_3)));
imgnoise1_4_fft = log10(fftshift(fft2(imgnoise1_4)));
% imgnoise2_1_fft = log10(fftshift(fft2(imgnoise2_1)));
% imgnoise2_2_fft = log10(fftshift(fft2(imgnoise2_2)));
% imgnoise2_3_fft = log10(fftshift(fft2(imgnoise2_3)));
% imgnoise2_4_fft = log10(fftshift(fft2(imgnoise2_4)));

figure('Name', '2D FFT Noise Case1');
% imagesc(abs(imgnoise1_1_fft)); title('Image 1, Case 1')%display fft
mesh(abs(imgnoise1_1_fft)); title('Image 1, Case 1')%display fft
xlabel('X dimension fft') % x-axis label
ylabel('Y dimension fft') % y-axis label
figure('Name', '2D FFT Noise Case2');
% imagesc(abs(imgnoise1_2_fft)); title('Image 1, Case 2')%display fft
mesh(abs(imgnoise1_2_fft)); title('Image 1, Case 2')%display fft
xlabel('X dimension fft') % x-axis label
ylabel('Y dimension fft') % y-axis label
figure('Name', '2D FFT Noise Case3')
% imagesc(abs(imgnoise1_3_fft)); title('Image 1, Case 3')%display fft
mesh(abs(imgnoise1_3_fft)); title('Image 1, Case 3')%display fft
xlabel('X dimension fft') % x-axis label
ylabel('Y dimension fft') % y-axis label
figure('Name', '2D FFT Noise Case4')
% imagesc(abs(imgnoise1_4_fft)); title('Image 1, Case 4')%display fft
mesh(abs(imgnoise1_4_fft)); title('Image 1, Case 4')%display fft
xlabel('X dimension fft') % x-axis label
ylabel('Y dimension fft') % y-axis label

%% 2.1 Creating a new uint8 image of value 128
image_constant = uint8(zeros(640,480));
image_constant(:,:) = 128;
% 2.1a Adding Gaussian nouse of mean 0, variance 625 and 1000.
image_gaussian_noise_625 = imnoise(image_constant,'gaussian',0/255,625/(255*255));
image_gaussian_noise_1000 = imnoise(image_constant,'gaussian',0/255,1000/(255*255));

% 2.1b Adding Salt and pepper noise.
image_pepper_low = imnoise(image_constant,'salt & pepper',0.03);
image_pepper_mid = imnoise(image_constant,'salt & pepper');
image_pepper_hgh = imnoise(image_constant,'salt & pepper',0.1);

%2.2 Display images, and Histogram.
figure('Name', 'Gaussian noise 625 variance')
subplot(1,2,1);
imshow(image_gaussian_noise_625); 
title('Gaussian Noise, 0 mean, 625 Variance');
subplot(1,2,2);
imhist(image_gaussian_noise_625); 
title('histogram, Gaussian Noise, 0 mean, 625 Variance');

figure('Name', 'Gaussian noise 1000 variance')
subplot(1,2,1);
imshow(image_gaussian_noise_1000); 
title('Gaussian Noise, 0 mean, 1000 Variance');
subplot(1,2,2);
imhist(image_gaussian_noise_1000); 
title('histogram, Gaussian Noise, 0 mean, 1000 Variance');

figure('Name', 'Salt and Pepper low')
subplot(1,2,1);
imshow(image_pepper_low); 
title('Salt & Pepper, d = 0.03');
subplot(1,2,2);
imhist(image_pepper_low); 
title('histogram, Salt & Pepper, d = 0.03');

figure('Name', 'Salt and Pepper mid')
subplot(1,2,1);
imshow(image_pepper_mid); 
title('Salt & Pepper, d = 0.05');
subplot(1,2,2)
imhist(image_pepper_mid); 
title('histogram, Salt & Pepper, d = 0.05');

figure('Name', 'Salt and Pepper high')
subplot(1,2,1);
imshow(image_pepper_hgh); 
title('Salt & Pepper, d = 0.1');
subplot(1,2,2);
imhist(image_pepper_hgh); 
title('histogram, Salt & Pepper, d = 0.1');

%% 3.1 Making our unique camera. 
NOISE_WEIGHT = 0.1;

motion_blur = fspecial('motion',25,pi); %generate motion blur mask.
%blur images.
blurred_img_1 = imfilter(photo1,motion_blur);
blurred_img_2 = imfilter(photo2,motion_blur);
blurred_img_3 = imfilter(photo3,motion_blur);

%add periodic noise
%clipping is intentional, cause thats what happens in a real camera.
noisy_image_1_ped = blurred_img_1+(NOISE_WEIGHT.*imgnoise1_4);
noisy_image_2_ped = blurred_img_2+(NOISE_WEIGHT.*imgnoise2_4);
noisy_image_3_ped = blurred_img_3+(NOISE_WEIGHT.*imgnoise3_4);

%add random noise
noisy_image_1_both = imnoise(noisy_image_1_ped,'gaussian',0/255,625/(255*255));
noisy_image_2_both = imnoise(noisy_image_2_ped,'gaussian',0/255,625/(255*255));
noisy_image_3_both = imnoise(noisy_image_3_ped,'gaussian',0/255,625/(255*255));

%From Assignment: "This novel one-of-a-kind MATLAB camera"
%"  This is my camera, there are many like it, but this one is mine.
%   My camera is my best friend. It is my life. I must master it as I must master my life.    "
%Been there done that...

%display images
figure('Name', '1grey.jpg - Noised and blurred');
imshow(noisy_image_1_both);
figure('Name', '2grey.jpg - Noised and blurred');
imshow(noisy_image_2_both);
figure('Name', '3grey.jpg - Noised and blurred');
imshow(noisy_image_3_both);

% 3.2 now we gotta try to get that original image back. 
noisy_image_1_fft = fft2(noisy_image_1_both);
noisy_image_1_fft = fftshift(noisy_image_1_fft);
noisy_image_1_fft_logged = log(abs(noisy_image_1_fft));

% Removal of periodic noise by masking.
figure('Name', '1grey.jpg - Noised and blurred - FFT');
subplot(1,3,1);
imagesc(noisy_image_1_fft_logged); title('1grey.jpg - Noised and blurred - FFT')%display fft
xlabel('X dimension fft') % x-axis label
ylabel('Y dimension fft') % y-axis label
subplot(1,3,2);
mesh(noisy_image_1_fft_logged);

%find peaks outside low freq.
peaks_1 = (noisy_image_1_fft_logged > 6.5); 
subplot(1,3,3)
imshow(peaks_1); title('Peaks above 6.5');

%remove peaks
noisy_image_1_fft_no_peaks = set_high_freq_mean(noisy_image_1_fft,peaks_1);
noisy_image_1_fft_no_peaks_logged = log(abs(noisy_image_1_fft_no_peaks));

%show fft after peak removal
figure('Name', '1grey.jpg - De-Noised and blurred - FFT');
subplot(1,2,1);
mesh(noisy_image_1_fft_no_peaks_logged);
title('1grey.jpg - periodic noise removed - fft');
xlabel('X dimension fft') % x-axis label
ylabel('Y dimension fft') % y-axis label

%inverse fft it and show.
noisy_image_1_no_peaks = abs(ifft2(noisy_image_1_fft_no_peaks));
% figure('Name', '1grey.jpg - De-Noised and blurred');
subplot(1,2,2);
imshow(noisy_image_1_no_peaks);
title('1grey.jpg - periodic noise removed');

%% now remove the random noise.
% we are going to use an averaging mask.
m = 1/13;
mask = [0, 0,   m, 0, 0;...
        0, m,   m, m, 0;...
        m, m,   m, m, m;...
        0, m,   m, m, 0;...
        0, 0,   m, 0, 0];       %13 in total.
    
% alternate mask
% m = 1/5;
% mask = [0,m,0;...
%         m,m,m;...
%         0,m,0];
    
noisy_image_1_noise_remv = mask_image(mask,noisy_image_1_no_peaks);
noisy_image_1_noise_remv_fft = fftshift(log(abs(fft2(noisy_image_1_noise_remv))));

figure('Name', '1grey.jpg - All De-Noised and blurred');
subplot(1,2,1);
imshow(noisy_image_1_noise_remv);
title('1grey.jpg - noise removed');
subplot(1,2,2);
mesh(noisy_image_1_noise_remv_fft);
title('1grey.jpg - noise removed - fft');

%% Now to do the deconvolution.
%NSR of 0.02;
% NSR = NOISE_WEIGHT;
NSR = 0.02;
restored_image_1 = deconvwnr(noisy_image_1_noise_remv,motion_blur,NSR);
figure('Name', '1grey.jpg - All De-Noised and De-blurred NSR 0.02');
subplot(1,2,1);
imshow(restored_image_1);
title('1grey.jpg - restored NSR 0.02');
subplot(1,2,2);
imshow(photo1);
title('1grey.jpg - original');

%NSR of 0.03;
% NSR = NOISE_WEIGHT;
NSR = 0.03;
restored_image_1 = deconvwnr(noisy_image_1_noise_remv,motion_blur,NSR);
figure('Name', '1grey.jpg - All De-Noised and De-blurred NSR 0.03');
subplot(1,2,1);
imshow(restored_image_1);
title('1grey.jpg - restored NSR 0.03');
subplot(1,2,2);
imshow(photo1);
title('1grey.jpg - original');


%NSR of 0.05;
% NSR = NOISE_WEIGHT;
NSR = 0.05;
restored_image_1 = deconvwnr(noisy_image_1_noise_remv,motion_blur,NSR);
figure('Name', '1grey.jpg - All De-Noised and De-blurred NSR 0.05');
subplot(1,2,1);
imshow(restored_image_1);
title('1grey.jpg - restored NSR 0.05');
subplot(1,2,2);
imshow(photo1);
title('1grey.jpg - original');

%NSR of 0.1;
% NSR = NOISE_WEIGHT;
NSR = 0.1;
restored_image_1 = deconvwnr(noisy_image_1_noise_remv,motion_blur,NSR);
figure('Name', '1grey.jpg - All De-Noised and De-blurred');
subplot(1,2,1);
imshow(restored_image_1);
title('1grey.jpg - restored NSR 0.1');
subplot(1,2,2);
imshow(photo1);
title('1grey.jpg - original');

%NSR of 0.2;
% NSR = NOISE_WEIGHT;
NSR = 0.2;
restored_image_1 = deconvwnr(noisy_image_1_noise_remv,motion_blur,NSR);
figure('Name', '1grey.jpg - All De-Noised and De-blurred');
subplot(1,2,1);
imshow(restored_image_1);
title('1grey.jpg - restored NSR 0.2');
subplot(1,2,2);
imshow(photo1);
title('1grey.jpg - original');
end
