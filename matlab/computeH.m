function [H2to1] = computeH(x1, x2)
% reference: https://www.mathworks.com/matlabcentral/answers/26141-homography-matrix
% reference: https://www.youtube.com/watch?v=l_qjO4cM74o
% reference: discussed with colleagues

sx = x1(:, 1); 
sy = x1(:, 2); 
dx = x2(:, 1); 
dy = x2(:, 2);
A = [];

for i = 1:size(sx, 1)
    A = cat(1, A, [sx(i), sy(i), 1, 0, 0, 0, -dx(i) .* sx(i), -dx(i) .* sy(i), -dx(i)]);
    A = cat(1, A, [0, 0, 0, sx(i), sy(i), 1, -dy(i) .* sx(i), -dy(i) .* sy(i), -dy(i)]);
end

[V, D] = eig(A'*A);

d_list = diag(D);
[~, I] = min(d_list);
H2to1 = reshape(V(:, I), 3, 3)';
end