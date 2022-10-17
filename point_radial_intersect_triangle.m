function [isIntersect, distance] = point_radial_intersect_triangle(point, radial, p1, p2, p3)
%从point出发以radial为方向的射线与三个顶点为p1，p2，p3的三角形是否有交，若有则求出距离

isIntersect = false;
distance = Inf;
%%视点到未知交点的向量与lookat向量以及向量(1,1,1)共线，其组成矩阵的行列式为零，若满足三角形每个点的
%%权重a,b,c使得a+b+c=1; a,b,c>=0则需下列第一层判断条件，是一个快速排除的过程；
judge = [p2 - p1; p3 - p1; radial];
%%judge非奇异确保结果稳定
if det(judge) ~= 0
    A = [(p2 - p1)', (p3 - p1)', -radial'];
    B = (point - p1)';
    X = linsolve(A, B);
    %[X(1), X(2), X(3)]
    if X(1) >= 0 && X(2) >=0 && X(1) + X(2) <= 1 && X(3) > 0
        isIntersect = true;
        distance = norm(X(1) * (p2 - p1) + X(2) * (p3 - p1) + p1 - point);
    end
end

end

