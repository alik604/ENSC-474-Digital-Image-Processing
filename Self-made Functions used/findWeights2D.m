function [xyWeight, x1yWeight, xy1Weight, x1y1Weight] = findWeights2D(xValue, yValue);
%finds the weight on two axises
[xLowWeight, xHighWeight] = findWeights1D(xValue);
[yLowWeight, yHighWeight] = findWeights1D(yValue);

%calculates the weight of an area (for 2D)
xyWeight = yHighWeight.*xHighWeight;
xy1Weight = yLowWeight.*xHighWeight;
x1yWeight = xLowWeight.*yHighWeight;
x1y1Weight = xLowWeight.*yLowWeight;
end 
