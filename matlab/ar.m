close all;
clear all;

img = imread('../data/cv_cover.jpg');
video1 = loadVid("../data/ar_source.mov");
video2 = loadVid("../data/book.mov");

for i = 1:size(video1,2)
    [locs1, locs2] = matchPics(img, video2(i).cdata, 'surf');
    [H, ~] = computeH_ransac(locs1, locs2);
    cropped_img = video1(i).cdata(50:260, 50:500, :);
    scaled_img = imresize(cropped_img, [size(img, 1) size(img, 2)]);
    video1(i).cdata = compositeH(inv(H), scaled_img, video2(i).cdata);
end

result = VideoWriter('../results/5_vid.avi','Motion JPEG AVI');

open(result)

for i = 1:size(video1, 2)
    writeVideo(result, video1(i).cdata);
end

close(result)