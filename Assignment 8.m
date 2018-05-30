%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 8
% Date       : March 17, 2017
% MATLAB Ver : R2016b

% Details    : Run via 'main' function
%              Restoration of noisy image.
%              Image registration assignment
% Credits : 
%%
function main
close all;
clear all;


saturnrings = read_photos('SaturnRings+Noise.png');
figure('Name', 'FFT');
subplot(2,2,1);
imshow(saturnrings); title('Original');
subplot(2,2,2); 
mesh(log(abs(fftshift(fft2(saturnrings))))); title('FFT Original');
%implement a median filter here to get rid of salt and pepper noise.
mask = [1,1,1;1,1,1;1,1,1];
saturnrings_medianed = median_filter(saturnrings, mask);
subplot(2,2,3);
imshow(saturnrings_medianed); title('Median-ed');
subplot(2,2,4);
mesh(log(abs(fftshift(fft2(saturnrings_medianed))))); title('FFT of Median-ed');

%bigger median filter.
mask = [1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;]; %5x5 median filter
saturnrings_medianed_5 = median_filter(saturnrings, mask);
figure('Name', 'Median Filter Comparison');
subplot(1,2,1);
imshow(saturnrings_medianed); title('Median-ed 3x3');
subplot(1,2,2);
imshow(saturnrings_medianed_5); title('Median-ed 5x5');

%peak set filter peaks above 5.5.
saturnrings_medianed_fft_log = log(abs(fftshift(fft2(saturnrings_medianed))));
peaks = (saturnrings_medianed_fft_log > 5.5);
figure();
subplot(1,3,1);
imshow(peaks); title('Peaks above 5.5');
saturnrings_peak_removed = set_high_freq_mean(fftshift(fft2(saturnrings_medianed)),peaks);
peaks_rmv = (log(abs(saturnrings_peak_removed)) > 5.5);
subplot(1,3,2);
imshow(peaks_rmv); title('After Peak Rmval');
subplot(1,3,3);
mesh(log(abs(saturnrings_peak_removed))); title('FFT after Peak Removal');
figure();
saturnrings_peak_removed_ifft = ifft2(fftshift(saturnrings_peak_removed));
imshow(saturnrings_peak_removed_ifft); title('After Periodic Noise Removal');

%sharpen image
saturnrings_sharpened = sharpen_img(saturnrings_peak_removed_ifft,0.7);
figure();
imshow(abs(saturnrings_sharpened)); title('After Periodic Noise Removal and Sharpened 0.7');
write_photos(abs(saturnrings_sharpened),'SaturnRings.png','After Noise Removal');

%peak set filter peaks above 6.5
peaks = (saturnrings_medianed_fft_log > 6.5);
figure();
subplot(1,3,1);
imshow(peaks); title('Peaks above 6.5');
saturnrings_peak_removed = set_high_freq_mean(fftshift(fft2(saturnrings_medianed)),peaks);
peaks_rmv = (log(abs(saturnrings_peak_removed)) > 6.5);
subplot(1,3,2);
imshow(peaks_rmv); title('After Peak Rmval');
subplot(1,3,3);
mesh(log(abs(saturnrings_peak_removed))); title('FFT after Peak Removal');
saturnrings_peak_removed_ifft_65 = ifft2(fftshift(saturnrings_peak_removed));

%peak set filter peaks above 4.5
peaks = (saturnrings_medianed_fft_log > 4.5);
figure();
subplot(1,3,1);
imshow(peaks); title('Peaks above 4.5');
saturnrings_peak_removed = set_high_freq_mean(fftshift(fft2(saturnrings_medianed)),peaks);
peaks_rmv = (log(abs(saturnrings_peak_removed)) > 4.5);
subplot(1,3,2);
imshow(peaks_rmv); title('After Peak Rmval');
subplot(1,3,3);
mesh(log(abs(saturnrings_peak_removed))); title('FFT after Peak Removal');
saturnrings_peak_removed_ifft_45 = ifft2(fftshift(saturnrings_peak_removed));


figure();
subplot(1,3,1);
imshow(saturnrings_peak_removed_ifft_45); title('After Periodic Noise Removal 4.5');
subplot(1,3,2);
imshow(saturnrings_peak_removed_ifft); title('After Periodic Noise Removal 5.5');
subplot(1,3,3);
imshow(saturnrings_peak_removed_ifft_65); title('After Periodic Noise Removal 6.5');


%sharpen image
saturnrings_sharpened_51 = sharpen_img(saturnrings_peak_removed_ifft,0.51);
saturnrings_sharpened_8 = sharpen_img(saturnrings_peak_removed_ifft,0.8);
figure();
subplot(1,3,1);
imshow(abs(saturnrings_sharpened_51)); title('After Periodic Noise Removal and Sharpened 0.51');
subplot(1,3,3);
imshow(abs(saturnrings_sharpened_8)); title('After Periodic Noise Removal and Sharpened 0.8');
subplot(1,3,2);
imshow(abs(saturnrings_sharpened)); title('After Periodic Noise Removal and Sharpened 0.7');

%% Part 2 of assignment. Image Registration.
img1 = read_photos('1grey.jpg');
img2 = read_photos('2grey.jpg');

movingPoints = csvread('movingPoints.csv'); %image 1
fixedPoints = csvread('fixedPoints.csv'); %image 2

figure('Name', 'Points on Img 1'); 
imshow(img1);
hold on;
plot(movingPoints(:,1),movingPoints(:,2),'oy') 
title('Points on Img 1');

figure('Name', 'Points on Img 2');
imshow(img2);
hold on;
plot(fixedPoints(:,1),fixedPoints(:,2),'oy') 
title('Points on Img 2');

hold off;

%% I'm curious about the inbuilt functions... Lets try them out.
%polynomial of degree 3
transformation = fitgeotrans(movingPoints, fixedPoints, 'polynomial',3);
transformed_img1_p3 = imwarp(img1,transformation,'OutputView',imref2d(size(img2)));
figure();
% imshow(transformed_img1); title('Transformed Img 1');
subplot(1,2,1);
imshowpair(transformed_img1_p3,img2); title('Overlayed Images with Inbuilt MATLAB Functions Image Polynomial(3)');
diff_img_inbuilt = mat2gray(transformed_img1_p3 - img2);
subplot(1,2,2);
imshow(diff_img_inbuilt); title ('Inbuilt Difference Image Polynomial(3)');

%polynomial of degree 2
transformation = fitgeotrans(movingPoints, fixedPoints, 'polynomial',2);
transformed_img1_p2 = imwarp(img1,transformation,'OutputView',imref2d(size(img2)));
figure();
% imshow(transformed_img1); title('Transformed Img 1');
subplot(1,2,1);
imshowpair(transformed_img1_p2,img2); title('Overlayed Images with Inbuilt MATLAB Functions Image Polynomial(2)');
diff_img_inbuilt = mat2gray(transformed_img1_p2 - img2);
subplot(1,2,2);
imshow(diff_img_inbuilt); title ('Inbuilt Difference Image Polynomial(2)');

%affine transformation
transformation = fitgeotrans(movingPoints, fixedPoints, 'affine');
transformed_img1_a = imwarp(img1,transformation,'OutputView',imref2d(size(img2)));
figure();
subplot(1,2,1);
% imshow(transformed_img1); title('Transformed Img 1');
imshowpair(transformed_img1_a,img2); title('Overlayed Images with Inbuilt MATLAB Functions affine');
diff_img_inbuilt = mat2gray(transformed_img1_a - img2);
subplot(1,2,2);
imshow(diff_img_inbuilt); title ('Inbuilt Difference Image affine');

%Local Weighted Mean 6 points
transformation = fitgeotrans(movingPoints, fixedPoints, 'lwm', 6);
transformed_img1_lmw6 = imwarp(img1,transformation,'OutputView',imref2d(size(img2)));
figure();
subplot(1,2,1);
% imshow(transformed_img1); title('Transformed Img 1');
imshowpair(transformed_img1_lmw6,img2); title('Overlayed Images with Inbuilt MATLAB Functions LWM(6)');
diff_img_inbuilt = mat2gray(transformed_img1_lmw6 - img2);
subplot(1,2,2);
imshow(diff_img_inbuilt); title ('Inbuilt Difference Image LWM(6)');

%Local Weighted Mean 10 points
transformation = fitgeotrans(movingPoints, fixedPoints, 'lwm', 10);
transformed_img1_lmw10 = imwarp(img1,transformation,'OutputView',imref2d(size(img2)));
figure();
subplot(1,2,1);
% imshow(transformed_img1); title('Transformed Img 1');
imshowpair(transformed_img1_lmw10,img2); title('Overlayed Images with Inbuilt MATLAB Functions LWM(10)');
diff_img_inbuilt = mat2gray(transformed_img1_lmw10 - img2);
subplot(1,2,2);
imshow(diff_img_inbuilt); title ('Inbuilt Difference Image LWM(10)');

%overall difference plot
figure();
subplot(1,5,1);
imshowpair(transformed_img1_p3,img2); title('Overlayed Images with Inbuilt MATLAB Functions Image Polynomial(3)');
subplot(1,5,2);
imshowpair(transformed_img1_p2,img2); title('Overlayed Images with Inbuilt MATLAB Functions Image Polynomial(2)');
subplot(1,5,3);
imshowpair(transformed_img1_a,img2); title('Overlayed Images with Inbuilt MATLAB Functions affine');
subplot(1,5,4);
imshowpair(transformed_img1_lmw6,img2); title('Overlayed Images with Inbuilt MATLAB Functions LWM(6)');
subplot(1,5,5);
imshowpair(transformed_img1_lmw10,img2); title('Overlayed Images with Inbuilt MATLAB Functions LWM(10)');
%% Cool, now lets try it with a function I attempt to make.
% Ok didn't work. It's a WIP. 
% First lets get the mean
% mean1 = (mean(movingPoints));
% mean2 = (mean(fixedPoints));
% 
% %now get the covariance.
% [numberPoints, numberDimensons] = size(movingPoints);
% covariance = ((fixedPoints-mean2)'*((movingPoints-mean1)))./numberPoints;
% %find the SVD
% [U,D,V] = svd(covariance);
% %check D
% if D >= 1
%     S = [1,0;0,1];
% else
%     S = [1,0;0,-1];
% end
% 
% rotation =  U*S*V';
% % mean1_rotated = 



end