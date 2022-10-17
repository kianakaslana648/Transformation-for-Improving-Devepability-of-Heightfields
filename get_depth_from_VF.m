function image = get_depth_from_VF(V, F, viewer, lookat, lookup, worldsize, imagesize)
%从顶点表V，边表F和观察者信息以及其他可控变量中获得高度场image
%viewer表观察者位置，lookat表观察者观察方向（相应投影平面垂直于观察方向）,lookup表向上方向；
%worldsize表观察者投影平面矩形的大小即长宽（viewer为矩形中心），imagesize表取样点数的长宽；
%从viewer所在取样平面的每个点发射射线（观察者方向）与模型每个面求交，若有交则image储存距离；
%若有多个交取距离最小值；若无交则为零

lookleft = cross(lookup, lookat);
lookat = normalize(lookat);
lookup = normalize(lookup);
lookleft = normalize(lookleft);
image = zeros(imagesize(1), imagesize(2));
for ii = 1:imagesize(1)
    for jj = 1:imagesize(2)
        [ii, jj]
        mindistance = Inf;
        curpos = viewer + lookleft * worldsize(1) / imagesize(1) * (ii - imagesize(1) / 2)...
            + lookup * worldsize(2) / imagesize(2) * (jj - imagesize(2) / 2);
        
        for kk = 1:size(F, 1)
            
            [isIntersect, distance] = point_radial_intersect_triangle(curpos, lookat,...
                V(F(kk, 1),:), V(F(kk, 2),:), V(F(kk, 3),:));
            if distance < mindistance
                mindistance = distance;
            end
        end
        image(ii, jj) = mindistance;
    end
end

maxdistance = max(image(image < Inf));
for ii = 1:imagesize(1)
    for jj = 1:imagesize(2)
        if image(ii, jj) < Inf
            image(ii, jj) = maxdistance -  image(ii, jj);
            if image(ii, jj) < 10e-3
                image(ii, jj) = 0;
            end
        elseif image(ii, jj) == Inf
            image(ii, jj) = 0;
        end
    end
end

end

