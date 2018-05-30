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
