%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 6
% Date       : Feb 24, 2017
% MATLAB Ver : R2016b

% Details    : Run via 'main' function
%           
% The company you are working for needs to tag images that are slowly varying from ones that are fast varying.
% As the in-house image processing engineer, you are asked to design an algorithm to measure if an image is 
% predominantly "low frequency" vs predominantly "high frequency". Ideally, your algorithm gives a score in 
% the range of 0 - 100 for each image, where a score less than 50 is used to define an image as being 
% predominantly "low" frequency and score greater than 50 is used to define an image as being predominantly 
% "high" frequency image.
% 
% Task: design an appropriate algorithm for this task as required by your company...you can use any/all 
% Matlab in-built commands you find useful.
% 
% Validation: To test your algorithm and show the results to your team, you decide to create a database 
% of images with low and high frequency content. You take your mugshot image, and two or three more images 
% you have taken yourself, and create 10-12 images from this initial set of 2-4 images. Half of these images 
% contain predominantly low frequencies (ie you have taken out the high frequencies yourself) and the 
% remaining of these images contain predominantly high frequencies (ie you have taken out the low frequencies 
% yourself).
% 
%  
% 
% Next you generate a report in which you show these images and the score your frequency-metering algorithm 
% creates for each image. Thanks to your work, your company is able to launch a frequency-metering app that 
% becomes quite popular and earns the company several million dollars!  

% Credits : 

function main
%% Reading in the images.
close all;
clear all;
photo1 = read_photos('1g.jpg');
photo2 = read_photos('2g.jpg');
photo3 = read_photos('3g.jpg');

%% Convert to the Frequency Domain
photo1_fft=fft2(photo1);
photo2_fft=fft2(photo2);
photo3_fft=fft2(photo3);

%% Shift Low Frequency to Center
photo1_fft_low=fftshift(photo1_fft);
photo2_fft_low=fftshift(photo2_fft);
photo3_fft_low=fftshift(photo3_fft);

%% Log so we can actually see the difference.

photo1_fft_logged = log10(photo1_fft_low);
photo2_fft_logged = log10(photo2_fft_low);
photo3_fft_logged = log10(photo3_fft_low);

%% Show the frequencies of original. Redundant as I do it in the subplot later.
% fig = figure('Name', '1g fft'); %shows image in a new window
% imagesc(abs(photo1_fft_logged)); %display fft
% fig = figure('Name', '2g fft'); %shows image in a new window
% imagesc(abs(photo2_fft_logged)); %display fft
% fig = figure('Name', '3g fft'); %shows image in a new window
% imagesc(abs(photo3_fft_logged)); %display fft

%% Filter the images with gaussian filtering.
photo1_gaussian = imgaussfilt(photo1,1);
photo2_gaussian = imgaussfilt(photo2,1);
photo3_gaussian = imgaussfilt(photo3,1);

%% FFT the filtered Images
photo1_gauss_fft=fft2(photo1_gaussian);
photo2_gauss_fft=fft2(photo2_gaussian);
photo3_gauss_fft=fft2(photo3_gaussian);

%% Shift Low Frequency to Center
photo1_gauss_fft_low=fftshift(photo1_gauss_fft);
photo2_gauss_fft_low=fftshift(photo2_gauss_fft);
photo3_gauss_fft_low=fftshift(photo3_gauss_fft);

%% log them
photo1_gauss_fft_logged = log10(photo1_gauss_fft_low);
photo2_gauss_fft_logged = log10(photo2_gauss_fft_low);
photo3_gauss_fft_logged = log10(photo3_gauss_fft_low);

%% display images
figure('Name', '1g');
subplot(1,4,1);
imshow(photo1); title('1g Original');
subplot(1,4,2);
imagesc(abs(photo1_fft_logged)); title('1g fft log10'); %display fft
subplot(1,4,3);
imshow(photo1_gaussian); title('1g Gaussian Filter');
subplot(1,4,4);
imagesc(abs(photo1_gauss_fft_logged)); title('1g filtered fft log10'); %display fft

figure('Name', '2g');
subplot(1,4,1);
imshow(photo2); title('2g Original');
subplot(1,4,2);
imagesc(abs(photo2_fft_logged)); title('2g fft log10')%display fft
subplot(1,4,3);
imshow(photo2_gaussian); title('2g Gaussian Filter');
subplot(1,4,4);
imagesc(abs(photo2_gauss_fft_logged)); title('2g filtered fft log10'); %display fft

figure('Name', '3g');
subplot(1,4,1);
imshow(photo3); title('3g Original');
subplot(1,4,2);
imagesc(abs(photo3_fft_logged)); title('3g fft log10')%display fft
subplot(1,4,3);
imshow(photo3_gaussian); title('3g Gaussian Filter');
subplot(1,4,4);
imagesc(abs(photo3_gauss_fft_logged)); title('3g filtered fft log10'); %display fft

%% Generate a few more images using my own filter (ideal lowpass, fourrier domain)
[photo1_fft_ideal_low, photo1_fft_ideal_low_log] = my_filter(photo1_fft_low);
[photo2_fft_ideal_low,photo2_fft_ideal_low_log] = my_filter(photo2_fft_low);
[photo3_fft_ideal_low,photo3_fft_ideal_low_log] = my_filter(photo3_fft_low);

%% Generate more images using my own filter (ideal highpass now, fourrier domain)
[photo1_fft_ideal_high, photo1_fft_ideal_high_log] = my_filter(photo1_fft);
[photo2_fft_ideal_high,photo2_fft_ideal_high_log] = my_filter(photo2_fft);
[photo3_fft_ideal_high,photo3_fft_ideal_high_log] = my_filter(photo3_fft);
% need to shift those fft graphs to be in sync with the others that will be
% displayed Shift Low Frequency to Center
photo1_fft_ideal_high_log=fftshift(photo1_fft_ideal_high_log);
photo2_fft_ideal_high_log=fftshift(photo2_fft_ideal_high_log);
photo3_fft_ideal_high_log=fftshift(photo3_fft_ideal_high_log);

%% inverse fft them so we can display the new output images.
photo1_ideal_low = mat2gray(real(ifft2(photo1_fft_ideal_low)));
photo2_ideal_low = mat2gray(real(ifft2(photo2_fft_ideal_low)));
photo3_ideal_low = mat2gray(real(ifft2(photo3_fft_ideal_low)));

photo1_ideal_high = mat2gray(real(ifft2(photo1_fft_ideal_high)));
photo2_ideal_high = mat2gray(real(ifft2(photo2_fft_ideal_high)));
photo3_ideal_high = mat2gray(real(ifft2(photo3_fft_ideal_high)));

%% display these images 
% lowpass first
figure('Name', '1g');
subplot(1,4,1);
imshow(photo1); title('1g Original');
subplot(1,4,2);
imagesc(abs(photo1_fft_logged)); title('1g fft log10'); %display fft
subplot(1,4,3);
imshow(photo1_ideal_low); title('1g Ideal lowpass Own Filter');
subplot(1,4,4);
imagesc(abs(photo1_fft_ideal_low_log)); title('1g filtered fft log10'); %display fft

figure('Name', '2g');
subplot(1,4,1);
imshow(photo2); title('2g Original');
subplot(1,4,2);
imagesc(abs(photo2_fft_logged)); title('2g fft log10')%display fft
subplot(1,4,3);
imshow(photo2_ideal_low); title('2g Ideal lowpass Own Filter');
subplot(1,4,4);
imagesc(abs(photo2_fft_ideal_low_log)); title('2g filtered fft log10'); %display fft

figure('Name', '3g');
subplot(1,4,1);
imshow(photo3); title('3g Original');
subplot(1,4,2);
imagesc(abs(photo3_fft_logged)); title('3g fft log10')%display fft
subplot(1,4,3);
imshow(photo3_ideal_low); title('3g Ideal lowpass Own Filter');
subplot(1,4,4);
imagesc(abs(photo3_fft_ideal_low_log)); title('3g filtered fft log10'); %display fft

%now highpass
figure('Name', '1g');
subplot(1,4,1);
imshow(photo1); title('1g Original');
subplot(1,4,2);
imagesc(abs(photo1_fft_logged)); title('1g fft log10'); %display fft
subplot(1,4,3);
imshow(photo1_ideal_high); title('1g Ideal highpass Own Filter');
subplot(1,4,4);
imagesc(abs(photo1_fft_ideal_high_log)); title('1g filtered fft log10'); %display fft

figure('Name', '2g');
subplot(1,4,1);
imshow(photo2); title('2g Original');
subplot(1,4,2);
imagesc(abs(photo2_fft_logged)); title('2g fft log10')%display fft
subplot(1,4,3);
imshow(photo2_ideal_high); title('2g Ideal highpass Own Filter');
subplot(1,4,4);
imagesc(abs(photo2_fft_ideal_high_log)); title('2g filtered fft log10'); %display fft

figure('Name', '3g');
subplot(1,4,1);
imshow(photo3); title('3g Original');
subplot(1,4,2);
imagesc(abs(photo3_fft_logged)); title('3g fft log10')%display fft
subplot(1,4,3);
imshow(photo3_ideal_high); title('3g Ideal highpass Own Filter');
subplot(1,4,4);
imagesc(abs(photo3_fft_ideal_high_log)); title('3g filtered fft log10'); %display fft

%% Do Gauss filtering for sigma = 2, for investigation purposes.
%% Filter the images with gaussian filtering.
photo1_gaussian_2 = imgaussfilt(photo1,2);
photo2_gaussian_2 = imgaussfilt(photo2,2);
photo3_gaussian_2 = imgaussfilt(photo3,2);

%% FFT the filtered Images
photo1_gauss_fft_2=fft2(photo1_gaussian_2);
photo2_gauss_fft_2=fft2(photo2_gaussian_2);
photo3_gauss_fft_2=fft2(photo3_gaussian_2);

%% Shift Low Frequency to Center
photo1_gauss_fft_low_2=fftshift(photo1_gauss_fft_2);
photo2_gauss_fft_low_2=fftshift(photo2_gauss_fft_2);
photo3_gauss_fft_low_2=fftshift(photo3_gauss_fft_2);

%% log them
photo1_gauss_fft_logged_2 = log10(photo1_gauss_fft_low_2);
photo2_gauss_fft_logged_2 = log10(photo2_gauss_fft_low_2);
photo3_gauss_fft_logged_2 = log10(photo3_gauss_fft_low_2);

%% Implementation of the ranking algorithm. 
% the algorithm will be as follows, we will be taking the pecentage of low
% freq to high freq, this will be out ranking 0-100.
%low frequency will be defined as the frequency up to the halfway mark to
%the edge of the image. 

% Take the ranking of our original images
photo1_rank = freq_rank(photo1_fft_logged);
photo2_rank = freq_rank(photo2_fft_logged);
photo3_rank = freq_rank(photo3_fft_logged);

%Take the ranking of inbuilt gaussian filtered images
photo1_rank_gauss = freq_rank(photo1_gauss_fft_logged);
photo2_rank_gauss = freq_rank(photo2_gauss_fft_logged);
photo3_rank_gauss = freq_rank(photo3_gauss_fft_logged);

%Take the ranking of the high and low ideal self-made filters
photo1_fft_ideal_low_log_rank = freq_rank(photo1_fft_ideal_low_log);
photo2_fft_ideal_low_log_rank = freq_rank(photo2_fft_ideal_low_log);
photo3_fft_ideal_low_log_rank = freq_rank(photo3_fft_ideal_low_log);

photo1_fft_ideal_high_log_rank = freq_rank(photo1_fft_ideal_high_log);
photo2_fft_ideal_high_log_rank = freq_rank(photo2_fft_ideal_high_log);
photo3_fft_ideal_high_log_rank = freq_rank(photo3_fft_ideal_high_log);

%Take the ranking of inbuilt gaussian filtered images for sigma 2
photo1_rank_gauss_2 = freq_rank(photo1_gauss_fft_logged_2);
photo2_rank_gauss_2 = freq_rank(photo2_gauss_fft_logged_2);
photo3_rank_gauss_2 = freq_rank(photo3_gauss_fft_logged_2);

%% Write to single table for easy reading
results =  [    photo1_rank,                     photo2_rank,                    photo3_rank; ...
                photo1_rank_gauss,               photo2_rank_gauss,              photo3_rank_gauss;...
                photo1_rank_gauss_2,             photo2_rank_gauss_2,            photo3_rank_gauss_2;...
                photo1_fft_ideal_low_log_rank,   photo2_fft_ideal_low_log_rank,  photo3_fft_ideal_low_log_rank;...
                photo1_fft_ideal_high_log_rank,  photo2_fft_ideal_high_log_rank, photo3_fft_ideal_high_log_rank; ]
                
csvwrite('results.csv',results);
end