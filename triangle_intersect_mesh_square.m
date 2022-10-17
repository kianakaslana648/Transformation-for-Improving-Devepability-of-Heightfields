function points = triangle_intersect_mesh_square(p1, p2, p3, ...
    worldsize, imagesize)
%p1, p2, p3表三角形三点在矩形坐标系中的坐标，均在矩形上，矩形中心为central，lookup，lookleft表两方向
%isIn为三元组，表示p1，p2，p3是否在矩形中
%%worldsize(1)是lookleft方向长度， worldsize(2)是lookup方向长度
%imagesize为相应长宽格点数
%points返回三角形与矩形内的格点
%
points = [];
xmin = max([min([p1(1), p2(1), p3(1)]), -worldsize(1)/2]);
xmax = min([max([p1(1), p2(1), p3(1)]), worldsize(1)/2]);
ymin = max([min([p1(2), p2(2), p3(2)]), -worldsize(2)/2]);
ymax = min([max([p1(2), p2(2), p3(2)]), worldsize(2)/2]);
%[xmin, xmax; ymin, ymax]
xunit = worldsize(1) / (imagesize(1) - 1);
yunit = worldsize(2) / (imagesize(2) - 1);
for ii = ceil((xmin + worldsize(1) / 2) / xunit) : floor((xmax + worldsize(1) / 2) / xunit)
    for jj = ceil((ymin + worldsize(2) / 2) / yunit) : floor((ymax + worldsize(2) / 2) / yunit)
        curpos = [ii * xunit - worldsize(1) / 2, jj * yunit - worldsize(2) / 2];
        if (((p2(2)-p1(2))*curpos(1)-(p2(1)-p1(1))*curpos(2)-p2(2)*p2(1)+p1(2)*p2(1)+p2(1)*p2(2)-p1(1)*p2(2))*...
            ((p2(2)-p1(2))*p3(1)-(p2(1)-p1(1))*p3(2)-p2(2)*p2(1)+p1(2)*p2(1)+p2(1)*p2(2)-p1(1)*p2(2)) >= 0 )&&...
           (((p3(2)-p2(2))*curpos(1)-(p3(1)-p2(1))*curpos(2)-p3(2)*p3(1)+p2(2)*p3(1)+p3(1)*p3(2)-p2(1)*p3(2))*...
            ((p3(2)-p2(2))*p1(1)-(p3(1)-p2(1))*p1(2)-p3(2)*p3(1)+p2(2)*p3(1)+p3(1)*p3(2)-p2(1)*p3(2)) >= 0 )&&...
            (((p1(2)-p3(2))*curpos(1)-(p1(1)-p3(1))*curpos(2)-p1(2)*p1(1)+p3(2)*p1(1)+p1(1)*p1(2)-p3(1)*p1(2))*...
            ((p1(2)-p3(2))*p2(1)-(p1(1)-p3(1))*p2(2)-p1(2)*p1(1)+p3(2)*p1(1)+p1(1)*p1(2)-p3(1)*p1(2)) >= 0)
        points = [points; ii+1, jj+1];
        end
    end
end
end

