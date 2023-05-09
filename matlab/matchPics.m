function [locs1, locs2] = matchPics(I1, I2, method)
    
% convert images to grayscale, if necessary
% NOTE: RGB-images are three-dimensional
if ndims(I1) == 3
    I1 = rgb2gray(I1);
end

if ndims(I2) == 3
    I2 = rgb2gray(I2);
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BRIEF method
% - parameter 'method' == 'brief'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(method, 'brief')
    % detect features in both images
    points1 = detectFASTFeatures(I1);
    points2 = detectFASTFeatures(I2);
    
    % obtain descriptors for the computed feature locations
    [corners1, loc1] = computeBrief(I1, points1.Location);
    [corners2, loc2] = computeBrief(I2, points2.Location);
    
    % match features using the descriptors
    indexPairs = matchFeatures(corners1, corners2, 'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    locs1 = loc1(indexPairs(:, 1), :);
    locs2 = loc2(indexPairs(:, 2), :);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SURF method
% - parameter 'method' == 'surf'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else 
    % detect features in both images
    points1 = detectSURFFeatures(I1);
    points2 = detectSURFFeatures(I2);

    % obtain descriptors for the computed feature locations
    [corners1, loc1] = extractFeatures(I1, points1.Location, 'Method', 'SURF');
    [corners2, loc2] = extractFeatures(I2, points2.Location, 'Method', 'SURF');

    % match features using the descriptors
    indexPairs = matchFeatures(corners1, corners2, 'MatchThreshold', 1.2, 'Method', 'Approximate', 'Unique', true);
    locs1 = double(ceil(loc1(indexPairs(:, 1)).Location));
    locs2 = double(ceil(loc2(indexPairs(:, 2)).Location));

end

end