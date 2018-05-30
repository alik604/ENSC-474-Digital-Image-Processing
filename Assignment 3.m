%% Code Details
% Author     : Isaac Tan (301247997)
% Course     : ENSC 474, Assignment 3
% Date       : Jan 27, 2016
% MATLAB Ver : R2014a

% Details    : Run via 'main' function
%              Transformation Assignment
%              
%
% Credits : Paul B. for assistance with image truncation. 
%           Winsey C. for help here and there with syntax.

%% Main
function main
clear all;
close all;
greyscaleimg = read_photos('GrayscalePicture2.jpg');
% greyscaleimg = read_photos('gridgrey.jpg');
figure('Name', 'original image'); %shows image in a new window
imshow(im2uint8(greyscaleimg));

sizeOfImage = size(greyscaleimg);
[xArray, yArray] = meshgrid(1:sizeOfImage(2),1:sizeOfImage(1));
%initialises image for processing

%value = repmat(xArray,1);
%value = returnValueAt(xArray,yArray,greyscaleimg);


%%
value = rotate_image(xArray,yArray,30,greyscaleimg); 
imwrite(im2uint8(value),'rotate30.jpg');
figure('Name', 'rotate30.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = translate_image(xArray,yArray,50,50,greyscaleimg); 
% imwrite(im2uint8(value),'translate50.jpg');
figure('Name', 'translate50.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = pure_scale_image(xArray,yArray,greyscaleimg,1.5); 
% imwrite(im2uint8(value),'scale1pt5.jpg');
figure('Name', 'scale1pt5.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = shear_imageX(xArray,yArray,-0.2,-0.1,greyscaleimg,1,0); 
% imwrite(im2uint8(value),'shearx-0pt2.jpg');
figure('Name', 'shearx-0pt2.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = shear_imageX(xArray,yArray,-0.1,-0.2,greyscaleimg,0,1); 
% imwrite(im2uint8(value),'sheary-0pt2.jpg');
figure('Name', 'sheary-0pt2.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = shear_imageX(xArray,yArray,-0.1,-0.1,greyscaleimg,1,1); 
% imwrite(im2uint8(value),'shearx-0pt1y-0pt1.jpg');
figure('Name', 'shearx-0pt1y-0pt1.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = compress_rt(xArray,yArray,greyscaleimg); 
% imwrite(im2uint8(value),'compresssqrt.jpg');
figure('Name', 'compresssqrt.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = reflection(xArray,yArray,greyscaleimg); 
% imwrite(im2uint8(value),'reflection.jpg');
figure('Name', 'reflection.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = twoXoverY(xArray,yArray,greyscaleimg); 
% imwrite(im2uint8(value),'twoXoverY.jpg');
figure('Name', 'twoXoverY.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = xplusYoverXminusY(xArray,yArray,greyscaleimg);
% imwrite(im2uint8(value),'XplusYoverXminusY.jpg');
figure('Name', 'XplusYoverXminusY.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = rotationWithTranslation(xArray,yArray,50,50,30,greyscaleimg); 
% imwrite(im2uint8(value),'rotationwithtranslation50-50-30.jpg');
figure('Name', 'rotationwithtranslation50-50-30.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = rotationWithTranslation(xArray,yArray,60,-10,15,greyscaleimg); 
% imwrite(im2uint8(value),'rotationwithtranslation60--10-15.jpg');
figure('Name', 'rotationwithtranslation60--10-15.jpg'); %shows image in a new window
imshow(im2uint8(value));

value = rotationWithTranslation(xArray,yArray,-50,20,-25,greyscaleimg); 
% imwrite(im2uint8(value),'rotationwithtranslation-50-20--25.jpg');
figure('Name', 'rotationwithtranslation-50-20--25.jpg'); %shows image in a new window
imshow(im2uint8(value));
end

%% Functions

function newImg = rotationWithTranslation(X,Y,offsetX,offsetY,theta,img)
    ct = cos(theta*pi/180); st = sin(theta*pi/180);
    rotX = X;
    rotY = Y;
    oriX = rotX.*ct + rotY.* st; %inverse rotation matrix to map rotated image to original 
    oriY = -rotX.*st + rotY.*ct;

    newX = oriX - offsetX; %inverse for the offsets
    newY = oriY - offsetY;
    
    
    sizeOfImage = size(img); %get size of the image
    sizeOriX = sizeOfImage(2);
    sizeOriY = sizeOfImage(1);
    
    [outOfArrayX, oriX] = findOutOfRange(newX,1,sizeOriX); %find points of the image that are now out of range
    [outOfArrayY, oriY] = findOutOfRange(newY,1,sizeOriY);
    
    %get values at those points
    newImg = returnValueAt(oriX,oriY,img);
%   newImg = returnValueAt(newMeshX,newMeshY,img);
    
    
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
end


function newImg = xplusYoverXminusY(X,Y,img)
newX = (X+Y)./(abs(X-Y)+1); %formula for transformation
newY = (X+Y)./(abs(Y-X)+1);

sizeOfImage = size(img); %get size of the image
    sizeOriX = sizeOfImage(2);
    sizeOriY = sizeOfImage(1);
    
    [outOfArrayX, oriX] = findOutOfRange(newX,1,sizeOriX); %find points of the image that are now out of range
    [outOfArrayY, oriY] = findOutOfRange(newY,1,sizeOriY);
    
    %get values at those points
    newImg = returnValueAt(oriX,oriY,img);
%   newImg = returnValueAt(newMeshX,newMeshY,img);
    
    
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
    
    
end
function newImg = reflection(X,Y,img)
%reflection on both axis, example of an affine transformation.
sizeImage = size(img);
newY = flipud(Y);
newX = fliplr(X);

sizeOfImage = size(img); %get size of the image
    sizeOriX = sizeOfImage(2);
    sizeOriY = sizeOfImage(1);
    
    [outOfArrayX, oriX] = findOutOfRange(newX,1,sizeOriX); %find points of the image that are now out of range
    [outOfArrayY, oriY] = findOutOfRange(newY,1,sizeOriY);
    
    %get values at those points
    newImg = returnValueAt(oriX,oriY,img);
%   newImg = returnValueAt(newMeshX,newMeshY,img);
    
    
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;

end
function newImg = pure_scale_image(X,Y,img,factor)
%scales the image by a factor
%Arguments:
%           X coordinate Array
%           Y coordinate Array
%           image values
%           Scale Factor
    newImg = rescale_image(factor,factor,X,Y,img);
end

function newImg = translate_image(X,Y,offsetX,offsetY,img)
%Translate an image.
%Arguments:
%           X coordinates
%           Y coordinates
%           offset of X
%           offset of Y
%           image values

    newX = X - offsetX; %math for the offsets
    newY = Y - offsetY;

    sizeOfImage = size(img); %get size of the image
    sizeOriX = sizeOfImage(2);
    sizeOriY = sizeOfImage(1);
    
    [outOfArrayX, oriX] = findOutOfRange(newX,1,sizeOriX); %find points of the image that are now out of range
    [outOfArrayY, oriY] = findOutOfRange(newY,1,sizeOriY);
    
    %get values at those points
    newImg = returnValueAt(oriX,oriY,img);
%   newImg = returnValueAt(newMeshX,newMeshY,img);
    
    
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
end

function newImg = rotate_image(X,Y,theta,img)
%Rotates an image by theta degrees
%Arguments:
%           X coordinates
%           Y coordinates
%           theta degrees for rotation
%           image values

    ct = cos(theta*pi/180); st = sin(theta*pi/180);
    rotX = X;
    rotY = Y;
    oriX = rotX.*ct + rotY.* st; %inverse rotation matrix to map rotated image to original 
    oriY = -rotX.*st + rotY.*ct;
    
    %% WIP shifting to fit whole image
    %[shiftX,shiftY] = refit(oriX,oriY);
    %
    %oriX = shiftX.*ct + shiftY.* st; %inverse rotation matrix to map rotated image to original 
    %oriY = -shiftX.*st + shiftY.*ct;
    
    sizeOfImage = size(img);
    sizeOriX = sizeOfImage(2);
    sizeOriY = sizeOfImage(1);
    
%     maximglengh = sqrt(sizeOriX.^2+sizeOriY.^2);
%     [newMeshX, newMeshY] = meshgrid(1:ceil(maximglengh),1:ceil(maximglengh));
%     
%     imgtheta = atan(sizeOriX/sizeOriY);
%     offset = sizeOriY*cos(imgtheta);
%     newMeshX = newMeshX - offset;
    
    
    %%
    [outOfArrayX, oriX] = findOutOfRange(oriX,1,sizeOriX);
    [outOfArrayY, oriY] = findOutOfRange(oriY,1,sizeOriY);
    
    %get values at those points
    newImg = returnValueAt(oriX,oriY,img);
%   newImg = returnValueAt(newMeshX,newMeshY,img);
    
    
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
    
end

function newImg = shear_imageX(X,Y,shear_factorX,shear_factorY,img,shearX,shearY)
%shears the image,
%arguments:
%           Coordinate Array of X
%           Coordinate Array of Y
%           Shear factor for X dimension
%           Shear factor for Y dimension
%           original img
%           1 - shear X, 0 - dont shear X 
%           1 - shear Y, 0 - dont shear Y
    if shearX > 0 %checks for the boolean to shear X
        newX = X + shear_factorX.*Y;
    else
        newX = X;
    end
    
    if shearY > 0 %checks for the boolean to shear Y
        newY = Y + shear_factorY.*X;
    else
        newY = Y;
    end
    
    sizeOfImage = size(img);
    sizeOriX = sizeOfImage(2);
    sizeOriY = sizeOfImage(1);
    
    [outOfArrayX, oriX] = findOutOfRange(newX,1,sizeOriX);
    [outOfArrayY, oriY] = findOutOfRange(newY,1,sizeOriY);
    
    %get values at those points
    newImg = returnValueAt(oriX,oriY,img);
%   newImg = returnValueAt(newMeshX,newMeshY,img);
    
    
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
    
end

function newImg = compress_rt(X,Y,img)
    newX = sqrt((abs(X)).^2+abs(Y).^2);
    newY = sqrt((abs(Y)).^2+abs(X).^2);
    
    sizeOfImage = size(img);
    sizeOriX = sizeOfImage(2);
    sizeOriY = sizeOfImage(1);
    
    [outOfArrayX, oriX] = findOutOfRange(newX,1,sizeOriX);
    [outOfArrayY, oriY] = findOutOfRange(newY,1,sizeOriY);
    
    %get values at those points
    newImg = returnValueAt(oriX,oriY,img);
%   newImg = returnValueAt(newMeshX,newMeshY,img);
    
    
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
end

function newImg = twoXoverY(X,Y,img)
    newX = 2.*X./Y;
    newY = 2.*Y./X;
    
    sizeOfImage = size(img);
    sizeOriX = sizeOfImage(2);
    sizeOriY = sizeOfImage(1);
    
    [outOfArrayX, oriX] = findOutOfRange(newX,1,sizeOriX);
    [outOfArrayY, oriY] = findOutOfRange(newY,1,sizeOriY);
    
    %get values at those points
    newImg = returnValueAt(oriX,oriY,img);
%   newImg = returnValueAt(newMeshX,newMeshY,img);
    
    
    %fill in out of range values with 0s    
    newImg(outOfArrayX) = 0;
    newImg(outOfArrayY) = 0;
end

function [newMeshX, newMeshY] = refit(X,Y)
    %not used, WIP for fitting the image back into the display
    sizeNewX = max(max(X)) - min(min(X));
    sizeNewY = max(max(Y)) - min(min(Y));
    
    [newMeshX, newMeshY] = meshgrid(linspace(floor(min(X)),ceil(max(X)),sizeNewX),linspace(floor(min(Y)),ceil(max(Y)),sizeNewY));
end

function [log_array_OOR, modifiedArray] = findOutOfRange(array,minSize,maxSize)
% finds values after transformation that fall ouside of the original image.
% returns the cells that fall outsie in log_array_OOR, modifies the
% coordiate array "array" to bring those out of range numbers to the edge
% of the original image. minSize and maxSize are the values of the min and
% max index of the array.
%Arguments:
%           coordinate array
%           minimum index of the image
%           maximum index of the array
    log_array_OOR = (array > maxSize | array < minSize);
    array(array<minSize) = minSize;
    array(array>maxSize) = maxSize;
    modifiedArray = array;
end

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
maxXsize = size(lowX);
maxYsize = size(lowY);

lowX(lowX<1) = 1;
highX(highX> maxXsize(2)) = maxXsize(2) ;
lowY(lowY<1) = 1;
highY(highY> maxYsize(1)) = maxYsize(1);


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
value = returnValueAt_rescale(newXArray,newYArray,img);
end

function [xy, x1y, xy1, x1y1] = getSampleValues_rescale(xValue,yValue,img);
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
function value = returnValueAt_rescale(xValue,yValue,img);
% returns the value at a coordinate in the image, interpolates if needed
    [xyWeight, x1yWeight, xy1Weight, x1y1Weight] = findWeights2D(xValue,yValue); %get the weights for interpolation
    [sample_xy, sample_x1y, sample_xy1, sample_x1y1] = getSampleValues_rescale(xValue,yValue,img); %gets the values from the points around the interpolation point
    value = xyWeight.*sample_xy + x1yWeight.*sample_x1y + xy1Weight.*sample_xy1 + x1y1Weight.*sample_x1y1; %calculate interpolated value
end
