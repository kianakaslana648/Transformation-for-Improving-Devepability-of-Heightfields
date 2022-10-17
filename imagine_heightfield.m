function image = imagine_heightfield(imagesize)
%根据长宽给出一个函数构造的离散高度场
%这里考虑旋转抛物面z = max(1 - x^2 - y^2, 0) 以及区间[-1, 1] * [-1, 1]
m = imagesize(1);
n = imagesize(2);
delta_x = 2 / (m-1);
delta_y = 2 / (n-1);
X = -1:delta_x:1;
Y = -1:delta_y:1;
m = size(X,2);
n = size(Y,2);
image = zeros(m, n);
for ii = 1:m
    for jj = 1:n
        image(ii, jj) = max([1 - X(ii)^2 - Y(jj)^2, 0]);
    end
end
end