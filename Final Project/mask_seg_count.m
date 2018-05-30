function [ output_image_L ] = mask_seg_count(mask, image_L)
%counts the number of segments in the image_L based on mask. 
%   Detailed explanation goes here

%first step is to allow for boundary conditions by padding the array

[size_of_mask_rows, size_of_mask_columns] = size(mask);
if rem(size_of_mask_rows,2) == 0 
    size_of_mask_rows = size_of_mask_rows - 1;
else if rem(size_of_mask_columns,2) == 0
        size_of_mask_columns = size_of_mask_columns -1;
    end
end

% image_L = mat2gray(image_L); %for attempt 2.

size_to_pad_rows = floor(size_of_mask_rows/2);
size_to_pad_columns = floor(size_of_mask_columns/2);
% padded_image_L = gpuArray(padarray(image_L,[size_to_pad_rows, size_to_pad_columns],'symmetric')); %placeholder cause someone asked about padarray and then prof said write your own. >.>
padded_image_L = padarray(image_L,[size_to_pad_rows, size_to_pad_columns],'symmetric'); %No GPU
% padded_image_L = Padding(image_L,size_to_pad_rows,size_to_pad_columns);
%create new array in which to store the image_L after applying the mask.
size_ori = size(image_L);
output_image_L = zeros(size_ori(1),size_ori(2));

maskXstart = -size_to_pad_columns;
maskYstart = -size_to_pad_rows;
maskXend = size_to_pad_columns;
maskYend = size_to_pad_rows;

flipped_mask = mask';

%% works but is slow. takes the Labeled image_L. (101*101 takes 16.669s with for loop)
tic;
total(size_ori(1),size_ori(2),2)= 0;
for y = 1:size_ori(1)
    parfor x = 1:size_ori(2)
        total(y,x,:) = (size(unique(padded_image_L(y:y+2*size_to_pad_rows,x:x+2*size_to_pad_columns))))-1; %gets the number of segments in the area
    end
    if rem(y,10)==0 %progress bar since slow code, nice to have so you know code is working.
        current_process = [num2str(y/size_ori(1)*100) '% done']
    end
    
end
output_image_L(:,:) = flipud(total(:,:,1));  %flipping is for display later in graph. 
toc;
%% takes the high contrast image in rather than image label. Hopefully faster. NOPE NOT FASTER ='( (101*101 takes 21.239s with for loop)
% tic
% total(size_ori(1),size_ori(2),2)= 0;
% for y = 1:size_ori(1)
%     for x = 1:size_ori(2)
%         L = bwlabel(padded_image_L(y:y+2*size_to_pad_rows,x:x+2*size_to_pad_columns),4);
%         total(y,x,:) = size(unique(L))-1;
%     end
% end
% output_image_L(:,:) = total(:,:,1);
% toc
end

