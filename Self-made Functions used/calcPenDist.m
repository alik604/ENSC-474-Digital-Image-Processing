function pendistancetable = calcPenDist(vectorarray,mean,stddev)
%calculates the Penrose distance of images arranged as a column vector in
%vectorarray, their distances to the mean.

%gets size of vectorarray for creation of datatable.
sizeofarrayori = size(vectorarray);
sizeofarray = sizeofarrayori(2)+2;
pendistancetable = cell(sizeofarray);
pendistancetable{1,1} = ' ';

for ii = 2:sizeofarray %writing headers into datatable
    string = ['Image ' (num2str(ii-1))];
    pendistancetable{ii,1} = string;
end
string = ['Mean'];
pendistancetable{sizeofarray,1} = string;

for ii = 2:sizeofarray %writing headers into datatable
    string = ['Image ' (num2str(ii-1))];
    pendistancetable{1,ii} = string;
end
string = ['Mean'];
pendistancetable{1,sizeofarray} = string;

numofelements = numel(mean);
vectormean = reshape(mean,[numofelements,1]);
vectormeanarray = [vectorarray mean];

for ii = 1:sizeofarray-1 %calculation of penrose distance
    for jj = 1:sizeofarray-1
        difference = vectormeanarray(:,ii) - vectormeanarray(:,jj);
        difference = difference./((stddev+0.1).^2); %+0.1 for dealing with divided by zero
        squared = difference.^2;
        distance = sqrt(sum(squared));
        pendistancetable{ii+1,jj+1} = distance;
    end
end
end