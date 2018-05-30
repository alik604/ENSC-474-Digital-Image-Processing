%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 9
% Date       : March 24, 2017
% MATLAB Ver : R2016b

% Details    : Run via 'main' function
%              Non-rigid assignment.
% Credits : 
%%
close all;
clear all;

%we are going from smile -> frown

img_frown = read_photos('4grey.jpg');
img_smile = read_photos('7grey.jpg');

% cpselect(img_smile, img_frown);

SmilePoints = csvread('SmilePoints.csv'); %way too many points.
FrownPoints = csvread('FrownPoints.csv');
% 
% SmilePoints = csvread('SmilePointsless.csv'); %less points.
% FrownPoints = csvread('FrownPointsless.csv');

% SmilePoints = csvread('SmilePoints5.csv'); % 5 points.
% FrownPoints = csvread('FrownPoints5.csv');

figure('Name', 'Control Points')
subplot(1,2,1); title('Smile Image');hold on;
imshow(img_smile);
plot(SmilePoints(:,1),SmilePoints(:,2),'oy'); 
subplot(1,2,2); title('Frown Image');
hold on;
imshow(img_frown);
plot(FrownPoints(:,1),FrownPoints(:,2),'oy'); 
hold off;

sizeOfImage =  size(img_frown);
[xArray, yArray] = meshgrid(1:sizeOfImage(2),1:sizeOfImage(1));
    
%%
num_landmarks = size(FrownPoints);
total_x =  zeros(sizeOfImage(1),sizeOfImage(2));
total_y =  zeros(sizeOfImage(1),sizeOfImage(2));

for ii = 1:num_landmarks(1) %implement the formula for non-rigid
   distance  = (xArray - SmilePoints(ii,1)).^2+  (yArray - SmilePoints(ii,2)).^2;
   sigma_y = 30;
   sigma_x = 50;
   landmark_diff =  FrownPoints(ii,:) - SmilePoints(ii,:); 
   weight_y  = exp(-(distance)/(2*(sigma_y^2)));
   weight_x  = exp(-(distance)/(2.*(sigma_x.^2)));
   value_for_landmark_y = weight_y * landmark_diff(2);
   value_for_landmark_x = weight_x * landmark_diff(1);
   
   total_x = total_x + value_for_landmark_x; %summing up
   total_y = total_y + value_for_landmark_y;
   
end

%Apply the vector field.
shiftedImg_X = xArray + total_x;
shiftedImg_Y = yArray + total_y;

[outOfArrayX, oriX] = findOutOfRange(shiftedImg_X,1,sizeOfImage(2)); %find points of the image that are now out of range
[outOfArrayY, oriY] = findOutOfRange(shiftedImg_Y,1,sizeOfImage(1));

newImg = returnValueAt(oriX,oriY,img_smile);
%fill in out of range values with 0s    
newImg(outOfArrayX) = 0;
newImg(outOfArrayY) = 0;

figure();
subplot (1,2,1);
quiver(xArray,yArray,total_x,total_y);
subplot (1,2,2);
imshow(newImg);

%Apply the vector field for the inverse
shiftedImg_X = xArray - total_x;
shiftedImg_Y = yArray - total_y;

[outOfArrayX, oriX] = findOutOfRange(shiftedImg_X,1,sizeOfImage(2)); %find points of the image that are now out of range
[outOfArrayY, oriY] = findOutOfRange(shiftedImg_Y,1,sizeOfImage(1));

newImg = returnValueAt(oriX,oriY,img_smile);
%fill in out of range values with 0s    
newImg(outOfArrayX) = 0;
newImg(outOfArrayY) = 0;

figure();
subplot (1,2,1);
quiver(xArray,yArray,total_x,total_y);
subplot (1,2,2);
imshow(newImg);

%% Creating the Animated GIF
gifImg = zeros(sizeOfImage(1),sizeOfImage(2),80);
counter = 1;
%generate the transform frames
for scale = 0:0.05:1
    shiftedImg_X_gif = xArray + scale.*total_x;
    shiftedImg_Y_gif = yArray + scale.*total_y;
    [outOfArrayX, oriX] = findOutOfRange(shiftedImg_X_gif,1,sizeOfImage(2)); %find points of the image that are now out of range
    [outOfArrayY, oriY] = findOutOfRange(shiftedImg_Y_gif,1,sizeOfImage(1));

    newImg = returnValueAt(oriX,oriY,img_smile);
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
    
    gifImg(:,:,counter) = newImg;
    counter = counter+1;
end
% generate the frames to go back to the original from the first
for scale = 0:0.05:1
    shiftedImg_X_gif = xArray + (1-scale).*total_x;
    shiftedImg_Y_gif = yArray + (1-scale).*total_y;
    [outOfArrayX, oriX] = findOutOfRange(shiftedImg_X_gif,1,sizeOfImage(2)); %find points of the image that are now out of range
    [outOfArrayY, oriY] = findOutOfRange(shiftedImg_Y_gif,1,sizeOfImage(1));

    newImg = returnValueAt(oriX,oriY,img_smile);
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
    
    gifImg(:,:,counter) = newImg;
    counter = counter+1;
end
%generate the inverse transform frames
for scale = 0:0.05:1
    shiftedImg_X_gif = xArray - scale.*total_x;
    shiftedImg_Y_gif = yArray - scale.*total_y;
    [outOfArrayX, oriX] = findOutOfRange(shiftedImg_X_gif,1,sizeOfImage(2)); %find points of the image that are now out of range
    [outOfArrayY, oriY] = findOutOfRange(shiftedImg_Y_gif,1,sizeOfImage(1));

    newImg = returnValueAt(oriX,oriY,img_smile);
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
    
    gifImg(:,:,counter) = newImg;
    counter = counter+1;
end
%generate the frames to go from inverse back to original
for scale = 0:0.05:1
    shiftedImg_X_gif = xArray - (1-scale).*total_x;
    shiftedImg_Y_gif = yArray - (1-scale).*total_y;
    [outOfArrayX, oriX] = findOutOfRange(shiftedImg_X_gif,1,sizeOfImage(2)); %find points of the image that are now out of range
    [outOfArrayY, oriY] = findOutOfRange(shiftedImg_Y_gif,1,sizeOfImage(1));

    newImg = returnValueAt(oriX,oriY,img_smile);
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
    
    gifImg(:,:,counter) = newImg;
    counter = counter+1;
end

%% Writing the Animated GIF
%this writes the individual frames
% figure();
% sizegif = size(gifImg);
% for idx = 1:sizegif(3)
%     subplot(5,4,idx)
%     imshow(gifImg(:,:,idx));
% end

filename = 'animation.gif'; % Specify the output file name
sizegif = size(gifImg);
for idx = 1:sizegif(3)
    grayImage = im2uint8(gifImg(:,:,idx));
    rgbImage = cat(3, grayImage, grayImage, grayImage);
    [A,map] = rgb2ind(rgbImage,256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','LoopCount',Inf,'WriteMode','append','DelayTime',0.05);
    end
end

