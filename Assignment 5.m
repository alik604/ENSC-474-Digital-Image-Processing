%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 5
% Date       : Feb 24, 2017
% MATLAB Ver : R2014a

% Details    : Run via 'main' function
%           1) Implement an algorithm that uses a specified mask to find 
%              edges in your mugshot image - display the edges.
% 
%           2) Enhance your mugshot image with an appropriate filter based 
%              on using edges in some way. 
%              Display the before and after images. Discuss the design of 
%              your filter you have chosen, and the effect of parameter choices, 
%              if any, on the results.   

% Credits : A&W for sustinence in this time period of my life.

%% Main Function
function main
close all;
clear all;
photo = read_photos('3g.jpg');
% mask = [1,1,1;1,1,1;1,1,1]; %smoothing mask, tried this for fun.
enhancement_scale = 5;
%% Define masks
mask = [0, 0,   1, 0, 0;...
        0, 1,   2, 1, 0;...
        1, 2, -16, 2, 1;...
        0, 1,   2, 1, 0;...
        0, 0,   1, 0, 0];

    
mask2 = [0, 0,   0, 0, 0;...
         0, 0,   1, 0, 0;...
         0, 1,  -4, 1, 0;...
         0, 0,   1, 0, 0;...
         0, 0,   0, 0, 0];    
%%      
masked_photo = mask_image(mask,photo);
write_photos(masked_photo, '3g5LogMaskEdges.jpg', '3g5LogMaskEdges.jpg');
%% If no write function use these to display image
% photos_scaled = mat2gray(masked_photo);%maps intensity between 0 - 1. -tives mapped as black +tive as white. 0 are grey.
% photos = im2uint8(photos_scaled); %cast to be able to write to .jpg
% figure('Name', 'Edges of the Image'); %shows image in a new window
% imshow(photos);
%% Do the enhancement, then scale back to something that looks like the picture.

improved_photo = photo.*enhancement_scale - masked_photo;
write_photos(improved_photo,'3g5LogMaskEdgeNoEndScale.jpg', '3g5LogMaskEdgeNoEndScale.jpg');
improved_photo = improved_photo.^0.4; %scale image back to something that looks alright.
improved_photo = real(improved_photo);
write_photos(improved_photo,'3g5LogMaskEdgeEndScalept4.jpg','3g5LogMaskEdgeEndScalept4.jpg');

%% I tried out different kinds of scalings just to see what it looked like.
% improved_photo = sin(improved_photo); %I become a demon using this

% improved_photo = log10(improved_photo+0.01); %Doesn't look better than
% the one above.
% improved_photo = real(improved_photo);

%% If no write function need to use these.
% photos = mat2gray(improved_photo);%maps intensity between 0 - 1. -tives mapped as black +tive as white. 0 are grey.
% photos = im2uint8(photos); %cast to be able to write to .jpg
% % photos = im2uint8(improved_photo); %cast to be able to write to .jpg
% figure('Name', 'Enhanced Photo'); %shows image in a new window
% imshow(photos);
%% repeat for 3-wide log mask
masked_photo = mask_image(mask2,photo);
write_photos(masked_photo, '3g3LogMaskEdges.jpg', '3g3LogMaskEdges.jpg');

% Do the enhancement, then scale back to something that looks like the picture.

improved_photo = photo.*enhancement_scale - masked_photo;
write_photos(improved_photo,'3g3LogMaskEdgeNoEndScale.jpg', '3g3LogMaskEdgeNoEndScale.jpg');
improved_photo = improved_photo.^0.4; %scale image back to something that looks alright.
improved_photo = real(improved_photo);
write_photos(improved_photo,'3g3LogMaskEdgeEndScalept4.jpg','3g3LogMaskEdgeEndScalept4.jpg');

%% Repeat for 1g.jpg
photo = read_photos('1g.jpg');
enhancement_scale = 5;

masked_photo = mask_image(mask,photo);
write_photos(masked_photo, '1g5LogMaskEdges.jpg', '1g5LogMaskEdges.jpg');
% Do the enhancement, then scale back to something that looks like the picture.

improved_photo = photo.*enhancement_scale - masked_photo;
write_photos(improved_photo,'1g5LogMaskEdgeNoEndScale.jpg', '1g5LogMaskEdgeNoEndScale.jpg');
improved_photo = improved_photo.^0.4; %scale image back to something that looks alright.
improved_photo = real(improved_photo);
write_photos(improved_photo,'1g5LogMaskEdgeEndScalept4.jpg','1g5LogMaskEdgeEndScalept4.jpg');

% repeat for 3-wide log mask
masked_photo = mask_image(mask2,photo);
write_photos(masked_photo, '1g3LogMaskEdges.jpg', '1g3LogMaskEdges.jpg');

% Do the enhancement, then scale back to something that looks like the picture.
improved_photo = photo.*enhancement_scale - masked_photo;
write_photos(improved_photo,'1g3LogMaskEdgeNoEndScale.jpg', '1g3LogMaskEdgeNoEndScale.jpg');
improved_photo = improved_photo.^0.4; %scale image back to something that looks alright.
improved_photo = real(improved_photo);
write_photos(improved_photo,'1g3LogMaskEdgeEndScalept4.jpg','1g3LogMaskEdgeEndScalept4.jpg');

%%Change values of the scale so it looks alright. doing 0.2 and 0.6 for 5
%%wide mask.
masked_photo = mask_image(mask,photo);
% Do the enhancement, then scale back to something that looks like the picture.

improved_photo = photo.*enhancement_scale - masked_photo;
improved_photo2 = improved_photo.^0.2; %scale image back to something that looks alright.
improved_photo2 = real(improved_photo2);
improved_photo6 = improved_photo.^0.6; %scale image back to something that looks alright.
improved_photo6 = real(improved_photo6);
write_photos(improved_photo2,'1g5LogMaskEdgeEndScalept2.jpg','1g5LogMaskEdgeEndScalept2.jpg');
write_photos(improved_photo6,'1g5LogMaskEdgeEndScalept6.jpg','1g5LogMaskEdgeEndScalept6.jpg');

%% What about the enchancement scale? using 2 and 7 (change from 5)
masked_photo = mask_image(mask,photo);

enhancement_scale = 2;
improved_photo = photo.*enhancement_scale - masked_photo;
write_photos(improved_photo,'1g-Enhance2-5LogMaskEdgeNoEndScale.jpg', '1g-Enhance2-5LogMaskEdgeNoEndScale.jpg');
improved_photo = improved_photo.^0.4; %scale image back to something that looks alright.
improved_photo = real(improved_photo);
write_photos(improved_photo,'1g-Enhance2-5LogMaskEdgeEndScalept4.jpg','1g-Enhance2-5LogMaskEdgeEndScalept4.jpg');

enhancement_scale = 7;
improved_photo = photo.*enhancement_scale - masked_photo;
write_photos(improved_photo,'1g-Enhance7-5LogMaskEdgeNoEndScale.jpg', '1g-Enhance7-5LogMaskEdgeNoEndScale.jpg');
improved_photo = improved_photo.^0.4; %scale image back to something that looks alright.
improved_photo = real(improved_photo);
write_photos(improved_photo,'1g-Enhance7-5LogMaskEdgeEndScalept4.jpg','1g-Enhance7-5LogMaskEdgeEndScalept4.jpg');
end
