function [isIntersect, Intersection] = point_radial_intersect_square(point, radial, central, ...
    lookup, lookleft, worldsize)
%point发射射线radial与 中心为central长宽为worldsize的矩形相交
%worldsize(1)是lookup方向长度， worldsize（2）是lookleft方向长度
%isIntersect判断是否有交，Intersection表射线与该平面的交点在矩形坐标系中的坐标；
isIntersect = false;
Intersection = [NaN, NaN];
lookleft = lookleft / norm(lookleft);
lookup = lookup / norm(lookup);
A = [lookup', lookleft', -radial'];
B = (point - central)';
if det(A) ~= 0
    X = A \ B;
    if X(1) <= worldsize(1)/2 && X(2) <= worldsize(2)/2 && X(3) >= 0 &&...
            X(1) >= -worldsize(1)/2 && X(2) >= -worldsize(2)/2
        isIntersect = true;
    end 
    Intersection = [X(1), X(2)];
end
end

