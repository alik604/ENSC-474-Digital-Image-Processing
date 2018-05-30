%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 4
% Date       : Feb 3, 2016
% MATLAB Ver : R2014a

% Details    : Run via 'main' function
%              Image Distances and Point Transformations Assignment
%              Calculates Euclidian and Penrose distances of images
%              Does FFT of a simple image and of a image which is of the
%              mugshot.
% Credits : A&W for sustinence in this time period of my life.

%% Main
function main
clear all;
close all;
 
%open mugshot images
greyscaleimg(:,:,1) = read_photos('picture/1g.jpg');
greyscaleimg(:,:,2) = read_photos('picture/2g.jpg');
greyscaleimg(:,:,3) = read_photos('picture/3g.jpg');
greyscaleimg(:,:,4) = read_photos('picture/4g.jpg');
greyscaleimg(:,:,5) = read_photos('picture/5g.jpg');
greyscaleimg(:,:,6) = read_photos('picture/6g.jpg');
greyscaleimg(:,:,7) = read_photos('picture/7g.jpg');
greyscaleimg(:,:,8) = read_photos('picture/8g.jpg');
greyscaleimg(:,:,9) = read_photos('picture/9g.jpg');
greyscaleimg(:,:,10) = read_photos('picture/10g.jpg');
% figure('Name', 'original image'); %shows image in a new window
% imshow(im2uint8(greyscaleimg));

%vectorise mugshot images
sizeofori = size(greyscaleimg);
numofelements = numel(greyscaleimg(:,:,1));
vectorimg(:,1) = reshape(greyscaleimg(:,:,1),[numofelements,1]);
vectorimg(:,2) = reshape(greyscaleimg(:,:,2),[numofelements,1]);
vectorimg(:,3) = reshape(greyscaleimg(:,:,3),[numofelements,1]);
vectorimg(:,4) = reshape(greyscaleimg(:,:,4),[numofelements,1]);
vectorimg(:,5) = reshape(greyscaleimg(:,:,5),[numofelements,1]);
vectorimg(:,6) = reshape(greyscaleimg(:,:,6),[numofelements,1]);
vectorimg(:,7) = reshape(greyscaleimg(:,:,7),[numofelements,1]);
vectorimg(:,8) = reshape(greyscaleimg(:,:,8),[numofelements,1]);
vectorimg(:,9) = reshape(greyscaleimg(:,:,9),[numofelements,1]);
vectorimg(:,10) = reshape(greyscaleimg(:,:,10),[numofelements,1]);


%get the mean of each pixel
meanimg = mean(vectorimg,2);

%display mean img
meanimg2D = reshape(meanimg,[sizeofori(1),sizeofori(2)]);
meanimg2D = im2uint8(meanimg2D); %cast to be able to write to .jpg
% figure('Name', 'mean_photo'); %shows image in a new window
% % imshow(meanimg2D);
write_photos(meanimg2D,'meanImg.jpg','mean_photo');

%get the standard deviation of the pixel
stddevimg = std(vectorimg,0,2);

%display stddev img
stddev2D = reshape(stddevimg,[sizeofori(1),sizeofori(2)]);
stddev2D = im2uint8(stddev2D); %cast to be able to write to .jpg
% figure('Name', 'std_photo'); %shows image in a new window
% imshow(stddev2D);
write_photos(stddev2D,'stddevImg.jpg','standardDeviation_photo');

%read in non-mugshot images and append them to the 
greyscaleimg(:,:,11) = read_photos('picture/chairgrey.jpg');
greyscaleimg(:,:,12) = read_photos('picture/friendgrey.jpg');
greyscaleimg(:,:,13) = read_photos('picture/windowgrey.jpg');
vectorimg(:,11) = reshape(greyscaleimg(:,:,11),[numofelements,1]);
vectorimg(:,12) = reshape(greyscaleimg(:,:,12),[numofelements,1]);
vectorimg(:,13) = reshape(greyscaleimg(:,:,13),[numofelements,1]);

%call functions to calculate distances.
euclidiandistance = calcEucDist(vectorimg);
penrosedistance = calcPenDist(vectorimg,meanimg,stddevimg);

%% Export Data to csv file.
T = cell2table(euclidiandistance);
writetable(T,'euclidiandistance.csv');
T = cell2table(penrosedistance);
writetable(T,'penrosedistance.csv');
%% PART 2

%create a simple image to FFT
I = zeros(480,270);
I(120:130,140:160) =1;
simImg = im2uint8(I); %cast to be able to write to .jpg
% figure('Name', 'simImg'); %shows image in a new window
% imshow(simImg)
write_photos(simImg,'sim_img.jpg','simple Image');
F = fft2(I); % FFT the image
figure('Name', 'Fourrier Transform simImg'); %shows image in a new window
fig = imagesc(abs(F)); %display fft
saveas(fig,'Fourrier_Transform_simImg.jpg');
fig = figure('Name', 'Log Fourrier Transform simImg'); %shows image in a new window
imagesc(log(abs(F)+1)); % display log of fft, +1 to prevent infinite result
saveas(fig,'Log_Fourrier_Transform_simImg.jpg');

%FFT one of the mugshot images
imagetofft = greyscaleimg(:,:,1);
F = fft2(imagetofft); %fft the mugshot
fig = figure('Name', 'Fourrier Transform mugshot'); %shows image in a new window
imagesc(abs(F)) %display fft
saveas(fig,'Fourrier_Transform_mugshot.jpg');
fig = figure('Name', 'Log Fourrier Transform mugshot'); %shows image in a new window
imagesc(log(abs(F)+1));% display log of fft, +1 to prevent infinite result
saveas(fig,'Log_Fourrier_Transform_mugshot.jpg');

end





