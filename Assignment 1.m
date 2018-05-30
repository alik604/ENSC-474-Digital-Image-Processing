%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 1
% Date       : Jan 13, 2016
% MATLAB Ver : R2014a

% Details    : Run via 'main' function
%              Will open two images 'picture1small.jpg' & 'picture2small.jpg'
%              and will generate a difference image based on intensity ('diffPicture.jpg').

%%
function main
%% reading images
% picture1 = read_photos('picture1small.jpg');
% picture2 = read_photos('picture2small.jpg');
picture1 = read_photos('grid.jpg');
picture2 = read_photos('grid.jpg');
%% computation

diff_pic = picture1 - picture2; %creates difference picture

%% Writing and showing images
% write_photos(picture1, 'GrayscalePicture1.jpg','GrayscalePicture1.jpg');
% write_photos(picture2, 'GrayscalePicture2.jpg','GrayscalePicture2.jpg');
write_photos(picture1, 'gridgrey.jpg','GrayscalePicture1.jpg');
write_photos(picture2, 'gridgrey.jpg','GrayscalePicture2.jpg');
% write_photos(diff_pic, 'diffPicture.jpg','diffPicture.jpg');
end

%% Functions
function photos = read_photos(file_name)
% creates
photo = imread(file_name);
figure('Name', file_name); %shows image in a new window
imshow(photo);
photo_var = double(photo);
photo_var = mat2gray(photo_var); %maps intensity between 0 - 1
photos = mean(photo_var,3); %averages RGB colour channels
end

function write_photos(var_name,save_name,fig_name)
photos = mat2gray(var_name);%maps intensity between 0 - 1. -tives mapped as black +tive as white. 0 are grey.
photos = im2uint8(photos); %cast to be able to write to .jpg
imwrite(photos,save_name);
figure('Name', fig_name); %shows image in a new window
imshow(photos);
%imshow(var_name,[min(var_name(:)) max(var_name(:))]);

end