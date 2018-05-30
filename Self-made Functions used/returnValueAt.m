function value = returnValueAt(xValue,yValue,img);
% returns the value at a coordinate in the image, interpolates if needed
    [xyWeight, x1yWeight, xy1Weight, x1y1Weight] = findWeights2D(xValue,yValue); %get the weights for interpolation
    [sample_xy, sample_x1y, sample_xy1, sample_x1y1] = getSampleValues(xValue,yValue,img); %gets the values from the points around the interpolation point
    value = xyWeight.*sample_xy + x1yWeight.*sample_x1y + xy1Weight.*sample_xy1 + x1y1Weight.*sample_x1y1; %calculate interpolated value
end