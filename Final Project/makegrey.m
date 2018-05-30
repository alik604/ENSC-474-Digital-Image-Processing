function makegrey(picturename)
% picture1 = read_photos([picturename '.jpg']);
picture1 = read_photos([picturename '.png']);
write_photos(picture1, [picturename 'grey.jpg'],[picturename '.jpg']);
end




function photos = read_photos(file_name)
    % creates
    photo = imread(file_name);
    figure('Name', file_name); %shows image in a new window
    imshow(photo);
    photo_var = double(photo);
    photos = mat2gray(photo_var); %maps intensity between 0 - 1
    photos = mean(photo_var,3); %averages RGB colour channels
end

function write_photos(var_name,save_name,fig_name)
    photos = mat2gray(var_name);%maps intensity between 0 - 1. -tives mapped as black +tive as white. 0 are grey.
    photos = im2uint8(photos); %cast to be able to write to .jpg
    imwrite(photos,save_name);
    figure('Name', fig_name); %shows image in a new window
    imshow(photos);
    %imshow(var_name,[min(var_name(:)) max(var_name(:))]);
end