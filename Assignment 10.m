%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 10
% Date       : March 31 2017
% MATLAB Ver : R2016b

% Details    : Run via 'main' function
%              K-means Assignment
% Credits : 
%%
close all;
clear all;

%% crop circles w/built-in k = 2
k = 2;
crop_circles = read_photos('Crop Circlesgrey.jpg');
size_of_crop_circles = size(crop_circles);
number_elements_crops = numel(crop_circles);

crop_circles_vector = reshape(crop_circles,[number_elements_crops, 1]);
[idx,C] = kmeans(crop_circles_vector,k);
crop_circles_kmean = reshape(idx,size_of_crop_circles);

for ii = 1:k
    crop_circles_mean(:,:,ii) = (crop_circles_kmean == ii);
end

figure('Name', 'Inbuilt Crop');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(crop_circles_mean(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% crop circles w/built-in k=3
k=3;
crop_circles = read_photos('Crop Circlesgrey.jpg');
size_of_crop_circles = size(crop_circles);
number_elements_crops = numel(crop_circles);

crop_circles_vector = reshape(crop_circles,[number_elements_crops, 1]);
[idx,C] = kmeans(crop_circles_vector,k);
crop_circles_kmean = reshape(idx,size_of_crop_circles);

for ii = 1:k
    crop_circles_mean(:,:,ii) = (crop_circles_kmean == ii);
end

figure('Name', 'Inbuilt Crop');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(crop_circles_mean(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% crop circles w/built-in k=4
k=4;
crop_circles = read_photos('Crop Circlesgrey.jpg');
size_of_crop_circles = size(crop_circles);
number_elements_crops = numel(crop_circles);

crop_circles_vector = reshape(crop_circles,[number_elements_crops, 1]);
[idx,C] = kmeans(crop_circles_vector,k);
crop_circles_kmean = reshape(idx,size_of_crop_circles);

for ii = 1:k
    crop_circles_mean(:,:,ii) = (crop_circles_kmean == ii);
end

figure('Name', 'Inbuilt Crop');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(crop_circles_mean(:,:,ii));
    title(['K = ' num2str(ii)]);
end
%% Crop Circles (Own Function k=2)
k = 2;
crop_circles = read_photos('Crop Circlesgrey.jpg');
% limit = 500;
limit = 100;
tic;
[region_num, region_means] = my_kmean_exp(crop_circles, k,limit);
toc;

figure('Name', 'Own Crop');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(region_num(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Crop Circles (Own Function k=3)
k = 3;
crop_circles = read_photos('Crop Circlesgrey.jpg');
% limit = 500;
limit = 100;
tic;
[region_num, region_means] = my_kmean_exp(crop_circles, k,limit);
toc;

figure('Name', 'Own Crop');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(region_num(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Crop Circles (Own Function k=4)
k = 4;
crop_circles = read_photos('Crop Circlesgrey.jpg');
% limit = 500;
limit = 100;
tic;
[region_num, region_means] = my_kmean_exp(crop_circles, k,limit);
toc;

figure('Name', 'Own Crop');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(region_num(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Mugshot Img w/built-in (k=2)

k = 2;
% mugshot = read_photos('7grey.jpg');
mugshot = read_photos('1g.jpg');
size_of_mugshot = size(mugshot);
number_elements_mugshot = numel(mugshot);

mugshot_vector = reshape(mugshot,[number_elements_mugshot, 1]);
[idx,C] = kmeans(mugshot_vector,k);
mugshot_kmean = reshape(idx,size_of_mugshot);

for ii = 1:k
    mugshot_mean(:,:,ii) = (mugshot_kmean == ii);
end

figure('Name', 'Inbuilt mugshot');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(mugshot_mean(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Mugshot Img w/built-in (k=3)

k = 3;
% mugshot = read_photos('7grey.jpg');
mugshot = read_photos('1g.jpg');
size_of_mugshot = size(mugshot);
number_elements_mugshot = numel(mugshot);

mugshot_vector = reshape(mugshot,[number_elements_mugshot, 1]);
[idx,C] = kmeans(mugshot_vector,k);
mugshot_kmean = reshape(idx,size_of_mugshot);

for ii = 1:k
    mugshot_mean(:,:,ii) = (mugshot_kmean == ii);
end

figure('Name', 'Inbuilt mugshot');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(mugshot_mean(:,:,ii));
    title(['K = ' num2str(ii)]);
end


%% Mugshot Img w/built-in (k=4)

k = 4;
% mugshot = read_photos('7grey.jpg');
mugshot = read_photos('1g.jpg');
size_of_mugshot = size(mugshot);
number_elements_mugshot = numel(mugshot);

mugshot_vector = reshape(mugshot,[number_elements_mugshot, 1]);
[idx,C] = kmeans(mugshot_vector,k);
mugshot_kmean = reshape(idx,size_of_mugshot);

for ii = 1:k
    mugshot_mean(:,:,ii) = (mugshot_kmean == ii);
end

figure('Name', 'Inbuilt mugshot');
for ii = 1:k
    subplot(1,k,ii); 
    imshow(mugshot_mean(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Mugshot Images (Own Function k=2)
k=2;
% mugshot = read_photos('7grey.jpg');
mugshot = read_photos('1g.jpg');
% limit = 500;
limit = 100;
tic;
[region_num, region_means] = my_kmean_exp( mugshot, k,limit);
toc;

figure('Name', 'mugshot - k=2');
for ii = 1:k
    subplot(1,k,ii);
    imshow(region_num(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Mugshot Images (Own Function k=3)
k=3;
% mugshot = read_photos('7grey.jpg');
mugshot = read_photos('1g.jpg');
% limit = 500;
limit = 100;
tic;
[region_num, region_means] = my_kmean_exp( mugshot, k,limit);
toc;

figure('Name', 'mugshot - k=3');
for ii = 1:k
    subplot(1,k,ii);
    imshow(region_num(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Mugshot Images (Own Function k=4)
k=4;
% mugshot = read_photos('7grey.jpg');
mugshot = read_photos('1g.jpg');
% limit = 500;
limit = 100;
tic;
[region_num, region_means] = my_kmean_exp( mugshot, k,limit);
toc;

figure('Name', 'mugshot - k=4');
for ii = 1:k
    subplot(1,k,ii);
    imshow(region_num(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Brain Images w/ built-in
k=3;

brain1 = read_photos('images/CN_4_BL.jpeg');
brain2 = read_photos('images/AD_7_M24.jpeg');

size_of_brainimg = size(brain1);
number_elements_brain = numel(brain1);

brain1_vector = reshape(brain1,[number_elements_brain, 1]);
[idx,C] = kmeans(brain1_vector,k);
brain1_kmean = reshape(idx,size_of_brainimg);

for ii = 1:k
    brain1_mean(:,:,ii) = (brain1_kmean == ii);
end

figure('Name', 'Inbuilt Brain1');
for ii = 1:k
    subplot(1,k,ii);
    imshow(brain1_mean(:,:,ii));
    title(['K = ' num2str(ii)]);
end
brain2_vector = reshape(brain2,[number_elements_brain, 1]);
[idx,C] = kmeans(brain2_vector,k);
brain2_kmean = reshape(idx,size_of_brainimg);

for ii = 1:k
    brain2_mean(:,:,ii) = (brain2_kmean == ii);
end

figure('Name', 'Inbuilt Brain2');
for ii = 1:k
    subplot(1,k,ii);
    imshow(brain2_mean(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Brain Images (Own Function)

brain1 = read_photos('images/CN_4_BL.jpeg');
brain2 = read_photos('images/AD_7_M24.jpeg');
%brain1
k=3;
% limit = 500;
limit = 20;
tic;
[region_num, region_means] = my_kmean_exp( brain1, k,limit);
toc;

figure('Name', 'Own Brain1');
for ii = 1:k
    subplot(1,k,ii);
    imshow(region_num(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%brain2

[region_num, region_means] = my_kmean_exp( brain2, k,limit);

figure('Name', 'Own Brain2');
for ii = 1:k
    subplot(1,k,ii);
    imshow(region_num(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%% Experimental (Efficiency improvements to previous algorithm)
% commented out as new algorithm is much better speed wise.

% brain1 = read_photos('images/CN_4_BL.jpeg');
% brain2 = read_photos('images/AD_7_M24.jpeg');
% %brain1
% k=3;
% % limit = 500;
% limit = 100;
% tic;
% [region_num, region_means] = my_kmean_exp_exp( brain1, k,limit);
% toc;
% 
% figure('Name', 'Own Brain1');
% for ii = 1:k
%     subplot(1,k,ii);
%     imshow(region_num(:,:,ii));
%     title(['K = ' num2str(ii)]);
% end
