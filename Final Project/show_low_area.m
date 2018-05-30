function show_low_area(img,count,mean_value, std_dev, string)
%SHOW_LOW_AREA Displays the area in an image where the value is lower than
% mean - stddev
%   Detailed explanation goes here
%logical array for the bad area
count = flipud(count);

bad_area = zeros(size(img));
bad_area(count < (ceil(mean_value - std_dev))) = 0.5;

figure();
imshow(img, 'InitialMag', 'fit') 
% Make a truecolor all-red image. 
red = cat(3, ones(size(img)),zeros(size(img)),zeros(size(img))); 
hold on 
h = imshow(red); 
title(['Areas with low ', string]);
hold off 

% figure();
% imagesc(count);
% title('counts of area');

% Use our influence map as the 
% AlphaData for the solid red image. 
set(h, 'AlphaData', bad_area); 

end

