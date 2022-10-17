function H = update_H(Z, U, C, INT, rho)
%求解argmin_H(||Hi||_ + rho / 2 * ||Hi - Cz + Ui||F^2)
C = sparse(C);
H = zeros(size(U, 1), 1);
G = C * Z - U;
for ii = 1:length(INT)
    Gi = [G(4 * INT(ii) - 3), G(4 * INT(ii) - 1); G(4 * INT(ii) - 1), G(4 * INT(ii) - 2)];
    [W, S, V] = svd(Gi);
    if S(1, 1) - 1 / rho > 0
        S(1, 1) = S(1, 1) - 1 / rho;
    elseif S(1, 1) + 1 / rho < 0
        S(1, 1) = S(1, 1) + 1 / rho;
    else
        S(1, 1) = 0;
    end
    
    if S(2, 2) - 1 / rho > 0
        S(2, 2) = S(2, 2) - 1 / rho;
    elseif S(2, 2) + 1 / rho < 0
        S(2, 2) = S(2, 2) + 1 / rho;
    else
        S(2, 2) = 0;
    end
    Hi = W * S * V';
    H(4 * INT(ii) - 3) = Hi(1, 1);
    H(4 * INT(ii) - 2) = Hi(2, 2);
    H(4 * INT(ii) - 1) = Hi(1, 2);
    H(4 * INT(ii)) = Hi(1, 2);
end
end