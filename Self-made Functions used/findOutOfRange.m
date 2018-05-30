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

