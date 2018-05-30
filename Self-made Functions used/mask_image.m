function [ output_image ] = mask_image(mask, image)
%masks an image with the specified mask
%   Detailed explanation goes here

%first step is to allow for boundary conditions by padding the array
[size_of_mask_rows, size_of_mask_columns] = size(mask);
size_to_pad_rows = floor(size_of_mask_rows/2);
size_to_pad_columns = floor(size_of_mask_columns/2);
% padded_image = padarray(image,[size_to_pad_rows, size_to_pad_columns],'symmetric'); %placeholder cause someone asked about padarray and then prof said write your own. >.>
padded_image = Padding(image,size_to_pad_rows,size_to_pad_columns);
%create new array in which to store the image after applying the mask.
size_ori = size(image);
output_image = zeros(size_ori(1),size_ori(2));

maskXstart = -size_to_pad_columns;
maskYstart = -size_to_pad_rows;
maskXend = size_to_pad_columns;
maskYend = size_to_pad_rows;

flipped_mask = mask';

for y = 1:size_ori(1)
    for x = 1:size_ori(2)
        maskindex = 1;
        total = 0;
        for maskx = maskXstart:maskXend
            for masky = maskYstart:maskYend
                total = total + padded_image(y+masky+size_to_pad_rows,x+maskx+size_to_pad_columns).*flipped_mask(maskindex);
                maskindex = maskindex+1;
            end
        end
        output_image(y,x) = total;   
    end
end

end

