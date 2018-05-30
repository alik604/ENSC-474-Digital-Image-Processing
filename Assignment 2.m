%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 2
% Date       : Jan 20, 2016
% MATLAB Ver : R2014a

% Details    : Run via 'main' function
%              
%              

%% Main
function main
greyscaleimg = read_photos('GrayscalePicture2.jpg')
sizeOfImage = size(greyscaleimg);
[xArray, yArray] = meshgrid(1:sizeOfImage(2),1:sizeOfImage(1));
%value = repmat(xArray,1);
%value = returnValueAt(xArray,yArray,greyscaleimg);

value = rescale_image(1,10,xArray,yArray,greyscaleimg); %scale y by 10;
imwrite(im2uint8(value),'YScaledby10.jpg');
figure('Name', 'YScaledby10.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = rescale_image(2,3,xArray,yArray,greyscaleimg); %scale y by 3, x by 2;
imwrite(im2uint8(value),'YScaledby3Xby2.jpg');
figure('Name', 'YScaledby3Xby2.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = rescale_image(0.3,0.5,xArray,yArray,greyscaleimg); %scale y by .5, x by .3;
imwrite(im2uint8(value),'YScaledbypt5Xbypt3.jpg');
figure('Name', 'YScaledbypt5Xbypt3.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = rescale_image(0.5,0.1,xArray,yArray,greyscaleimg); %scale y by .1, x by .5;
imwrite(im2uint8(value),'YScaledbypt1Xbypt5.jpg');
figure('Name', 'YScaledbypt1Xbypt5.jpg'); %shows image in a new window
imshow(im2uint8(value));

end

%% Functions
function value = returnValueAt(xValue,yValue,img);
% returns the value at a coordinate in the image, interpolates if needed
[xyWeight, x1yWeight, xy1Weight, x1y1Weight] = findWeights2D(xValue,yValue); %get the weights for interpolation
[sample_xy, sample_x1y, sample_xy1, sample_x1y1] = getSampleValues(xValue,yValue,img); %gets the values from the points around the interpolation point
value = xyWeight.*sample_xy + x1yWeight.*sample_x1y + xy1Weight.*sample_xy1 + x1y1Weight.*sample_x1y1; %calculate interpolated value
end

function [floorWeight, ceilingWeight] = findWeights1D(value);
%finds the weightage on one axis
floorWeight = floor(value);
ceilingWeight = floorWeight+1;
floorWeight = value - floorWeight;
ceilingWeight = ceilingWeight - value ;
end

function [xyWeight, x1yWeight, xy1Weight, x1y1Weight] = findWeights2D(xValue, yValue);
%finds the weight on two axises
[xLowWeight, xHighWeight] = findWeights1D(xValue);
[yLowWeight, yHighWeight] = findWeights1D(yValue);

%calculates the weight of an area (for 2D)
xyWeight = yHighWeight.*xHighWeight;
xy1Weight = yLowWeight.*xHighWeight;
x1yWeight = xLowWeight.*yHighWeight;
x1y1Weight = xLowWeight.*yLowWeight;
end 

function [xy, x1y, xy1, x1y1] = getSampleValues(xValue,yValue,img);
%obtains sample values from original image for interpolation calculations
lowX = floor(xValue);
highX = lowX+1;
lowY = floor(yValue);
highY = lowY+1;

%since we dont want to exeeed the matrix size, set the ceiling of both axis
%to be max image size
highX(:,end) = lowX(:,end);
highY(end,:) = lowY(end,:);

%index image to get values.
xy = img(sub2ind(size(img),lowY,lowX));
x1y = img(sub2ind(size(img),lowY,highX));
xy1 = img(sub2ind(size(img),highY,lowX));
x1y1 = img(sub2ind(size(img),highY,highX));
end

function photos = read_photos(file_name);
%reads photo from file.
photo = imread(file_name);
%figure('Name', file_name); %shows image in a new window
%imshow(photo);
photos = mat2gray(double(photo))%maps intensity between 0 - 1
end

function value = rescale_image(xFactor,yFactor,xArray,yArray,img);
%scales the coordinates matrix to desired sample point values, calls returnValueAt() for interpolation.

%gets the new number of samples in both axis
newX = ceil(size(xArray)*xFactor);
newY = ceil(size(yArray)*yFactor);

%expands coordinate arrays to new number of samples and proper coordinates
newXArray = linspace(xArray(1),xArray(end),newX(2)); %linearly space vector
newXArray = repmat(newXArray, newY(1),1); %copies vector into a matrix
newYArray = linspace(yArray(1),yArray(end),newY(1));
newYArray = repmat(newYArray, newX(2),1);
newYArray = newYArray';

%gets values for new scaled img. 
value = repmat(newXArray,1);
value = returnValueAt(newXArray,newYArray,img);
end

