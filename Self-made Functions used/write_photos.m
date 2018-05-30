function write_photos(var_name,save_name,fig_name)
%writes a photo to a jpg file and shows it in an image. 
    photos = mat2gray(var_name);%maps intensity between 0 - 1. -tives mapped as black +tive as white. 0 are grey.
    photos = im2uint8(photos); %cast to be able to write to .jpg
    imwrite(photos,save_name);
    figure('Name', fig_name); %shows image in a new window
    imshow(photos);
    %imshow(var_name,[min(var_name(:)) max(var_name(:))]);
end