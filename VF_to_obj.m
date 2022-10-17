function VF_to_obj(V, F, name)
%由顶点表V和边表F给出名为“name”的模型文件
fid = fopen(name, 'wt');
if fid<0
    error(['Cannot open ', name, '.']);
end
fprintf(fid, 'v %12.6f %12.6f %12.6f \r\n', V');
fprintf(fid, 'f %d %d %d \r\n', F');
fclose(fid);
end

