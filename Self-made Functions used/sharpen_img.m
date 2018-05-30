function [ output_img ] = sharpen_img( img ,konstant )
%SHARPEN_IMG Sharpens an image with unsharp masking
%   Unsharp masking blurs the image slighly, subtracts the difference with
%   some scaling factor konstant, thus producing a sharper image.
H4 = fspecial('gaussian',[5 5], 2);
Xg = imfilter(img, H4, 'symmetric', 'same');
[r3,c3,p3] = size(img);
Xg = double(Xg);
img = double(img);
for kk = 1:p3
    for ii = 1:r3
        for jj = 1:c3
            output_img(ii,jj,kk) = (konstant/(2.*konstant-1)).*(img(ii,jj,kk))-(((1-konstant)/(2.*konstant-1)).*(Xg(ii,jj,kk)));
        end
    end
end

end

