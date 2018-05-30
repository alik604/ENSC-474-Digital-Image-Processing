function eucdistancetable = calcEucDist(vectorarray)
%calculates the euclidian distance of images arranged as a column vector in
%vectorarray

%gets size of vectorarray for creation of datatable.
sizeofarray = size(vectorarray);
sizeofarray = sizeofarray(2)+1;
eucdistancetable = cell(sizeofarray);
eucdistancetable{1,1} = ' ';

for ii = 2:sizeofarray %writing headers into datatable
    string = ['Image ' (num2str(ii-1))];
    eucdistancetable{ii,1} = string;
end
for ii = 2:sizeofarray %writing headers into datatable
    string = ['Image ' (num2str(ii-1))];
    eucdistancetable{1,ii} = string;
end

for ii = 1:sizeofarray-1 %calculation of euclidian distance
    for jj = 1:sizeofarray-1
        difference = vectorarray(:,ii) - vectorarray(:,jj);
        squared = difference.^2;
        distance = sqrt(sum(squared));
        eucdistancetable{ii+1,jj+1} = distance;
    end
end
end