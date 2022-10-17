function reserve_C(C)
%将C矩阵记录下来，调试专用
fid = fopen('C.txt', 'wt');
if fid<0
    error('Cannot open C.txt');
end
m = size(C,1);
n = size(C,2);

fprintf(fid, '%s %s \r\n', C);
end

