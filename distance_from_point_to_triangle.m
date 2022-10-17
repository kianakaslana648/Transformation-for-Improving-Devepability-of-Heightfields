function distance = distance_from_point_to_triangle(point, p1, p2, p3)
vertical = cross(p2-p1,p3-p1);
vertical = vertical / norm(vertical);
vertical
distance = abs(dot(vertical, p1-point));
end

