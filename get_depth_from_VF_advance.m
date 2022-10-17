function image = get_depth_from_VF_advance(V, F, viewer, lookat, lookup, worldsize, imagesize)
%
lookleft = cross(lookat, lookup);
lookat = lookat / norm(lookat);
lookup = lookup / norm(lookup);
lookleft = lookleft / norm(lookleft);
image = zeros(imagesize(1), imagesize(2));
nearest = zeros(imagesize(1), imagesize(2));
xunit = worldsize(1) / (imagesize(1) - 1);
yunit = worldsize(2) / (imagesize(2) - 1);
for ii = 1:imagesize(1)
    for jj = 1:imagesize(2)
        nearest(ii, jj) = Inf;
    end
end
for ii = 1:size(F,1)
    t1 = V(F(ii, 1),:);
    t2 = V(F(ii, 2),:);
    t3 = V(F(ii, 3),:);
    [isIntersect1, p1] = point_radial_intersect_square(t1, -lookat, viewer, lookup, lookleft, worldsize);
    [isIntersect2, p2] = point_radial_intersect_square(t2, -lookat, viewer, lookup, lookleft, worldsize);
    [isIntersect3, p3] = point_radial_intersect_square(t3, -lookat, viewer, lookup, lookleft, worldsize);
    if det([p1-p2;p3-p2]) == 0
        continue;
    end
    points = triangle_intersect_mesh_square(p1, p2, p3, worldsize, imagesize);
    for jj = 1:size(points, 1)
        curcoo = [(points(jj, 1)-1) * xunit - worldsize(1) / 2,...
            (points(jj, 2)-1) * yunit - worldsize(2) / 2];
        vector1 = p2 - p1;
        vector2 = p3 - p1;
        vector = curcoo - p1;
        cof = linsolve([vector1', vector2'], vector');
        curpos = viewer + curcoo(1)*lookup + curcoo(2)*lookleft;
        
        intersectpos = t1 + cof(1) * (t2 - t1) + cof(2) * (t3 - t1);
        distance = norm(curpos - intersectpos);
        %[isIntersect, distance] = point_radial_intersect_triangle(curpos, lookat, t1, t2, t3);
        %isIntersect        
        if distance < nearest(points(jj,1), points(jj,2))
            nearest(points(jj,1), points(jj,2)) = distance;
        end
    end
end
% maxdistance = max(max(nearest(nearest ~= Inf)));
% for ii = 1:imagesize(1)
%     for jj = 1:imagesize(2)
%         if nearest(ii, jj) == Inf
%             image(ii, jj) = 0;
%         else
%             image(ii, jj) = maxdistance - nearest(ii, jj);
%         end
%     end
% end
image = nearest;
maxdistance = max(image(image < Inf));
for ii = 1:imagesize(1)
    for jj = 1:imagesize(2)
        if image(ii, jj) ~= Inf
            image(ii, jj) = maxdistance - image(ii, jj);
        else
            image(ii, jj) = 0;
        end
    end
end
end

