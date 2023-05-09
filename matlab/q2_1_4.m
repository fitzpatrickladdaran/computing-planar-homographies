close all;
clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 4.1
% - calls matchPics() with the BRIEF method
%
% NOTE: matchPics() has been modified to accept another parameter 'method'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[locs1_brief, locs2_brief] = matchPics(cv_cover, cv_desk, 'brief');

f = figure();
showMatchedFeatures(cv_cover, cv_desk, locs1_brief, locs2_brief, 'montage');
saveas(f, '../results/4_1.png')

p_brief = [locs1_brief, ones(size(locs1_brief, 1), 1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 4.2
% - calls matchPics() with the SURF method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[locs1_surf, locs2_surf] = matchPics(cv_cover, cv_desk, 'surf');

f = figure();
showMatchedFeatures(cv_cover, cv_desk, locs1_surf, locs2_surf, 'montage');
saveas(f, '../results/4_2_surf.png')

p_surf = [locs1_surf, ones(size(locs1_surf, 1), 1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTES:
% - method 'surf' detects more features, so we use the results from this
%   method for the remaining tasks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 4.3 
% - calculate homography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% BRIEF - shown here for visualization (report)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H2to1 = computeH(locs1_brief, locs2_brief);

% calculate predictions
p_pred = H2to1 * p_brief';
p_pred = p_pred./p_pred(3,:);
p_pred = p_pred';
p_pred = p_pred(:, 1:2);

f = figure();
showMatchedFeatures(cv_cover, cv_desk, locs1_brief, p_pred, 'montage');
saveas(f, '../results/4_3_brief.png')

% SURF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H2to1 = computeH(locs1_surf, locs2_surf);

% calculate predictions
p_pred = H2to1 * p_surf';
p_pred = p_pred./p_pred(3,:);
p_pred = p_pred';
p_pred = p_pred(:, 1:2);

f = figure();
showMatchedFeatures(cv_cover, cv_desk, locs1_surf, p_pred, 'montage');
saveas(f, '../results/4_3_surf.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 4.4 
% - calculate homography with normalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% BRIEF - shown here for visualization (report)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H2to1_normalized = computeH_norm(locs1_brief, locs2_brief);

% calculate predictions
p_pred = H2to1_normalized * p_brief';
p_pred = p_pred./p_pred(3,:);
p_pred = p_pred';
p_pred = p_pred(:, 1:2);

f = figure();
showMatchedFeatures(cv_cover, cv_desk, locs1_brief, p_pred, 'montage');
saveas(f, '../results/4_4_brief.png')

% SURF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H2to1_normalized = computeH_norm(locs1_surf, locs2_surf); 

% calculate predictions
p_pred = H2to1_normalized * p_surf';
p_pred = p_pred./p_pred(3,:);
p_pred = p_pred';
p_pred = p_pred(:, 1:2);

f = figure();
showMatchedFeatures(cv_cover, cv_desk, locs1_surf, p_pred, 'montage');
saveas(f, '../results/4_4_surf.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 4.5 
% - calculate homography using RANSAC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% BRIEF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[H2to1_ransac, inliers] = computeH_ransac(locs1_brief, locs2_brief);

% calculate predictions
p_pred = H2to1_ransac * p_brief';
p_pred = p_pred./p_pred(3,:);
p_pred = p_pred';
p_pred = p_pred(:, 1:2);

f = figure();
showMatchedFeatures(cv_cover, cv_desk, locs1_brief, p_pred, 'montage');
saveas(f, '../results/4_5_brief.png')

% SURF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[H2to1_ransac, inliers] = computeH_ransac(locs1_surf, locs2_surf);

% calculate predictions
p_pred = H2to1_ransac * p_surf';
p_pred = p_pred./p_pred(3,:);
p_pred = p_pred';
p_pred = p_pred(:, 1:2);

f = figure();
showMatchedFeatures(cv_cover, cv_desk, locs1_surf, p_pred, 'montage');
saveas(f, '../results/4_5_surf.png')