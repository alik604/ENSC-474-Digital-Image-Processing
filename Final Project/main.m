%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Final Project
% Date       : March 31 2017
% MATLAB Ver : R2016b

% Details    : Run via 'main' function
%              Automatic identification of photoreceptors in greyscale OCT
%              images for a given mask size.
%              Requires NVIDA CUDA GPU  if using gpuArray.
% Credits : 

%% Read in the image

%enable Parpool
p = gcp('nocreate'); % If no pool, do not create new one.
if isempty(p)
    parpool;
end

%%Actual Images
oct_img_1 = read_photos('Original Img/15_42_53-m3MM-MID_6_PR_avgOctVol_dB.tif');
oct_img_2 = read_photos('Original Img/18_45_10-_47_PR_avgOctVol_dB.tif');

%%Image for testing purposes
oct_img_test = read_photos('Other Img/15_42_53-m3MM-MID_6_PR_avgOctVol_dB_sectiongrey.jpg');

img = oct_img_2;

%% Algorithm 1 - K-means based segmentation
k = 3;
rng default;
size_of_img = size(img);
vector_img = reshape(img,[numel(img), 1]);
img_index = kmeans(vector_img, k);
img_kmean = reshape(img_index,size_of_img);

division = 1/(k-1);
div = 0;
img_kmeaned = ones(size_of_img);

div_values = 0:division:1;


for ii = 1:k
    img_mean_index(:,:,ii) = (img_kmean == ii);
    img_kmeaned(img_mean_index(:,:,ii)) = div_values(ii);
end

% figure('Name', 'Inbuilt Crop');
% for ii = 1:k
%     subplot(1,k,ii); 
%     imshow(img_meaned(:,:,ii));
%     title(['K = ' num2str(ii)]);
% end

figure('Name', 'K-mean seperation');
subplot(1,2,1);
imshow(img_kmeaned);
title(['K-mean Seperated Image, K =' num2str(k)]);
subplot(1,2,2);
imshow(img);
title('Original Image');

%% Algorithm 2 - Contrast then <s>K-means</s> threshold.
threshold_value = 0.6;
edgeThreshold = 1;
amount = 1;

%toggle for images 

file_name = 'Original Img/18_45_10-_47_PR_avgOctVol_dB.tif';
% file_name = 'Original Img/15_42_53-m3MM-MID_6_PR_avgOctVol_dB.tif';

img = imread(file_name);

B = localcontrast(img, edgeThreshold, amount);
figure();
subplot(1,3,1);
imshow(img);
title('Original');
subplot(1,3,2);
imshow(B);
title('Contrasted img');

%Did not look good at all Kmeans after the contrast.
% k = 2;
% size_of_img = size(B);
% vector_img = reshape(B,[numel(B), 1]);
% img_index = kmeans(vector_img, k);
% img_kmean = reshape(img_index,size_of_img);
% 
% division = 1/(k-1);
% div = 0;
% img_kmeaned = ones(size_of_img);
% 
% div_values = 0:division:1;
% 
% 
% for ii = 1:k
%     img_mean_index(:,:,ii) = (img_kmean == ii);
%     img_kmeaned(img_mean_index(:,:,ii)) = div_values(ii);
% end
% 
% % figure('Name', 'Inbuilt Crop');
% % for ii = 1:k
% %     subplot(1,k,ii); 
% %     imshow(img_meaned(:,:,ii));
% %     title(['K = ' num2str(ii)]);
% % end
% 
% figure('Name', 'K-mean seperation');
% subplot(1,2,1);
% imshow(img_kmeaned);
% title(['K-mean Seperated Image, K =' num2str(k)]);
% subplot(1,2,2);
% imshow(img);
% title('Original Image');

B = mat2gray(B);
B_thresh =  B;
B_thresh(B < threshold_value) = 0;
subplot(1,3,3);
imshow(B_thresh);
title('Thresholded');

B_thresh_logical = logical(ceil(B_thresh));

%% Using Algorithm 2 from now on.

%% Now to actually count it... For Contrast
% Counts the number of segments in the image.

% BW = gpuArray(B_thresh_logical); %so that it uses the GPU to calculate it. Should be faster.
BW = B_thresh_logical; %no NVDIA GPU.
L = bwlabel(BW,4); %uses 4 link connectivity
colouredLabels = label2rgb(gather(L), 'hsv', 'k', 'shuffle'); % pseudo random color labels
figure();
imshow(colouredLabels);
title('Colour-coded segments');
number_of_segments = gather(max(max(L))) %Number of pixels then.

%% Different style of counting, outputs an array with the area of cells around a mxn area around it.
% areas with low counts get a red outline to it. 
mask = ones(15);
area_count = mask_count(mask,B_thresh);
% histogram(area_count);

%sets the bad area (low cell count) as mean-stddev.
area_count_vector = reshape(area_count,[numel(area_count), 1]);
median_value = median(area_count_vector);
std_dev = std(area_count_vector);
mean_value = mean(area_count_vector);

figure();
histogram(area_count_vector);
title('Distribution of density of cells');

%logical array for the bad area
bad_area = zeros(size(img));
bad_area(area_count < (mean_value - std_dev)) = 0.5;

figure();
imshow(img, 'InitialMag', 'fit') 
% Make a truecolor all-red image. 
red = cat(3, ones(size(img)),zeros(size(img)),zeros(size(img))); 
hold on 
h = imshow(red); 
title('Areas with low total cell area');
hold off 

figure();
imagesc(area_count);
title('counts of area');

% Use our influence map as the 
% AlphaData for the solid red image. 
set(h, 'AlphaData', bad_area); 

%% Counting with mask, segments rather than cell area.
segment_counts = mask_seg_count(mask,L);

segment_count_vector = reshape(segment_counts,[numel(segment_counts), 1]);
median_value_seg = median(segment_count_vector);
std_dev_seg = std(segment_count_vector);
mean_value_seg = mean(segment_count_vector);

figure();
contourf(segment_counts);
title('Level Plot of Cell Body Density');
figure();
histogram(segment_count_vector);
title('Histogram of Segment Counts');



string = ['Cell Body Count'];
show_low_area(img,segment_counts,mean_value_seg,std_dev_seg,string);



%% to destroy some photoreceptors in a small region.

small_region = img([100:200],[100:200]);
small_B = localcontrast(small_region, edgeThreshold, amount);
figure();
subplot(1,3,1);
imshow(small_region);
title('Original small region');
subplot(1,3,2);
imshow(small_B);
title('Contrasted small region');

small_B = mat2gray(small_B);
small_B_thresh =  small_B;
small_B_thresh(small_B < threshold_value) = 0;
subplot(1,3,3);
imshow(small_B_thresh);
title('Thresholded small region');

small_B_thresh_logical = logical(ceil(small_B_thresh));

% small_BW = gpuArray(small_B_thresh_logical); %so that it uses the GPU to calculate it. Should be faster.
small_BW = small_B_thresh_logical; %no GPU
small_L = bwlabel(small_BW,4); %uses 4 link connectivity
small_colouredLabels = label2rgb(gather(small_L), 'hsv', 'k', 'shuffle'); % pseudo random color labels
figure();
subplot(1,2,1);
imshow(small_colouredLabels);
title('Original');
number_of_segments = gather(max(max(small_L))) %Number of cells then.


%removal of some photoreceptors

to_remove = (rem(gather(small_L),2) == 0 & gather(small_L) ~= 0);

small_removed_L = small_L;
small_removed_L(to_remove) = 0;

small_removed_colouredLabels = label2rgb(gather(small_removed_L), 'hsv', 'k', 'shuffle'); % pseudo random color labels
subplot(1,2,2);
imshow(small_removed_colouredLabels);
title('Simulated Diseased');
number_of_segments = gather(max(max(small_removed_L))) %Number of cells then.

%placing the image back into original.
put_back = (sum(small_removed_colouredLabels,3) ~= 0);
not_put_back = ~(put_back);
small_region(not_put_back) = 0;
disease_img = img;
disease_img(100:200,100:200) = small_region;

figure();
imshow(disease_img);
title('Simulated Diseased Img');

%% Now run the simulated Diseased Img through the algorithm.

% Algorithm 2 - Contrast then <s>K-means</s> threshold.
threshold_value = 0.6;
edgeThreshold = 1;
amount = 1;



B = localcontrast(disease_img, edgeThreshold, amount);
figure();
subplot(1,3,1);
imshow(disease_img);
title('Original');
subplot(1,3,2);
imshow(B);
title('Contrasted img');

B = mat2gray(B);
B_thresh =  B;
B_thresh(B < threshold_value) = 0;
subplot(1,3,3);
imshow(B_thresh);
title('Thresholded');

B_thresh_logical = logical(ceil(B_thresh));

% Now to actually count it... For Contrast
% Counts the number of segments in the image.

% BW = gpuArray(B_thresh_logical); %so that it uses the GPU to calculate it. Should be faster.
BW = B_thresh_logical; %if not NVDIA GPU.
L = bwlabel(BW,4); %uses 4 link connectivity
colouredLabels = label2rgb(gather(L), 'hsv', 'k', 'shuffle'); % pseudo random color labels
figure();
imshow(colouredLabels);
title('Colour-coded segments');
number_of_segments = gather(max(max(L))) %Number of cells then.

% Different style of counting, outputs an array with the area of cells around a mxn area around it.
% areas with low counts get a red outline to it. 
mask = ones(15);
area_count = mask_count(mask,B_thresh);
% histogram(area_count);

%sets the bad area (low cell count) as mean-stddev.
area_count_vector = reshape(area_count,[numel(area_count), 1]);
median_value = median(area_count_vector);
std_dev = std(area_count_vector);
mean_value = mean(area_count_vector);

%logical array for the bad area
bad_area = zeros(size(disease_img));
bad_area(area_count < (mean_value - std_dev)) = 0.5;

figure();
imshow(disease_img, 'InitialMag', 'fit') 
% Make a truecolor all-red image. 
red = cat(3, ones(size(disease_img)),zeros(size(disease_img)),zeros(size(disease_img))); 
hold on 
h = imshow(red); 
title('Areas with low total cell area');
hold off 

% Use our influence map as the 
% AlphaData for the solid red image. 
set(h, 'AlphaData', bad_area); 

% Counting with mask, segments rather than cell area.
segment_counts = mask_seg_count(mask,L);

%calculate stats
segment_count_vector = reshape(segment_counts,[numel(segment_counts), 1]);
median_value_seg = median(segment_count_vector);
std_dev_seg = std(segment_count_vector);
mean_value_seg = mean(segment_count_vector);

figure();
contourf(segment_counts);
title('Level Plot of Cell Body Density');
figure();
histogram(segment_count_vector);
title('Histogram of Segements Count');

string = ['Cell Body Count'];
show_low_area(disease_img,segment_counts,mean_value_seg,std_dev_seg,string);
