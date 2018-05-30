function [ region_num, region_means ] = my_kmean_exp( matrix, number_of_regions,limit)
%MY_KMEAN calculates the kmean of a bunch of points with a number of
%regions.
%   Detailed explanation goes here



%initial assignment of membership.
%% Preselected Initial Clusters (evenly distributed)
% %initial assignment of means.
% size_of_matrix = size(matrix);
% [xArray, yArray] = meshgrid(1:size_of_matrix(1),1:size_of_matrix(2));
% 
% region_step = max(max(matrix))/number_of_regions;
% current_region_step = 0;
% 
% %preallocation
% % region_means = zeros(number_of_regions,1);  
% new_membership = zeros(size_of_matrix(1),size_of_matrix(2),number_of_regions);
% 
% for ii = 1:number_of_regions
%     region_init_borders(ii,1) = current_region_step;
%     region_init_borders(ii,2) = current_region_step+region_step;
%     current_region_step = current_region_step+region_step;
%     mean(ii) = (region_init_borders(ii,1) + region_init_borders(ii,2))/2;
% end
% 
% membership = zeros(size_of_matrix(1),size_of_matrix(2),number_of_regions);
% 
% for kk = 1:number_of_regions
%    membership(:,:,kk) = (matrix(:,:) > region_init_borders(kk,1) & matrix(:,:) < region_init_borders(kk,2));  
% %     membership(:,:,:) = 1/number_of_regions;
% end
% 
% % Initial Cluster Assignment
% figure('Name', 'Initial Assignment');
% for ii = 1:number_of_regions
%     subplot(1,number_of_regions,ii);
%     imshow(membership(:,:,ii));
%     title(['K = ' num2str(ii)]);
% end

%% Random Initial Clusters.
% 
size_of_matrix = size(matrix);
[xArray, yArray] = meshgrid(1:size_of_matrix(1),1:size_of_matrix(2));

A=0;
B=1;
for kk = 1:number_of_regions
    membership(:,:,kk) = A + (B-A).*rand(size_of_matrix(1), size_of_matrix(2));
%     B = B - membership(:,:,kk);
end

%assign membership to cluster based on highest previous membership

prev_max = zeros(size_of_matrix(1), size_of_matrix(2));
cluster = zeros(size_of_matrix(1), size_of_matrix(2),number_of_regions);
for ii = 1:size_of_matrix(1)
    for jj = 1:size_of_matrix(2)
        for kk = 1:number_of_regions
            if prev_max(ii,jj) < membership(ii,jj,kk)
                prev_max(ii,jj) = membership(ii,jj,kk);
                cluster(ii,jj,:) = 0;
                cluster(ii,jj,kk) = 1;
            end
        end
    end
end

% Initial Cluster Assignment
figure('Name', 'Initial Assignment');
for ii = 1:number_of_regions
    subplot(1,number_of_regions,ii);
    imshow(cluster(:,:,ii));
    title(['K = ' num2str(ii)]);
end

%%
old_membership = membership;

flag = false;
count = 0;

while flag == false
    
%find cluster means 
% matrix.*cluster(:,:,kk);
flag = true;

for kk = 1:number_of_regions
    cluster_mean(kk) = sum(sum(matrix.*old_membership(:,:,kk)))/sum(sum(old_membership(:,:,kk)));
end


%find distances

% distance = zeros(size_of_matrix(1),size_of_matrix(2),number_of_regions);
% for ii = 1:size_of_matrix(1)
%     for jj = 1:size_of_matrix(2)
%         for kk = 1:number_of_regions
%             distance(ii,jj,kk) = (matrix(ii,jj) - cluster_mean(kk)).^2;
%         end
%     end
% end

for kk = 1:number_of_regions
    distance(:,:,kk) = (matrix(:,:) - cluster_mean(kk)).^2;
end


% calculate new membership

% for ii = 1:size_of_matrix(1)
%     for jj = 1:size_of_matrix(2)
%         for kk = 1:number_of_regions
%             new_membership(ii,jj,kk) = (distance(ii,jj,kk)/sum(distance(ii,jj,:)));
%             if abs(new_membership(ii,jj,kk) - old_membership(ii,jj,kk)) > 0.05
%                 flag = false;
%             end
%         end
%     end
% end

for kk = 1:number_of_regions
    new_membership(:,:,kk) = (distance(:,:,kk)./sum(distance(:,:,:),3));
    
end
if (sum(sum(abs(new_membership(:,:,kk) - old_membership(:,:,kk)) > 0.05))) > 0
        flag = false;
%         no_change_membership = 1
end

old_membership = new_membership;

count = count+1;
count_disp_rem = rem(count,20);
if count_disp_rem ==0
    count = count
end


if count < limit
    count_flag = false;
else
    count_flag = true;
end

flag = count_flag | flag; 

end

%assign membership to cluster based on highest previous membership

prev_max = zeros(size_of_matrix(1), size_of_matrix(2));
cluster = zeros(size_of_matrix(1), size_of_matrix(2),number_of_regions);
for ii = 1:size_of_matrix(1)
    for jj = 1:size_of_matrix(2)
        for kk = 1:number_of_regions
            if prev_max(ii,jj) < new_membership(ii,jj,kk)
                prev_max(ii,jj) = new_membership(ii,jj,kk);
                cluster(ii,jj,:) = 0;
                cluster(ii,jj,kk) = 1;
            end
        end
    end
end

% for kk = 1:number_of_regions
%     if prev_max(:,:) < new_membership(:,:,kk)
%         prev_max(:,:) = new_membership(:,:,kk);
%         cluster(:,:,:) = 0;
%         cluster(:,:,kk) = 1;
%     end
% end


for kk = 1:number_of_regions
%     arrayIndex = logical(cluster(:,:,kk));
%     reshapedIndex = reshape(arrayIndex, [1,numel(arrayIndex)]);
%     reshapedMatrix = reshape(matrix, [1,numel(matrix)]);
%     indexed_array = reshapedMatrix(reshapedIndex);


    region_means(kk) = sum(matrix(logical(cluster(:,:,kk))))/numel(matrix(logical(cluster(:,:,kk)))); 
end

region_num = cluster;

%%
count = count
end


