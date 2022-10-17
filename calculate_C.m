function  [C, C_local, normal, ind] = calculate_C(Z, h, INT)
%计算全局C矩阵
m = size(Z, 1);
n = size(Z, 2);
[C_local, normal, ind] = calculate_Clocal(h);
C_value = repmat(C_local, length(INT),1);
I = [1, 2, 3, 4];
C_I = [];
for ii = 1:length(INT)
    C_I = [C_I; repmat((I + 4 * INT(ii) - 4)', 1, 7) ];
end
J_odd = [1, m + 1, -m, 0, m, -1, m - 1];
J_oven = [-m + 1, 1, -m, 0, m, -m - 1, -1];
C_J = [];
for jj = 1:length(INT)
    if mod(mod(INT(jj),m),2) == 1
        C_J = [C_J; repmat(INT(jj) + J_odd, 4, 1)];
    else
        C_J = [C_J; repmat(INT(jj) + J_oven, 4, 1)];
    end
end
C = sparse(C_I, C_J, C_value, 4 * m * n, m * n);
end

