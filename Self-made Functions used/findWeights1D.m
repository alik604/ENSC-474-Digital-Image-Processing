function [floorWeight, ceilingWeight] = findWeights1D(value);
%finds the weightage on one axis
    floorWeight = floor(value);
    ceilingWeight = floorWeight+1;
    floorWeight = value - floorWeight;
    ceilingWeight = ceilingWeight - value ;
end
