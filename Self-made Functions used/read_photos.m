function photos = read_photos(file_name)
    % reads a photo into the variables.
    photo = imread(file_name);
    figure('Name', file_name); %shows image in a new window
    imshow(photo);
    photo_var = double(photo);
    photos = mat2gray(photo_var); %maps intensity between 0 - 1
%     photos = mean(photo_var,3); %averages RGB colour channels
end