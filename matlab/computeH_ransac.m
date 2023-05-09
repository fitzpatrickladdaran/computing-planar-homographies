function [bestH2to1, inliers] = computeH_ransac(locs1, locs2)

threshold = 100;
n_highest = 0;

% compute 500 homographies H
for i = 1:500
    n = 0;                                  % number of inlier in this iteration
    idxs = randperm(size(locs1, 1), 4);     % sampling 4 random points
    sample1 = locs1(idxs, :);               % sample from locs1
    sample2 = locs2(idxs, :);               % sample from locs2
    h = computeH_norm(sample1, sample2);    % calculating homography
    
    % obtain predicted coordinates 
    p = [locs1, ones(size(locs1, 1), 1)];  
    pred = h * p';
    pred = pred./pred(3,:);
    pred = pred.';
    pred = pred(:, 1:2);

    % calculate errors 
    diff = abs(pred - locs2);
    dist = sum(diff.^2, 2);

    % check if a pair of coordinates are inliers
    for j = 1:size(dist,1)
        if dist(j) < threshold
            n = n + 1;
        end
    end

    % tracking best H
    if n_highest < n
        n_highest = n;
        H = h;
        ii = sample1;
    end
end

bestH2to1 = H;
inliers = ii;
end