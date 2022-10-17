function Z = restore_bad(X, Y, Z0, INT, background, Clocal, normal, ind)
%根据非坏边的值插值修复坏边点值
m = size(Z0, 1);
seq_odd = [1, m + 1, -m, 0, m, -1, m - 1];
seq_oven = [-m + 1, 1, -m, 0, m, -m - 1, -1];
background = background(:);
for ii = 1:length(background)
    if Z0(background(ii)) > 10e-3
        pos = [X(background(ii)), Y(background(ii))];
        bias = repmat(pos, length(INT), 1) - [X(INT), Y(INT)];
        bias_norm = zeros(size(bias, 1), 1);
        for jj = 1:length(size(bias, 1))
            bias_norm(jj) = norm(bias_norm(jj,:));
        end
        [~, minseq] = min(bias_norm);
        minseq = minseq(1);
        if mod(mod(minseq, m),2) == 1
            values = Z0(INT(minseq) + seq_odd);
            h = Clocal * values;
            g = normal * values;
            c = ind * values;
            temp_vec2 = bias(minseq,:);
            Z0(background(ii)) = h(1) * (temp_vec2(1)^2) / 2 + h(2) * (temp_vec2(2)^2) / 2 ...
            + h(3) * (temp_vec2(1) * temp_vec2(2)) + g(1) * temp_vec2(1) + g(2) * temp_vec2(2) + c;
        else
            values = Z0(INT(minseq) + seq_oven);
            h = Clocal * values;
            g = normal * values;
            c = ind * values;
            temp_vec2 = bias(minseq,:);
            Z0(background(ii)) = h(1) * (temp_vec2(1)^2) / 2 + h(2) * (temp_vec2(2)^2) / 2 ...
            + h(3) * (temp_vec2(1) * temp_vec2(2)) + g(1) * temp_vec2(1) + g(2) * temp_vec2(2) + c;
        end
    end
end
Z = Z0;
end

