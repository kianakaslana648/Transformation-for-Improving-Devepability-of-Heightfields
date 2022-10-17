function [V, F] = Load_obj(filename)
%加载名为"filename"的obj文件，给出顶点表V，边表F
fid = fopen(filename, 'r');
if fid<0
    error(['Cannot open ', filename, '.']);
end
V = [];
F = [];
while(1)
    temp_str = fgetl(fid);
    if ~ischar(temp_str)
        break;
    end
    if ~isempty(temp_str) && strcmp(temp_str(1), 'v')
        V(:,end + 1) = str2num(temp_str(3:end));
    end
    if ~isempty(temp_str) && strcmp(temp_str(1), 'f')
        F(:,end + 1) = str2num(temp_str(3:end));
    end
end
V = V';
F = F';
end

