close all;
clear all;

% read image and convert to grayscale, if necessary
img_input = imread('../data/cv_cover.jpg');
if ndims(img_input) == 3
    img_input = rgb2gray(img_input);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BRIEF method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute features and descriptors
points1 = detectFASTFeatures(img_input);
[points1, loc1] = computeBrief(img_input, points1.Location);

count = zeros(1, 36, "double");
for i = 0:36

    % rotate image
    img_rot = imrotate(img_input, i * 10);

    % compute features and descriptors of rotated image
    points2 = detectFASTFeatures(img_rot);
    [points2, loc2] = computeBrief(img_rot, points2.Location);

    % match features between non-rotated and rotated image
    indexPairs = matchFeatures(points1, points2, 'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    matchedPoints2 = loc2(indexPairs(:, 2), :);

    % update histogram
    count(i + 1) = size(indexPairs(:,1), 1);

    % display feature matching results at three different orientations
    if i == 6 || i == 12 || i == 18
        matchedPoints1 = loc1(indexPairs(:, 1), :);
        f = figure();
        showMatchedFeatures(img_input, img_rot, matchedPoints1, matchedPoints2, 'montage');
        if i == 6
            saveas(f, '../results/4_2_brief_rot1.png')
        elseif i == 12
            saveas(f, '../results/4_2_brief_rot2.png')
        elseif i == 18
            saveas(f, '../results/4_2_brief_rot3.png')
        end
    end
end

% display histogram
f = figure();
bar(count);
saveas(f, '../results/4_2_brief_hist.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SURF method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute features and descriptors
points1 = detectSURFFeatures(img_input);
[points1, loc1] = extractFeatures(img_input, points1.Location, "Method", "SURF");

count = zeros(1, 36, "double");
for i = 0:36

    % rotate image
    img_rot = imrotate(img_input, i * 10);

    % compute features and descriptors
    points2 = detectSURFFeatures(img_rot);
    [points2, loc2] = extractFeatures(img_rot, points2.Location, "Method", "SURF");

    % match features between non-rotated and rotated image
    indexPairs = matchFeatures(points1, points2, 'MatchThreshold', 10.0);
    matchedPoints2 = loc2(indexPairs(:, 2), :);

    % update histogram
    count(i + 1) = size(indexPairs(:,1), 1);

    % displaying feature matching results at three different orientations
    if i == 6 || i == 12 || i == 18
        matchedPoints1 = loc1(indexPairs(:, 1), :);
        f = figure();
        showMatchedFeatures(img_input, img_rot, matchedPoints1, matchedPoints2, 'montage');
        if i == 6
            saveas(f, '../results/4_2_surf_rot1.png')
        elseif i == 12
            saveas(f, '../results/4_2_surf_rot2.png')
        elseif i == 18
            saveas(f, '../results/4_2_surf_rot3.png')
        end
    end
end

% display histogram
f = figure();
bar(count);
saveas(f, '../results/4_2_surf_hist.png')