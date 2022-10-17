function [V, F] = XYZ_to_VF(X, Y, Z, name)
%从X， Y， Z转化到V， F   
m = size(X, 1);
n = size(X, 2);
if strcmp(name,'hex')
    %求V
    V = [X(:), Y(:), Z(:)];
    
    %求F
    F = [];
    if mod(m, 2) == 1
        for ii = 1:(n-1)
            for jj = 2:2:(m-1)
                F = [F; (ii - 1) * m + jj, (ii - 1) * m + jj - 1, ii * m + jj; ...
                    (ii - 1) * m + jj, (ii - 1) * m + jj + 1, ii * m + jj];
            end
            for jj = 2:2:(m-1)
                F = [F; (ii - 1) * m + jj - 1, ii * m + jj - 1, ii * m + jj;...
                    (ii - 1) * m + jj + 1, ii * m + jj + 1, ii * m + jj];
            end
        end
    else
        for ii = 1:(n-1)
            for jj = 2:2:(m-2)
                F = [F; (ii - 1) * m + jj, (ii - 1) * m + jj - 1, ii * m + jj; ...
                    (ii - 1) * m + jj, (ii - 1) * m + jj + 1, ii * m + jj];
            end
            F = [F; (ii - 1) * m + m, (ii - 1) * m + m - 1, ii * m + m];
            for jj = 2:2:(m-2)
                F = [F; (ii - 1) * m + jj - 1, ii * m + jj - 1, ii * m + jj;...
                    (ii - 1) * m + jj + 1, ii * m + jj + 1, ii * m + jj];
            end
            F = [F; (ii - 1) * m + m - 1, ii * m + m - 1, ii * m + m];
        end
    end
elseif strcmp(name,'squad')
    %求V
    V = [X(:), Y(:), Z(:)];
    
    %求F
    F = [];
    for ii = 1:(n-1)
        for jj = 1:(m-1)
            F = [F;(ii-1)*m+jj, (ii-1)*m+jj+1, ii*m+jj;...
                (ii-1)*m+jj+1, ii*m+jj, ii*m+jj+1];
        end
    end
end

end

