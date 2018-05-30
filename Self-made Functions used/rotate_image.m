function newImg = rotate_image(X,Y,theta,img)
%Rotates an image by theta degrees
%Arguments:
%           X coordinates (Meshgrid)
%           Y coordinates (Meshgrid)
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

