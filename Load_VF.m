function [V,F] = Load_VF()
vid = fopen('vertex.txt', 'r');
fid = fopen('face.txt','r');
V = fscanf(vid,'%f %f %f\n',[3 Inf]);
F = fscanf(fid,'%d %d %d\n',[3 Inf]);
V = V';
F = F';
end

