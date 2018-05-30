function [ noisy_image, image_noise ] = gen_period_noise( input_picture,xweight,yweight, noise_weight )
%GEN_PERIOD_NOISE Generates periodic noise and outputs both the input with
%noise and just the noise, xweight and yweight are the parameters for the frequency of the noise 

%% Get size of image.
[sizey, sizex] = size(input_picture);
image_noise = zeros(sizey,sizex);


for xx = 1:sizex
    for yy = 1:sizey
        image_noise(yy,xx) = cos(2*pi*xweight*xx/sizex + 2*pi*yweight*yy/sizey);
    end
end

noisy_image = input_picture+noise_weight*image_noise;



end

