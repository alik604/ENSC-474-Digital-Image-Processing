function [ output_array ] = Padding(input_array, numRowsToAdd, numColsToAdd)
%PADDING Pads the array 
%   I was done with the assignment too until someone asked that question
%   and I had to write this... can you not. People have midterms and stuff.

[size_of_array_rows, size_of_array_columns] = size(input_array);

output_array = zeros(size_of_array_rows+2*numRowsToAdd, size_of_array_columns+2*numColsToAdd);

for y = 1:size_of_array_rows;
    for x = 1:size_of_array_columns;
        output_array(y+numRowsToAdd,x+numColsToAdd) = input_array(y,x);
        
    end
end

end

